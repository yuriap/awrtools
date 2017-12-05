create or replace package body awrtools_reports as

    procedure set_filename_and_param_displ(p_report_id AWRCOMP_REPORTS.REPORT_ID%type, p_file_name varchar2, p_report_params_displ AWRCOMP_REPORTS.report_params_displ%type)
    is
    begin
      update AWRCOMP_REPORTS set FILE_NAME=p_file_name||'.html', report_params_displ=p_report_params_displ where report_id = p_report_id;
      commit;
    end;

    function create_report(p_report_type varchar2, p_proj_id AWRTOOLPROJECT.proj_id%type, p_copy_from AWRCOMP_REPORTS.REPORT_ID%type default null) return AWRCOMP_REPORTS.REPORT_ID%type
    is
      l_id number;
      l_report AWRCOMP_REPORTS%rowtype;
    begin
      if p_copy_from is null then
        INSERT INTO AWRCOMP_REPORTS ( REPORT_TYPE, REPORT_CONTENT, FILE_MIMETYPE, FILE_NAME,  PROJ_ID)
                             VALUES ((select dic_id from AWRCOMP_D_REPORT_TYPES where dic_value=p_report_type),empty_blob(),default,null, p_proj_id)
        returning report_id into l_id;
      else
        select REPORT_TYPE, FILE_MIMETYPE, PROJ_ID
          into l_report.REPORT_TYPE,
               l_report.FILE_MIMETYPE,
               l_report.PROJ_ID
          from AWRCOMP_REPORTS where report_id=p_copy_from;

        insert into AWRCOMP_REPORTS ( REPORT_TYPE, REPORT_CONTENT, FILE_MIMETYPE, FILE_NAME,  PROJ_ID)
          values ( l_report.REPORT_TYPE, empty_blob(), l_report.FILE_MIMETYPE, null,  l_report.PROJ_ID)
          returning report_id into l_id;

      end if;
      return l_id;
    end;

    function get_report_params_visibility(p_report_type varchar2, p_control_name varchar2) return boolean result_cache
    is
    begin
      case
        when p_report_type='AWRCOMP' and p_control_name in ('DB1','DB1_START_SNAP','DB1_END_SNAP','DB2','DB2_START_SNAP','DB2_END_SNAP','SORT','LIMIT','FILTER') then return true;
        when p_report_type='AWRSQLREPORT' and p_control_name in ('DB1','REMARK','SQL_ID') then return true;
        when p_report_type='AWRRPT' and p_control_name in ('DB1','DB1_START_SNAP','DB1_END_SNAP') then return true;
        when p_report_type='AWRGLOBALRPT' and p_control_name in ('DB1','DB1_START_SNAP','DB1_END_SNAP') then return true;
        when p_report_type='AWRSQRPT' and p_control_name in ('DB1','REMARK','SQL_ID','DB1_START_SNAP','DB1_END_SNAP') then return true;
        when p_report_type='AWRDIFF' and p_control_name in ('DB1','DB1_START_SNAP','DB1_END_SNAP','DB2','DB2_START_SNAP','DB2_END_SNAP') then return true;
        when p_report_type='AWRGLOBALDIFF' and p_control_name in ('DB1','DB1_START_SNAP','DB1_END_SNAP','DB2','DB2_START_SNAP','DB2_END_SNAP') then return true;
        when p_report_type='ASHRPT' and p_control_name in ('DB1','DB1_START_SNAP','DB1_END_SNAP') then return true;
        when p_report_type='ASHGLOBALRPT' and p_control_name in ('DB1','DB1_START_SNAP','DB1_END_SNAP') then return true;
        when p_report_type='ASHANALYTICS' and p_control_name in ('DB1','DB1_START_SNAP','DB1_END_SNAP','LEVEL','FILTER') then return true;
        else
          return false;
        end case;
    end;
