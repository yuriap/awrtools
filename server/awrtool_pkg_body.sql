rem Web AWR Tools. Ver 1.000
create or replace package body awrtool_pkg as

    function getconf(p_key varchar2) return varchar2
    is
      l_res awrconfig.cvalue%type;
    begin
      select cvalue into l_res from awrconfig where ckey=p_key;
      return l_res;
    end;

    procedure save_dump(p_blob blob, p_filename varchar2, p_dir varchar2)
    is
      l_file      UTL_FILE.FILE_TYPE;
      l_buffer    RAW(32767);
      l_amount    BINARY_INTEGER := 32767;
      l_pos       INTEGER := 1;
      l_blob_len  INTEGER;
    BEGIN
      l_blob_len := DBMS_LOB.getlength(p_blob);

      -- Open the destination file.
      --l_file := UTL_FILE.fopen('BLOBS','MyImage.gif','w', 32767);
      l_file := UTL_FILE.fopen(p_dir,p_filename,'wb', 32767);

      -- Read chunks of the BLOB and write them to the file
      -- until complete.
      WHILE l_pos < l_blob_len LOOP
        DBMS_LOB.read(p_blob, l_amount, l_pos, l_buffer);
        UTL_FILE.put_raw(l_file, l_buffer, TRUE);
        l_pos := l_pos + l_amount;
      END LOOP;

      -- Close the file.
      UTL_FILE.fclose(l_file);

    EXCEPTION
      WHEN OTHERS THEN
        -- Close the file if something goes wrong.
        IF UTL_FILE.is_open(l_file) THEN
          UTL_FILE.fclose(l_file);
        END IF;
        RAISE;
    END;

    procedure remove_dump(p_filename varchar2, p_dir varchar2)
    is
    begin
      UTL_FILE.FREMOVE (
       location => p_dir,
       filename => p_filename);
    end;
    procedure remote_awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
                       p_dbid out number,p_min_snap_id out number,p_max_snap_id out number,p_min_snap_dt out timestamp,p_max_snap_dt out timestamp,p_db_description out varchar2)
    is
    begin
        delete from awrdumps@dbawr1;
        commit;
        AWRTOOL_PKG.awr_load@dbawr1 (
          P_STG_USER => P_STG_USER,
          P_STG_TABLESPACE => P_STG_TABLESPACE,
          P_STG_TEMP => P_STG_TEMP,
          P_DIR => P_DIR,
          P_DMPFILE => P_DMPFILE) ;
        select
          DBID,MIN_SNAP_ID,MAX_SNAP_ID,MIN_SNAP_DT,MAX_SNAP_DT,DB_DESCRIPTION
          into p_dbid,p_min_snap_id,p_max_snap_id,p_min_snap_dt,p_max_snap_dt,p_db_description
        from awrdumps@dbawr1;
        delete from awrdumps@dbawr1;
    end;

    procedure awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
                       p_dbid out number,p_min_snap_id out number,p_max_snap_id out number,p_min_snap_dt out timestamp,p_max_snap_dt out timestamp,p_db_description out varchar2)
    is
    --awr staging
      l_user number;
    begin
      select count(1) into l_user from dba_users where username=upper(p_stg_user);
      if l_user=1 then execute immediate 'drop user '||p_stg_user||' cascade'; end if;

      execute immediate
        'create user '||p_stg_user||'
          identified by '||p_stg_user||'
          default tablespace '||p_stg_tablespace||'
          temporary tablespace '||p_stg_temp;

      execute immediate 'alter user '||p_stg_user||' quota unlimited on '||p_stg_tablespace;
      /* call PL/SQL routine to load the data into the staging schema */
      sys.dbms_swrf_internal.awr_load(schname  => p_stg_user,
                                  dmpfile  => p_dmpfile,
                                  dmpdir   => p_dir);
      sys.dbms_swrf_internal.move_to_awr(schname => p_stg_user);
      sys.dbms_swrf_internal.clear_awr_dbid;

      execute immediate 'SELECT
        min(snap_id),max(snap_id),
        min(end_interval_time),max(end_interval_time),
        min(dbid)
        FROM
        awrstg.wrm$_snapshot'
        into
        p_min_snap_id,p_max_snap_id,
        p_min_snap_dt,p_max_snap_dt,p_dbid;
      execute immediate q'[
      select unique version || ', ' || host_name || ', ' || platform_name
        from awrstg.WRM$_DATABASE_INSTANCE i,
             awrstg.wrm$_snapshot sn
       where i.dbid = sn.dbid]'
       into p_db_description;

      execute immediate 'drop user '||p_stg_user||' cascade';
    end;

    function getscript(p_script_id varchar2) return clob
    is
      l_res clob;
    begin
      select script_content into l_res from AWRCOMP_SCRIPTS where script_id=p_script_id;
      return l_res;
    exception
      when no_data_found then raise_application_error(-20000,'Script "'||p_script_id||'" not found.');
    end;

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

    procedure create_awrcomp_report(p_report_id AWRCOMP_REPORTS.REPORT_ID%type)
    is
      qlist sys_refcursor;
      l_sql clob := awrtool_pkg.getscript('GETQUERYLIST');

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

      l_awrcomp_scr clob := awrtool_pkg.getscript('GETCOMPREPORT');
      l_noncomp_scr clob := awrtool_pkg.getscript('GETNONCOMPREPORT');
      l_sysmetr_scr_o clob := awrtool_pkg.getscript('GETSYSMETRREPORT');
      l_sysmetr_scr clob;

      l_occ    number;
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

      select
          d1.dbid,d2.dbid,DB1_SNAP_LIST,DB2_SNAP_LIST,s.DIC_VALUE,statlimit,qry_filter,decode(d2.is_remote,'YES',dblink,null),tp.DIC_VALUE
        into
          dbid1,dbid2,snap1,snap2,sortordr,statlim,qfilter,dblink,report_type
        from AWRCOMP_REPORTS, AWRDUMPS d1, AWRDUMPS d2, AWRCOMP_D_SORTORDRS s, awrcomp_d_report_types tp where report_id=p_report_id
          and DB1_DUMP_ID=d1.dump_id and DB2_DUMP_ID=d2.dump_id and s.DIC_ID(+)=REPORT_SORT_ORDR and tp.DIC_ID=report_type;

      dbms_output.enable(null);
      begin
        if report_type='AWRCOMP' then
        
            l_sql:=replace_subst(l_sql);
            l_awrcomp_scr:=replace_subst(l_awrcomp_scr);
            l_noncomp_scr:=replace_subst(l_noncomp_scr);
            
            --get query list for compare
            l_toexec:=l_sql;
            open qlist for l_sql;
            loop
              fetch qlist into l_cmd, l_capt;
              exit when qlist%notfound;
              l_script:=l_script||chr(13)||chr(10)||l_cmd;
            end loop;
            close qlist;

            --start compare report
            dbms_output.put_line('AWR Plan Comparator version '||awrtool_pkg.getconf('TOOLVERSION'));

            l_occ:=1;
            loop
              dbms_output.put_line('TOP SQL '||substr(l_script,instr(l_script,'prompt TOP SQL #',1,l_occ)+15,4));
              l_sql_id:=substr(l_script,instr(l_script,'define SQLID=',1,l_occ)+13,13);
              l_toexec:=l_awrcomp_scr;
              execute immediate replace(l_awrcomp_scr,'&SQLID.',l_sql_id);
              l_occ:=l_occ+1;
              exit when instr(l_script,'define SQLID=',1,l_occ)=0 or l_occ>20;
            end loop;

            dbms_output.put_line('AWR Plan Comparator: non-comparable queries.');
            l_toexec:=l_noncomp_scr;
            print_table(l_noncomp_scr);

        elsif report_type='AWRMETRICS' then
            dbms_output.put_line('SYSMETRICS report.');
            l_sysmetr_scr:=replace_subst(l_sysmetr_scr_o,1);
            l_toexec:=l_sysmetr_scr;
			dbms_output.put_line('DB1: ');
            print_table(l_sysmetr_scr);
            l_sysmetr_scr:=replace_subst(l_sysmetr_scr_o,2);
            l_toexec:=l_sysmetr_scr;
			dbms_output.put_line('DB2: ');
            print_table(l_sysmetr_scr);
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

