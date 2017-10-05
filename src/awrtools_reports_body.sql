create or replace package body awrtools_reports as
  
    type t_column_spec_rec is record (
      header varchar2(50),
      width  number,
      word_wrapped boolean,
      noprint boolean
    );
    type t_column_spec is table of t_column_spec_rec index by varchar2(100);
  
    l_col_spec t_column_spec;
    
    procedure print_table(p_query in varchar2) is
      l_theCursor   integer default dbms_sql.open_cursor;
      l_columnValue varchar2(4000);
      l_status      integer;
      l_descTbl     dbms_sql.desc_tab;
      l_colCnt      number;
      type col_lngth_t is table of number index by pls_integer;
      type col_data_t is table of varchar2(4000) index by pls_integer;
      type col_data_arr_t is table of col_data_t index by pls_integer;
      col_data_arr col_data_arr_t;
      col_nm       col_data_t;
      col_l        col_lngth_t;
      l_rn         number := 0;
      l_lngth      number;
    begin
      dbms_sql.parse(l_theCursor, p_query, dbms_sql.native);
      dbms_sql.describe_columns(l_theCursor, l_colCnt, l_descTbl);

      for i in 1 .. l_colCnt loop
        dbms_sql.define_column(l_theCursor, i, l_columnValue, 4000);
      end loop;

      l_status := dbms_sql.execute(l_theCursor);

      --column names
      for i in 1 .. l_colCnt loop
         col_nm(i) := l_descTbl(i).col_name;
      end loop;

      while (dbms_sql.fetch_rows(l_theCursor) > 0) loop
         l_rn := l_rn + 1;
        for i in 1 .. l_colCnt loop
          dbms_sql.column_value(l_theCursor, i, l_columnValue);
          col_data_arr(i)(l_rn) := l_columnValue;
        end loop;
      end loop;
      dbms_sql.close_cursor(l_theCursor);

      --get max col data length
      for i in 1 .. l_colCnt loop
        l_lngth:=0;
        for j in 1 .. l_rn loop
          l_lngth := greatest(length(col_nm(i))+1, l_lngth, nvl(length(col_data_arr(i) (j)),0)+1);
        end loop;
        col_l(i):=l_lngth;
      end loop;

      -- print col names
      for i in 1 .. l_colCnt loop
        dbms_output.put(rpad(col_nm(i), col_l(i), ' '));
      end loop;
      dbms_output.put_line(' ');
      --print line
      for i in 1 .. l_colCnt loop
        dbms_output.put(rpad('-', col_l(i) - 1, '-') || ' ');
      end loop;
      dbms_output.put_line(' ');
      --print data
      for j in 1 .. l_rn loop
         for i in 1 .. l_colCnt loop
          dbms_output.put(rpad(nvl(col_data_arr(i) (j),' '), col_l(i), ' '));
        end loop;
        dbms_output.put_line(' ');
      end loop;
      if l_rn = 0 then dbms_output.put_line('No rows selected'); else dbms_output.put_line(l_rn||' rows selected'); end if;
    exception
      when others then
        if DBMS_SQL.IS_OPEN(l_theCursor) then
          dbms_sql.close_cursor(l_theCursor);
        end if;
        raise_application_error(-20000, sqlerrm || chr(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    end;

    procedure print_table_wr(p_query in varchar2, p_col_spec in out t_column_spec) is
      l_theCursor   integer default dbms_sql.open_cursor;
      l_columnValue varchar2(4000);
      l_status      integer;
      l_descTbl     dbms_sql.desc_tab;
      l_colCnt      number;
      type col_lngth_t is table of number index by pls_integer;
      type col_data_t is table of varchar2(4000) index by pls_integer;
      type col_data_arr_t is table of col_data_t index by pls_integer;
      col_data_arr col_data_arr_t;
      col_nm       col_data_t;
      col_l        col_lngth_t;
      col_rows     col_lngth_t;
      data_row     col_data_arr_t;
      l_rn         number := 0;
      l_lngth      number;
      l_rownum     number;
      l_maxrownum  number;
      l_word_wrapped_exists boolean := false;
      l_txt        varchar2(32767);
      procedure format_text(p_txt in out varchar2, p_width number, p_rownum out number, p_text_lined out col_data_t)
      is
        ll_txt1 varchar2(32767);
        ll_pattern varchar2(100):=',|;| |=|'||chr(10)||'';
      begin
        p_rownum:=0;
        loop
          if regexp_count( substr(p_txt,1,p_width), ll_pattern)>0 and length(p_txt)>p_width then
            ll_txt1:=substr(p_txt,1,REGEXP_INSTR(substr(p_txt,1,p_width),ll_pattern,1,regexp_count( substr(p_txt,1,p_width), ll_pattern)));
          else
            ll_txt1:=p_txt;
          end if;
          if ll_txt1 is not null then p_rownum:=p_rownum+1; else exit; end if;
          p_text_lined(p_rownum):=ll_txt1;
          p_txt:=substr(p_txt,length(ll_txt1)+1);
          exit when p_txt is null;
        end loop;
      end;
    begin
      dbms_sql.parse(l_theCursor, p_query, dbms_sql.native);
      dbms_sql.describe_columns(l_theCursor, l_colCnt, l_descTbl);

      for i in 1 .. l_colCnt loop
        dbms_sql.define_column(l_theCursor, i, l_columnValue, 4000);
      end loop;

      l_status := dbms_sql.execute(l_theCursor);

      --column names
      for i in 1 .. l_colCnt loop
         col_nm(i) := l_descTbl(i).col_name;
      end loop;

      while (dbms_sql.fetch_rows(l_theCursor) > 0) loop
         l_rn := l_rn + 1;
        for i in 1 .. l_colCnt loop
          dbms_sql.column_value(l_theCursor, i, l_columnValue);
          col_data_arr(i)(l_rn) := l_columnValue;
        end loop;
      end loop;
      dbms_sql.close_cursor(l_theCursor);

      --get max col data length
      for i in 1 .. l_colCnt loop
        col_l(i):=p_col_spec(col_nm(i)).width;
        if not p_col_spec(col_nm(i)).noprint and not p_col_spec(col_nm(i)).word_wrapped then
          l_lngth:=0;
          for j in 1 .. l_rn loop
            l_lngth := greatest(nvl(p_col_spec(col_nm(i)).width,0), length(nvl(p_col_spec(col_nm(i)).header,col_nm(i)))+1, l_lngth, nvl(length(col_data_arr(i) (j)),0)+1);
          end loop;      
          col_l(i):=l_lngth;
        end if;
        
        if p_col_spec(col_nm(i)).word_wrapped then
          l_word_wrapped_exists:=true;
        end if;        
      end loop;

      -- print col names
      if l_word_wrapped_exists then dbms_output.put('.'); end if;
      for i in 1 .. l_colCnt loop
        if not p_col_spec(col_nm(i)).noprint then
          if p_col_spec(col_nm(i)).header is null then
            dbms_output.put(rpad(col_nm(i), col_l(i)+1, ' '));
          else
            dbms_output.put(rpad(p_col_spec(col_nm(i)).header, col_l(i)+1, ' '));
          end if;
        end if;
      end loop;
      dbms_output.put_line(' ');
      
      --print line
      if l_word_wrapped_exists then dbms_output.put('.'); end if;
      for i in 1 .. l_colCnt loop
        if not p_col_spec(col_nm(i)).noprint then
          dbms_output.put(rpad('-', col_l(i) , '-') || ' ');
        end if;
      end loop;
      dbms_output.put_line(' ');
      
      --print data
      if l_word_wrapped_exists then
        for j in 1 .. l_rn loop
          -- put all columns for current row into arryy with strings of required length
          l_maxrownum:=0;
          for k in 1 .. l_colCnt loop
            if not p_col_spec(col_nm(k)).noprint then
              l_txt:=col_data_arr(k)(j);
              format_text(l_txt,p_col_spec(col_nm(k)).width,l_rownum,data_row(k));
              l_maxrownum:=greatest(l_maxrownum,l_rownum);
            end if;
          end loop;
      
          for i in 1 .. l_maxrownum+1 loop
            dbms_output.put('.');
            for k in 1 .. l_colCnt loop
              if not p_col_spec(col_nm(k)).noprint then
                if data_row(k).exists(i) then
                  dbms_output.put(rpad(nvl(replace(replace(data_row(k)(i),chr(10)),chr(13)),' '), col_l(k), ' ')||' ');
                else
                  dbms_output.put(rpad(nvl(replace(replace(' ',chr(10)),chr(13)),' '), col_l(k), ' ')||' ');
                end if;
              end if;
            end loop;
            dbms_output.put_line(' ');            
          end loop;
          
        end loop;
      else
        for j in 1 .. l_rn loop
          for i in 1 .. l_colCnt loop
            if not p_col_spec(col_nm(i)).noprint then
              dbms_output.put(rpad(nvl(col_data_arr(i) (j),' '), col_l(i), ' ')||' ');
            end if;
          end loop;
          dbms_output.put_line(' ');
        end loop;
      end if;
      dbms_output.put_line('----------------');
      if l_rn = 0 then dbms_output.put_line('No rows selected'); else dbms_output.put_line(l_rn||' rows selected'); end if;
    exception
      when others then
        if DBMS_SQL.IS_OPEN(l_theCursor) then
          dbms_sql.close_cursor(l_theCursor);
        end if;
        raise_application_error(-20000, sqlerrm || chr(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    end;
    
    procedure create_awrcomp_report(p_report_id AWRCOMP_REPORTS.REPORT_ID%type)
    is
      qlist sys_refcursor;
      l_qrylist clob := awrtools_api.getscript('GETQUERYLIST');

      dbid1 AWRDUMPS.DBID%type;
      dbid2 AWRDUMPS.DBID%type;
      snap1 AWRCOMP_REPORTS.DB1_SNAP_LIST%type;
      snap2 AWRCOMP_REPORTS.DB2_SNAP_LIST%type;
      sortordr AWRCOMP_D_SORTORDRS.DIC_VALUE%type;
      statlim AWRCOMP_REPORTS.statlimit%type;
      qfilter AWRCOMP_REPORTS.qry_filter%type;
      dblink AWRCOMP_REPORTS.dblink%type;
      report_type awrcomp_d_report_types.DIC_VALUE%type;

      l_cmd varchar2(1000);
      l_capt varchar2(1000);

      l_script clob;

      l_awrcomp_scr clob := awrtools_api.getscript('GETCOMPREPORT');
      l_noncomp_scr clob := awrtools_api.getscript('GETNONCOMPREPORT');
      l_sysmetr_scr_o clob := awrtools_api.getscript('GETSYSMETRREPORT');
      l_sysmetr_scr clob;

      l_occ    number;
      l_sql_cnt number;
      l_sql_id    varchar2(20);

      l_line varchar(32767);
      l_status number;
      l_awrcomp_rpt clob;
      l_trg_lob blob;
      l_toexec clob;

      function replace_subst(p_sql clob) return clob
      is
        l_sql clob;
      begin
        l_sql := replace(p_sql,'&dbid1.',to_char(dbid1));
        l_sql := replace(l_sql,'&dbid2.',to_char(dbid2));
        l_sql := replace(l_sql,'&snaps1.',snap1);
        l_sql := replace(l_sql,'&snaps2.',snap2);
        l_sql := replace(l_sql,'&dblnk.',dblink);
        l_sql := replace(l_sql,'&ordcol_expr.',sortordr);
        l_sql := replace(l_sql,'&filter.',qfilter);
        l_sql := replace(l_sql,'&statlimit.',to_char(statlim));
        l_sql := replace(l_sql,'&fcol.','15');
        l_sql := replace(l_sql,'&ordrcol.','elapsed_time_delta');
        return l_sql;
      end;
      function replace_subst(p_sql clob, p_db number) return clob
      is
        l_sql clob;
      begin
        if p_db=1 then
          l_sql := replace(p_sql,'&p_dbid.',to_char(dbid1));
          l_sql := replace(l_sql,'&p_snapshots.',snap1);
          l_sql := replace(l_sql,'&p_dblnk.','');
        elsif p_db=2 then
          l_sql := replace(p_sql,'&p_dbid.',to_char(dbid2));
          l_sql := replace(l_sql,'&p_snapshots.',snap2);
          l_sql := replace(l_sql,'&p_dblnk.',dblink);
        end if;
        return l_sql;
      end;
    begin

      execute immediate q'[alter session set nls_numeric_characters=', ']';
      
      select
          d1.dbid,d2.dbid,DB1_SNAP_LIST,DB2_SNAP_LIST,s.DIC_VALUE,statlimit,qry_filter,decode(d2.is_remote,'YES',dblink,null),tp.DIC_VALUE
        into
          dbid1,dbid2,snap1,snap2,sortordr,statlim,qfilter,dblink,report_type
        from AWRCOMP_REPORTS, AWRDUMPS d1, AWRDUMPS d2, AWRCOMP_D_SORTORDRS s, awrcomp_d_report_types tp where report_id=p_report_id
          and DB1_DUMP_ID=d1.dump_id and DB2_DUMP_ID=d2.dump_id and s.DIC_ID(+)=REPORT_SORT_ORDR and tp.DIC_ID=report_type;

      dbms_output.enable(null);
      begin
        if report_type='AWRCOMP' then
        
            l_qrylist:=replace_subst(l_qrylist);
            l_qrylist:=replace(l_qrylist,'&1.','@getplanawr_plancomp');
            l_awrcomp_scr:=replace_subst(l_awrcomp_scr);
            l_noncomp_scr:=replace_subst(l_noncomp_scr);
            
            --get query list for compare
            l_toexec:=l_qrylist;
            --dbms_output.put_line(l_toexec);
            l_sql_cnt:=0;
            open qlist for l_qrylist;
            loop
              fetch qlist into l_cmd, l_capt;
              exit when qlist%notfound;
              l_script:=l_script||chr(13)||chr(10)||l_cmd;
              l_sql_cnt:=l_sql_cnt+1;
            end loop;
            close qlist;

            --start compare report
            dbms_output.put_line('AWR Plan Comparator version '||awrtools_api.getconf('TOOLVERSION'));

            if l_sql_cnt>0 then
              l_occ:=1;
              loop
                dbms_output.put_line('TOP SQL '||substr(l_script,instr(l_script,'prompt TOP SQL #',1,l_occ)+15,4));
                l_sql_id:=substr(l_script,instr(l_script,'define SQLID=',1,l_occ)+13,13);
                l_toexec:=l_awrcomp_scr;
                execute immediate replace(l_awrcomp_scr,'&SQLID.',l_sql_id);
                l_occ:=l_occ+1;
                exit when instr(l_script,'define SQLID=',1,l_occ)=0 /*or l_occ>20*/;
              end loop;
            else
              dbms_output.put_line('No query found for comparison.');
            end if;

            dbms_output.put_line('============================================');
            
            dbms_output.put_line('AWR Plan Comparator: non-comparable queries.');
            l_toexec:=l_noncomp_scr;
            --dbms_output.put_line(l_toexec);
            
            --column SRC_NAME format a30 WOR
            --column STAT format a60 WOR heading "Stats / per exec"
            --column txt format a150 WOR
            --column ORDRC noprint
            
            l_col_spec('SQL_ID').header:='SQL_ID';l_col_spec('SQL_ID').width:=15; l_col_spec('SQL_ID').word_wrapped:=false;l_col_spec('SQL_ID').noprint:=false;
            l_col_spec('SRC_NAME').header:='Source';l_col_spec('SRC_NAME').width:=35; l_col_spec('SRC_NAME').word_wrapped:=true;l_col_spec('SRC_NAME').noprint:=false;
            l_col_spec('STAT').header:='Stats / per exec';l_col_spec('STAT').width:=50; l_col_spec('STAT').word_wrapped:=true;l_col_spec('STAT').noprint:=false;
            l_col_spec('TXT').header:='SQL text';l_col_spec('TXT').width:=150; l_col_spec('TXT').word_wrapped:=true;l_col_spec('TXT').noprint:=false;
            l_col_spec('ORDRC').header:='ORD';l_col_spec('ORDRC').width:=3; l_col_spec('ORDRC').word_wrapped:=false;l_col_spec('ORDRC').noprint:=true;
            
            print_table_wr(l_noncomp_scr,l_col_spec);

        elsif report_type='AWRMETRICS' then
            l_col_spec('END_TIME').header:='END_TIME';l_col_spec('END_TIME').width:=20; l_col_spec('END_TIME').word_wrapped:=false;l_col_spec('END_TIME').noprint:=false;
            l_col_spec('SREADTIM_VAL').header:='SREAD TIM, ms';l_col_spec('SREADTIM_VAL').width:=10; l_col_spec('SREADTIM_VAL').word_wrapped:=false;l_col_spec('SREADTIM_VAL').noprint:=false;
            l_col_spec('SREADTIM_METR').header:='SREADTIM_METR';l_col_spec('SREADTIM_METR').width:=15; l_col_spec('SREADTIM_METR').word_wrapped:=false;l_col_spec('SREADTIM_METR').noprint:=true;
            l_col_spec('READS_VAL').header:='READS/SEC';l_col_spec('READS_VAL').width:=6; l_col_spec('READS_VAL').word_wrapped:=false;l_col_spec('READS_VAL').noprint:=false;
            l_col_spec('READS_METR').header:='READS_METR';l_col_spec('READS_METR').width:=15; l_col_spec('READS_METR').word_wrapped:=false;l_col_spec('READS_METR').noprint:=true;
            l_col_spec('WRITES_VAL').header:='WRITES/SEC';l_col_spec('WRITES_VAL').width:=6; l_col_spec('WRITES_VAL').word_wrapped:=false;l_col_spec('WRITES_VAL').noprint:=false;
            l_col_spec('WRITES_METR').header:='WRITES_METR';l_col_spec('WRITES_METR').width:=15; l_col_spec('WRITES_METR').word_wrapped:=false;l_col_spec('WRITES_METR').noprint:=true;
            l_col_spec('REDO_VAL').header:='REDO MB/SEC';l_col_spec('REDO_VAL').width:=10; l_col_spec('REDO_VAL').word_wrapped:=false;l_col_spec('REDO_VAL').noprint:=false;
            l_col_spec('REDO_METR').header:='REDO_METR';l_col_spec('REDO_METR').width:=15; l_col_spec('REDO_METR').word_wrapped:=false;l_col_spec('REDO_METR').noprint:=true;
            l_col_spec('IOPS_VAL').header:='IOPS';l_col_spec('IOPS_VAL').width:=6; l_col_spec('IOPS_VAL').word_wrapped:=false;l_col_spec('IOPS_VAL').noprint:=false;
            l_col_spec('IOPS_METR').header:='IOPS_METR';l_col_spec('IOPS_METR').width:=15; l_col_spec('IOPS_METR').word_wrapped:=false;l_col_spec('IOPS_METR').noprint:=true;
            l_col_spec('MBPS_VAL').header:='IO MB/SEC';l_col_spec('MBPS_VAL').width:=10; l_col_spec('MBPS_VAL').word_wrapped:=false;l_col_spec('MBPS_VAL').noprint:=false;
            l_col_spec('MBPS_METR').header:='MBPS_METR';l_col_spec('MBPS_METR').width:=15; l_col_spec('MBPS_METR').word_wrapped:=false;l_col_spec('MBPS_METR').noprint:=true;
            l_col_spec('DBCPU_VAL').header:='DB CPU SEC/SEC';l_col_spec('DBCPU_VAL').width:=10; l_col_spec('DBCPU_VAL').word_wrapped:=false;l_col_spec('DBCPU_VAL').noprint:=false;
            l_col_spec('DBCPU_METR').header:='DBCPU_METR';l_col_spec('DBCPU_METR').width:=15; l_col_spec('DBCPU_METR').word_wrapped:=false;l_col_spec('DBCPU_METR').noprint:=true;
            l_col_spec('HOSTCPU_VAL').header:='HOST CPU SEC/SEC';l_col_spec('HOSTCPU_VAL').width:=10; l_col_spec('HOSTCPU_VAL').word_wrapped:=false;l_col_spec('HOSTCPU_VAL').noprint:=false;
            l_col_spec('HOSTCPU_METR').header:='HOSTCPU_METR';l_col_spec('HOSTCPU_METR').width:=15; l_col_spec('HOSTCPU_METR').word_wrapped:=false;l_col_spec('HOSTCPU_METR').noprint:=true;
            l_col_spec('EXECS_VAL').header:='EXECS/SEC';l_col_spec('EXECS_VAL').width:=6; l_col_spec('EXECS_VAL').word_wrapped:=false;l_col_spec('EXECS_VAL').noprint:=false;
            l_col_spec('EXECS_METR').header:='EXECS_METR';l_col_spec('EXECS_METR').width:=15; l_col_spec('EXECS_METR').word_wrapped:=false;l_col_spec('EXECS_METR').noprint:=true;
            l_col_spec('NETW_VAL').header:='NET MB/SEC';l_col_spec('NETW_VAL').width:=10; l_col_spec('NETW_VAL').word_wrapped:=false;l_col_spec('NETW_VAL').noprint:=false;
            l_col_spec('NETW_METR').header:='NETW_METR';l_col_spec('NETW_METR').width:=15; l_col_spec('NETW_METR').word_wrapped:=false;l_col_spec('NETW_METR').noprint:=true;
            l_col_spec('CALLS_VAL').header:='CALLS/SEC';l_col_spec('CALLS_VAL').width:=6; l_col_spec('CALLS_VAL').word_wrapped:=false;l_col_spec('CALLS_VAL').noprint:=false;
            l_col_spec('CALLS_METR').header:='CALLS_METR';l_col_spec('CALLS_METR').width:=15; l_col_spec('CALLS_METR').word_wrapped:=false;l_col_spec('CALLS_METR').noprint:=true;        
        
            dbms_output.put_line('SYSMETRICS report.');
            l_sysmetr_scr:=replace_subst(l_sysmetr_scr_o,1);
            l_toexec:=l_sysmetr_scr;
            dbms_output.put_line('DB1: ');
            print_table_wr(l_sysmetr_scr,l_col_spec);
            l_sysmetr_scr:=replace_subst(l_sysmetr_scr_o,2);
            l_toexec:=l_sysmetr_scr;
            dbms_output.put_line('DB2: ');
            print_table_wr(l_sysmetr_scr,l_col_spec);
        else
            raise_application_error(-20000, 'Unknown report type: '||report_type);
        end if;
      exception
        when others then l_awrcomp_rpt:=sqlerrm||chr(10)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||chr(10)||l_sql_id||chr(10)||l_toexec;
      end;
      --dbms_output.put_line(length(l_awrcomp_rpt));
      --update AWRCOMP_REPORTS set REPORT_CONTENT=l_awrcomp_rpt where report_id=p_report_id;

      --save report
      --get report from buffer
      loop
        DBMS_OUTPUT.GET_LINE (
          line   => l_line,
          status => l_status);
        exit when l_status=1;
        l_awrcomp_rpt:=l_awrcomp_rpt||l_line||chr(13)||chr(10);
      end loop;

      if l_awrcomp_rpt is null then l_awrcomp_rpt:='No fata found for '||report_type; end if;

      select REPORT_CONTENT into l_trg_lob from AWRCOMP_REPORTS where report_id=p_report_id for update;
      declare
        ll_d_off integer := 1;
        ll_s_off integer := 1;
        ll_lang_context integer := dbms_lob.DEFAULT_LANG_CTX;
        ll_warn  integer;
      begin
      DBMS_LOB.CONVERTTOBLOB(
        dest_lob       => l_trg_lob,
        src_clob       => l_awrcomp_rpt,
        amount         => DBMS_LOB.LOBMAXSIZE,
        dest_offset    => ll_d_off,
        src_offset     => ll_s_off,
        blob_csid      => dbms_lob.DEFAULT_CSID,
        lang_context   => ll_lang_context,
        warning        => ll_warn);
      end;
      commit;
    exception
      when others then raise_application_error(-20000, sqlerrm||chr(10)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||chr(10)||substr(l_awrcomp_rpt,1,100));
    end;

end;
/