--'DB1','DB1_START_SNAP','REMARK','DB1_END_SNAP','DB2','DB2_START_SNAP','DB2_END_SNAP','SORT','LIMIT','FILTER','SQL_ID'

    procedure save_param(p_report_id AWRCOMP_REPORTS.REPORT_ID%type, p_param_name varchar2, p_param_value varchar2)
    is
      l_report_type varchar2(100);
    begin
      select tp.DIC_VALUE into l_report_type from AWRCOMP_REPORTS r, awrcomp_d_report_types tp where report_id=p_report_id and tp.DIC_ID=report_type;
      if get_report_params_visibility(l_report_type,p_param_name) then
        merge into AWRCOMP_REPORTS_PARAMS using (select p_report_id id, upper(p_param_name) nm, p_param_value val from dual) src
           on (report_id=id and param_name=nm)
         when matched then update set param_value=val
        when not matched then insert (report_id, param_name, param_value) values (id, nm, val);
      end if;
    end;

    function get_param(p_report_id AWRCOMP_REPORTS.REPORT_ID%type, p_param_name varchar2) return varchar2 result_cache
    is
      l_val AWRCOMP_REPORTS_PARAMS.param_value%type;
    begin
      select param_value into l_val from AWRCOMP_REPORTS_PARAMS where report_id=p_report_id and param_name=upper(p_param_name);
      return l_val;
    exception
      when no_data_found then return null;
    end;

    procedure save_report_content(p_report_id AWRCOMP_REPORTS.REPORT_ID%type,p_output boolean, p_content clob default null)
    is
      l_report_content clob;
      l_line varchar(32767);
      l_status number;
      l_trg_lob blob;
    begin
      if p_output then
        loop
          DBMS_OUTPUT.GET_LINE (
            line   => l_line,
            status => l_status);
          exit when l_status=1;
          l_report_content:=l_report_content||l_line||chr(10);
        end loop;
      else
        l_report_content := p_content;
      end if;


      if l_report_content is null then l_report_content:='No fata found'; end if;

      select REPORT_CONTENT into l_trg_lob from AWRCOMP_REPORTS where report_id=p_report_id for update;
      declare
        ll_d_off integer := 1;
        ll_s_off integer := 1;
        ll_lang_context integer := dbms_lob.DEFAULT_LANG_CTX;
        ll_warn  integer;
      begin
      DBMS_LOB.CONVERTTOBLOB(
        dest_lob       => l_trg_lob,
        src_clob       => l_report_content,
        amount         => DBMS_LOB.LOBMAXSIZE,
        dest_offset    => ll_d_off,
        src_offset     => ll_s_off,
        blob_csid      => dbms_lob.DEFAULT_CSID,
        lang_context   => ll_lang_context,
        warning        => ll_warn);
      end;
    end;

    procedure create_report(p_report_id AWRCOMP_REPORTS.REPORT_ID%type)
    is

      report_type awrcomp_d_report_types.DIC_VALUE%type;
      l_filename varchar2(100);
      l_scr      clob;
      l_report_content clob;
      l_file_prefix AWRCOMP_D_REPORT_TYPES.dic_filename_pref%type;
      l_report_params_displ AWRCOMP_REPORTS.report_params_displ%type;

    begin

      execute immediate q'[alter session set nls_numeric_characters=', ']';

      select tp.DIC_VALUE, tp.dic_filename_pref into report_type,l_file_prefix
        from AWRCOMP_REPORTS r, awrcomp_d_report_types tp where report_id=p_report_id and tp.DIC_ID=report_type;

      dbms_output.enable(null);
      begin
        if report_type='AWRCOMP' then
          declare
            l_dbid number;
            l_ss   number;
            l_es   number;
            l_is_remote awrdumps.is_remote%type;
            l_sort AWRCOMP_D_SORTORDRS.DIC_VALUE%type;
          begin
            l_scr := awrtools_api.getscript('GETCOMPREPORT');
            select dbid, min_snap_id, max_snap_id into l_dbid, l_ss, l_es from awrdumps where dump_id=to_number(get_param(p_report_id,'DB1'));
            l_scr := replace(l_scr,'~dbid1.',to_char(l_dbid));
            l_scr := replace(l_scr,'~start_snap1.',to_char(l_ss));
            l_scr := replace(l_scr,'~end_snap1.',to_char(l_es));

            l_report_params_displ:='DB1: '||to_char(l_dbid)||'; snaps: '||to_char(l_ss)||'-'||to_char(l_es)||'; ';

            select dbid, min_snap_id, max_snap_id, is_remote into l_dbid, l_ss, l_es, l_is_remote from awrdumps where dump_id=to_number(get_param(p_report_id,'DB2'));
            l_scr := replace(l_scr,'~dbid2.',to_char(l_dbid));
            l_scr := replace(l_scr,'~start_snap2.',to_char(l_ss));
            l_scr := replace(l_scr,'~end_snap2.',to_char(l_es));

            l_report_params_displ:=l_report_params_displ||'DB2: '||to_char(l_dbid)||'; snaps: '||to_char(l_ss)||'-'||to_char(l_es)||'; ';

            if l_is_remote='YES' then
              l_scr := replace(l_scr,'~dblnk.','@'||awrtools_api.getconf('DBLINK'));
              l_report_params_displ:=l_report_params_displ||'DB link: '||awrtools_api.getconf('DBLINK')||'; ';
            else
              l_scr := replace(l_scr,'~dblnk.',null);
            end if;

            select dic_filename_pref,DIC_VALUE into l_filename,l_sort from awrcomp_d_sortordrs where dic_id=get_param(p_report_id,'SORT');

            l_scr := replace(l_scr,'~sortcol.',l_sort);
            l_scr := replace(l_scr,'~filter.',get_param(p_report_id,'FILTER'));
            l_scr := replace(l_scr,'~sortlimit.',get_param(p_report_id,'LIMIT'));
            l_scr := replace(l_scr,'~embeded.','FALSE');

            l_report_params_displ:=l_report_params_displ||'SORT: '||l_sort||'; ';
            l_report_params_displ:=l_report_params_displ||'FILTER: '||get_param(p_report_id,'FILTER')||'; ';
            l_report_params_displ:=l_report_params_displ||'LIMIT: '||get_param(p_report_id,'LIMIT');

            set_filename_and_param_displ(p_report_id,l_file_prefix||l_filename, l_report_params_displ);