procedure load_dump_into_repo(p_dump_id awrdumps.dump_id%type, p_dest varchar2) is
  l_dbid number;
  l_min_snap_id number;
  l_max_snap_id number;
  l_min_snap_dt timestamp(3);
  l_max_snap_dt timestamp(3);
  l_db_description awrdumps.db_description%type;
begin
    for i in (select proj_id,filebody,filename
                from awrdumps a,awrdumps_files b
               where a.dump_id=b.dump_id and a.dump_id=V('P12_DUMP_ID')
                 and status<>'LOADED') loop
      awrtool_pkg.save_dump(i.filebody,i.filename,awrtool_pkg.getconf('WORKDIR'));
      if p_dest='REM' then
        awrtool_pkg.remote_awr_load(p_stg_user => awrtool_pkg.getconf('AWRSTGUSER'),
          p_stg_tablespace => awrtool_pkg.getconf('AWRSTGTBLSPS'),
          p_stg_temp => awrtool_pkg.getconf('AWRSTGTMP'),
          p_dir => awrtool_pkg.getconf('WORKDIR'),
          p_dmpfile => substr(i.filename,1,instr(i.filename,'.',-1)-1),
          p_dbid=>l_dbid,
          p_min_snap_id=>l_min_snap_id,
          p_max_snap_id=>l_max_snap_id,
          p_min_snap_dt=>l_min_snap_dt,
          p_max_snap_dt=>l_max_snap_dt,
          p_db_description=>l_db_description);
      else
        awrtool_pkg.awr_load(p_stg_user => awrtool_pkg.getconf('AWRSTGUSER'),
          p_stg_tablespace => awrtool_pkg.getconf('AWRSTGTBLSPS'),
          p_stg_temp => awrtool_pkg.getconf('AWRSTGTMP'),
          p_dir => awrtool_pkg.getconf('WORKDIR'),
          p_dmpfile => substr(i.filename,1,instr(i.filename,'.',-1)-1),
          p_dbid=>l_dbid,
          p_min_snap_id=>l_min_snap_id,
          p_max_snap_id=>l_max_snap_id,
          p_min_snap_dt=>l_min_snap_dt,
          p_max_snap_dt=>l_max_snap_dt,
          p_db_description=>l_db_description);
      end if;
      update awrdumps set
        dbid=l_dbid,
        min_snap_id=l_min_snap_id,
        max_snap_id=l_max_snap_id,
        min_snap_dt=l_min_snap_dt,
        max_snap_dt=l_max_snap_dt,
        db_description=l_db_description,
        is_remote=decode(p_dest,'REM','YES','NO')
      where dump_id=p_dump_id;
      awrtools_contr.lcc_dump_load(p_dump_id);
      awrtools_contr.lcc_project_create(i.proj_id);
      commit;
      awrtool_pkg.remove_dump(i.filename,awrtool_pkg.getconf('WORKDIR'));
    end loop;
end;

procedure unload_dump(p_dump_id awrdumps.dump_id%type)
is
begin
  for i in (select * from awrdumps where dump_id=p_dump_id) loop
    if i.is_remote='YES' then
        awrtool_pkg.drop_snapshot_range@DBAWR1(low_snap_id => i.min_snap_id,high_snap_id => i.max_snap_id,dbid => i.dbid);
      else
      dbms_workload_repository.drop_snapshot_range(low_snap_id => i.min_snap_id,high_snap_id => i.max_snap_id,dbid => i.dbid);
    end if;
    awrtools_contr.lcc_dump_unload(p_dump_id);
  end loop;
end;
end;