--'DB1','DB1_START_SNAP','REMARK','DB1_END_SNAP','DB2','DB2_START_SNAP','DB2_END_SNAP','SORT','LIMIT','FILTER','SQL_ID'

            execute immediate l_scr;

            save_report_content(p_report_id,p_output=>true);
          end;
        --====================================================================================
        elsif report_type='AWRSQLREPORT' then

          l_scr := awrtools_api.getscript('GETAWRSQLREPORT');
          l_scr := replace(l_scr,'~SQLID',get_param(p_report_id,'SQL_ID'));
          l_report_params_displ:='SQL_ID: '||get_param(p_report_id,'SQL_ID');
          set_filename_and_param_displ(p_report_id,l_file_prefix||get_param(p_report_id,'SQL_ID'),l_report_params_displ);
          
          execute immediate l_scr using in replace(awrtools_api.getscript('GETCOMPREPORT'),'~','!'); --embeded comparing report

          save_report_content(p_report_id,p_output=>true);
        --====================================================================================
        elsif report_type='AWRRPT' then
          declare
            l_dbid number;
            l_cnt number:=1;
            l_report_id number;
          begin
            select dbid into l_dbid from awrdumps where dump_id=to_number(get_param(p_report_id,'DB1'));

            l_report_params_displ:='DB: '||to_char(l_dbid)||'; snaps: '||get_param(p_report_id,'db1_start_snap')||'-'||get_param(p_report_id,'db1_end_snap')||'; ';

            for i in (select INSTANCE_NUMBER, min(snap_id) mis, max(snap_id) mas
                        from dba_hist_snapshot x where dbid=l_dbid and SNAP_ID between awrtools_reports.get_param(p_report_id,'db1_start_snap') and awrtools_reports.get_param(p_report_id,'db1_end_snap')
                      group by INSTANCE_NUMBER)
            loop
              begin
                for j in (select output from table(dbms_workload_repository.awr_report_html(l_dbid,i.INSTANCE_NUMBER,i.mis,i.mas)))
                loop
                  l_report_content:=l_report_content||j.output||chr(10);
                end loop;
              exception
                when others then l_report_content:=sqlerrm;
              end;
              if l_cnt=1 then
                set_filename_and_param_displ(p_report_id,l_file_prefix||'_'||l_dbid||'_'||i.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER);
                save_report_content(p_report_id,false,l_report_content);
              else
                l_report_id:=create_report(null,null,p_report_id);
                set_filename_and_param_displ(l_report_id,l_file_prefix||'_'||l_dbid||'_'||i.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER);
                save_report_content(l_report_id,false,l_report_content);
              end if;
              l_cnt:=l_cnt+1;
            end loop;
          end;
        --====================================================================================
        elsif report_type='AWRGLOBALRPT' then
          declare
            l_dbid number;
            l_report_id number;
            l_inst_num_list varchar2(1000);
          begin
            select dbid into l_dbid from awrdumps where dump_id=to_number(get_param(p_report_id,'DB1'));

            l_report_params_displ:='DB: '||to_char(l_dbid)||'; snaps: '||get_param(p_report_id,'db1_start_snap')||'-'||get_param(p_report_id,'db1_end_snap')||'; ';

            for i in (select unique INSTANCE_NUMBER
                        from dba_hist_snapshot x where dbid=l_dbid and SNAP_ID between awrtools_reports.get_param(p_report_id,'db1_start_snap') and awrtools_reports.get_param(p_report_id,'db1_end_snap')
                      )
            loop
              l_inst_num_list:=l_inst_num_list||i.INSTANCE_NUMBER||',';
            end loop;
            l_inst_num_list:=rtrim(l_inst_num_list,',');

            begin
              for j in (select output from table(dbms_workload_repository.awr_report_html(l_dbid,l_inst_num_list,get_param(p_report_id,'db1_start_snap'),get_param(p_report_id,'db1_end_snap'))))
              loop
                l_report_content:=l_report_content||j.output||chr(10);
              end loop;
            exception
              when others then l_report_content:=sqlerrm;
            end;

            set_filename_and_param_displ(p_report_id,l_file_prefix||'_'||l_dbid||'_'||replace(l_inst_num_list,',','_')||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap'),l_report_params_displ||' INST List: '||replace(l_inst_num_list,',','_'));
            save_report_content(p_report_id,false,l_report_content);
          end;
        --====================================================================================
        elsif report_type='AWRSQRPT' then
          declare
            l_dbid number;
            l_cnt number:=1;
            l_report_id number;
          begin
            select dbid into l_dbid from awrdumps where dump_id=to_number(get_param(p_report_id,'DB1'));

            l_report_params_displ:='DB: '||to_char(l_dbid)||'; snaps: '||get_param(p_report_id,'db1_start_snap')||'-'||get_param(p_report_id,'db1_end_snap')||'; '||get_param(p_report_id,'SQL_ID')||'; ';

            for i in (select INSTANCE_NUMBER, min(snap_id) mis, max(snap_id) mas
                        from dba_hist_snapshot x where dbid=l_dbid and SNAP_ID between awrtools_reports.get_param(p_report_id,'db1_start_snap') and awrtools_reports.get_param(p_report_id,'db1_end_snap')
                      group by INSTANCE_NUMBER)
            loop
              begin
                for j in (select output from table(dbms_workload_repository.awr_sql_report_html(l_dbid,i.INSTANCE_NUMBER,i.mis,i.mas,get_param(p_report_id,'SQL_ID'))))
                loop
                  l_report_content:=l_report_content||j.output||chr(10);
                end loop;
              exception
                when others then l_report_content:=sqlerrm;
              end;
              if l_cnt=1 then
                set_filename_and_param_displ(p_report_id,l_file_prefix||'_'||l_dbid||'_'||i.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap')||'_'||get_param(p_report_id,'SQL_ID'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER);
                save_report_content(p_report_id,false,l_report_content);
              else
                l_report_id:=create_report(null,null,p_report_id);
                set_filename_and_param_displ(l_report_id,l_file_prefix||'_'||l_dbid||'_'||i.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap')||'_'||get_param(p_report_id,'SQL_ID'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER);
                save_report_content(l_report_id,false,l_report_content);
              end if;
              l_cnt:=l_cnt+1;
            end loop;
          end;
        --====================================================================================
        elsif report_type='AWRDIFF' then
          declare
            l_dbid1 number;
            l_dbid2 number;
            l_cnt number:=1;
            l_report_id number;
          begin
            select dbid into l_dbid1 from awrdumps where dump_id=to_number(get_param(p_report_id,'DB1'));
            select dbid into l_dbid2 from awrdumps where dump_id=to_number(get_param(p_report_id,'DB2'));

            l_report_params_displ:='DB1: '||to_char(l_dbid1)||'; snaps: '||get_param(p_report_id,'db1_start_snap')||'-'||get_param(p_report_id,'db1_end_snap')||'; ';
            l_report_params_displ:=l_report_params_displ||'DB2: '||to_char(l_dbid2)||'; snaps: '||get_param(p_report_id,'db2_start_snap')||'-'||get_param(p_report_id,'db2_end_snap')||'; ';

            for i in (select INSTANCE_NUMBER, min(snap_id) mis, max(snap_id) mas
                        from dba_hist_snapshot x where dbid=l_dbid1 and SNAP_ID between awrtools_reports.get_param(p_report_id,'db1_start_snap') and awrtools_reports.get_param(p_report_id,'db1_end_snap')
                      group by INSTANCE_NUMBER)
            loop
              for k in (select INSTANCE_NUMBER, min(snap_id) mis, max(snap_id) mas
                          from dba_hist_snapshot x where dbid=l_dbid2 and SNAP_ID between awrtools_reports.get_param(p_report_id,'db2_start_snap') and awrtools_reports.get_param(p_report_id,'db2_end_snap')
                        group by INSTANCE_NUMBER)
              loop
                begin
                  for j in (select output from table(dbms_workload_repository.awr_diff_report_html(l_dbid1,i.INSTANCE_NUMBER,i.mis,i.mas,
                                                                                                   l_dbid2,k.INSTANCE_NUMBER,k.mis,k.mas)))
                  loop
                    l_report_content:=l_report_content||j.output||chr(10);
                  end loop;
                exception
                  when others then l_report_content:=sqlerrm;
                end;
                if l_cnt=1 then
                  set_filename_and_param_displ(p_report_id,l_file_prefix||'_'||l_dbid1||'_'||l_dbid2||'_'||i.INSTANCE_NUMBER||'-'||k.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db2_start_snap'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER||'-'||k.INSTANCE_NUMBER);
                  save_report_content(p_report_id,false,l_report_content);
                else
                  l_report_id:=create_report(null,null,p_report_id);
                  set_filename_and_param_displ(l_report_id,l_file_prefix||'_'||l_dbid1||'_'||l_dbid2||'_'||i.INSTANCE_NUMBER||'-'||k.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER||'-'||k.INSTANCE_NUMBER);
                  save_report_content(l_report_id,false,l_report_content);
                end if;
                l_cnt:=l_cnt+1;
              end loop;
            end loop;
          end;
        --====================================================================================
        elsif report_type='AWRGLOBALDIFF' then
          declare
            l_dbid1 number;
            l_dbid2 number;
            l_report_id number;
            l_inst_num_list1 varchar2(1000);
            l_inst_num_list2 varchar2(1000);
          begin
            select dbid into l_dbid1 from awrdumps where dump_id=to_number(get_param(p_report_id,'DB1'));
            select dbid into l_dbid2 from awrdumps where dump_id=to_number(get_param(p_report_id,'DB2'));

            l_report_params_displ:='DB1: '||to_char(l_dbid1)||'; snaps: '||get_param(p_report_id,'db1_start_snap')||'-'||get_param(p_report_id,'db1_end_snap')||'; ';
            l_report_params_displ:=l_report_params_displ||'DB2: '||to_char(l_dbid2)||'; snaps: '||get_param(p_report_id,'db2_start_snap')||'-'||get_param(p_report_id,'db2_end_snap')||'; ';

            for i in (select unique INSTANCE_NUMBER
                        from dba_hist_snapshot x where dbid=l_dbid1 and SNAP_ID between awrtools_reports.get_param(p_report_id,'db1_start_snap') and awrtools_reports.get_param(p_report_id,'db1_end_snap')
                      )
            loop
              l_inst_num_list1:=l_inst_num_list1||i.INSTANCE_NUMBER||',';
            end loop;
            l_inst_num_list1:=rtrim(l_inst_num_list1,',');

            for i in (select unique INSTANCE_NUMBER
                        from dba_hist_snapshot x where dbid=l_dbid2 and SNAP_ID between awrtools_reports.get_param(p_report_id,'db2_start_snap') and awrtools_reports.get_param(p_report_id,'db2_end_snap')
                      )
            loop
              l_inst_num_list2:=l_inst_num_list2||i.INSTANCE_NUMBER||',';
            end loop;
            l_inst_num_list2:=rtrim(l_inst_num_list2,',');
            begin
              for j in (select output from table(dbms_workload_repository.awr_global_diff_report_html(l_dbid1,l_inst_num_list1,get_param(p_report_id,'db1_start_snap'),get_param(p_report_id,'db1_end_snap'),
                                                                                                      l_dbid2,l_inst_num_list2,get_param(p_report_id,'db2_start_snap'),get_param(p_report_id,'db2_end_snap'))))
              loop
                l_report_content:=l_report_content||j.output||chr(10);
              end loop;
            exception
              when others then l_report_content:=sqlerrm;
            end;

            set_filename_and_param_displ(p_report_id,l_file_prefix||'_'||l_dbid1||'_'||l_dbid2||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db2_start_snap'),l_report_params_displ||' INST List: #1: '||replace(l_inst_num_list1,',','_')||'; #2: '||replace(l_inst_num_list2,',','_'));
            save_report_content(p_report_id,false,l_report_content);
          end;
        --====================================================================================
        elsif report_type='ASHRPT' then
          -- somehow it generete empty report on my 12.2 box
          declare
            l_begin_date date;
            l_end_date date;
            l_dbid number;
            l_cnt number:=1;
            l_report_id number;
          begin
            select dbid into l_dbid from awrdumps where dump_id=to_number(get_param(p_report_id,'DB1'));

            l_report_params_displ:='DB: '||to_char(l_dbid)||'; snaps: '||get_param(p_report_id,'db1_start_snap')||'-'||get_param(p_report_id,'db1_end_snap')||'; ';

            for i in (select INSTANCE_NUMBER,min(BEGIN_INTERVAL_TIME)BEGIN_INTERVAL_TIME,max(END_INTERVAL_TIME)END_INTERVAL_TIME
                        from dba_hist_snapshot x where dbid=l_dbid and SNAP_ID between awrtools_reports.get_param(p_report_id,'db1_start_snap') and awrtools_reports.get_param(p_report_id,'db1_end_snap')
                       group by INSTANCE_NUMBER)
            loop

              begin
                for j in (select output from table(dbms_workload_repository.ash_report_html(l_dbid,i.INSTANCE_NUMBER,i.BEGIN_INTERVAL_TIME,i.END_INTERVAL_TIME)))
                loop
                  l_report_content:=l_report_content||j.output||chr(10);
                end loop;
              exception
                when others then l_report_content:=sqlerrm;
              end;

              if l_cnt=1 then
                set_filename_and_param_displ(p_report_id,l_file_prefix||'_'||l_dbid||'_'||i.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER);
                save_report_content(p_report_id,false,l_report_content);
              else
                l_report_id:=create_report(null,null,p_report_id);
                set_filename_and_param_displ(l_report_id,l_file_prefix||'_'||l_dbid||'_'||i.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER);
                save_report_content(l_report_id,false,l_report_content);
              end if;
              l_cnt:=l_cnt+1;
            end loop;
          end;
        --====================================================================================
        elsif report_type='ASHGLOBALRPT' then
          declare
            l_dbid number;
            l_report_id number;
            l_inst_num_list varchar2(1000);
            l_begin_date date;
            l_end_date date;
          begin
            select dbid into l_dbid from awrdumps where dump_id=to_number(get_param(p_report_id,'DB1'));

            l_report_params_displ:='DB: '||to_char(l_dbid)||'; snaps: '||get_param(p_report_id,'db1_start_snap')||'-'||get_param(p_report_id,'db1_end_snap')||'; ';

           select min(BEGIN_INTERVAL_TIME),max(END_INTERVAL_TIME) into l_begin_date,l_end_date
             from dba_hist_snapshot x
            where dbid=l_dbid
              and SNAP_ID between awrtools_reports.get_param(p_report_id,'db1_start_snap') and awrtools_reports.get_param(p_report_id,'db1_end_snap');

            for i in (select unique INSTANCE_NUMBER
                        from dba_hist_snapshot x where dbid=l_dbid and SNAP_ID between awrtools_reports.get_param(p_report_id,'db1_start_snap') and awrtools_reports.get_param(p_report_id,'db1_end_snap')
                      )
            loop
              l_inst_num_list:=l_inst_num_list||i.INSTANCE_NUMBER||',';
            end loop;
            l_inst_num_list:=rtrim(l_inst_num_list,',');

            begin
              for j in (select output from table(dbms_workload_repository.ash_global_report_html(l_dbid,l_inst_num_list,l_begin_date,l_end_date)))
              loop
                l_report_content:=l_report_content||j.output||chr(10);
              end loop;
            exception
              when others then l_report_content:=sqlerrm;
            end;

            set_filename_and_param_displ(p_report_id,l_file_prefix||'_'||l_dbid||'_'||replace(l_inst_num_list,',','_')||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap'),l_report_params_displ||' INST List: '||replace(l_inst_num_list,',','_'));
            save_report_content(p_report_id,false,l_report_content);
          end;
        --====================================================================================
        elsif report_type='ASHANALYTICS' then
          -- somehow it generete empty report on my 12.2 box
          declare
            l_dbid number;
            l_cnt number:=1;
            l_report_id number;
          begin
            select dbid into l_dbid from awrdumps where dump_id=to_number(get_param(p_report_id,'DB1'));

            l_report_params_displ:='DB: '||to_char(l_dbid)||'; snaps: '||get_param(p_report_id,'db1_start_snap')||'-'||get_param(p_report_id,'db1_end_snap')||'; ';
            l_report_params_displ:=l_report_params_displ||'LEVEL: '||get_param(p_report_id,'LEVEL')||'; ';
            l_report_params_displ:=l_report_params_displ||'FILTER: '||get_param(p_report_id,'FILTER');

            for i in (select INSTANCE_NUMBER,min(BEGIN_INTERVAL_TIME)BEGIN_INTERVAL_TIME,max(END_INTERVAL_TIME)END_INTERVAL_TIME
                        from dba_hist_snapshot x where dbid=l_dbid and SNAP_ID between awrtools_reports.get_param(p_report_id,'db1_start_snap') and awrtools_reports.get_param(p_report_id,'db1_end_snap')
                       group by INSTANCE_NUMBER) loop
              begin
                l_report_content:=dbms_workload_repository.ash_report_analytics(dbid         => l_dbid,
                                                                                inst_id      => i.INSTANCE_NUMBER,
                                                                                begin_time   => i.BEGIN_INTERVAL_TIME,
                                                                                end_time     => i.END_INTERVAL_TIME,
                                                                                report_level => get_param(p_report_id,'LEVEL'),
                                                                                filter_list  => get_param(p_report_id,'FILTER'));
              exception
                when others then l_report_content:=sqlerrm;
              end;
              if l_cnt=1 then
                set_filename_and_param_displ(p_report_id,l_file_prefix||'_'||l_dbid||'_'||i.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER);
                save_report_content(p_report_id,false,l_report_content);
              else
                l_report_id:=create_report(null,null,p_report_id);
                set_filename_and_param_displ(l_report_id,l_file_prefix||'_'||l_dbid||'_'||i.INSTANCE_NUMBER||'_'||get_param(p_report_id,'db1_start_snap')||'_'||get_param(p_report_id,'db1_end_snap'),l_report_params_displ||' INST: '||i.INSTANCE_NUMBER);
                save_report_content(l_report_id,false,l_report_content);
              end if;
              l_cnt:=l_cnt+1;
            end loop;
          end;
        else
            raise_application_error(-20000, 'Unknown report type: '||report_type);
        end if;
      exception
        when others then
          begin
            l_report_content:=sqlerrm||chr(10)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||chr(10)||chr(10)||l_scr;
            save_report_content(p_report_id,false,l_report_content);
          end;
      end;

      commit;
    exception
      when others then rollback; raise_application_error(-20000, sqlerrm||chr(10)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||chr(10)||substr(l_report_content,1,100));
    end;

end;
/