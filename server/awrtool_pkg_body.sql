create or replace package body awrtool_pkg as

    function getconf(p_key varchar2) return varchar2
    is
      l_res config.cvalue%type;
    begin
      select cvalue into l_res from config where ckey=p_key;
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

    procedure awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
                       p_dbid out number,p_min_snap_id out number,p_max_snap_id out number,p_min_snap_dt out timestamp,p_max_snap_dt out timestamp,p_db_description out varchar2)
    is
    --awr staging
    begin
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
      l_cmd varchar2(1000);
      l_capt varchar2(1000);
    
      l_script clob;
    
      l_awrcomp_scr clob := awrtool_pkg.getscript('GETCOMPREPORT');
      l_occ    number;
      l_sql_id    varchar2(20);
    
      l_line varchar(32767);
      l_status number;
      l_awrcomp_rpt clob;  
      l_trg_lob blob;
      
      function replace_subst(p_sql clob) return clob
      is
        l_sql clob;
      begin
        l_sql := replace(p_sql,'&dbid1.',dbid1);
        l_sql := replace(l_sql,'&dbid2.',dbid2);
        l_sql := replace(l_sql,'&snaps1.',snap1);
        l_sql := replace(l_sql,'&snaps2.',snap2);
        l_sql := replace(l_sql,'&dblnk.',dblink);
        l_sql := replace(l_sql,'&ordcol_expr.',sortordr);
        l_sql := replace(l_sql,'&filter.',qfilter);
        l_sql := replace(l_sql,'&statlimit.',statlim);  
        return l_sql;
      end;
    begin
      
      select 
          d1.dbid,
          d2.dbid,
          DB1_SNAP_LIST,
          DB2_SNAP_LIST,
          s.DIC_VALUE,
          statlimit,
          qry_filter,
          dblink
        into 
          dbid1,
          dbid2,
          snap1,
          snap2,
          sortordr,
          statlim,
          qfilter,
          dblink
        from AWRCOMP_REPORTS, AWRDUMPS d1, AWRDUMPS d2, AWRCOMP_D_SORTORDRS s where report_id=p_report_id
          and DB1_DUMP_ID=d1.dump_id and DB2_DUMP_ID=d2.dump_id and s.DIC_ID=REPORT_SORT_ORDR;
        
      dbms_output.enable(null);
      l_sql:=replace_subst(l_sql);
      l_awrcomp_scr:=replace_subst(l_awrcomp_scr);
      --dbms_output.put_line(l_sql);
      open qlist for l_sql;
      loop
        fetch qlist into l_cmd, l_capt;
        exit when qlist%notfound;
        l_script:=l_script||chr(13)||chr(10)||l_cmd;
      end loop;
      close qlist;
      l_occ:=1;
      loop
        dbms_output.put_line('TOP SQL '||substr(l_script,instr(l_script,'prompt TOP SQL #',1,l_occ)+15,4));
        l_sql_id:=substr(l_script,instr(l_script,'define SQLID=',1,l_occ)+13,13);
        --dbms_output.put_line('SQLID='||l_sql_id);
        execute immediate replace(l_awrcomp_scr,'&SQLID.',l_sql_id);
        l_occ:=l_occ+1;
        exit when instr(l_script,'define SQLID=',1,l_occ)=0 or l_occ>20;
      end loop;
      
      loop
        DBMS_OUTPUT.GET_LINE (
          line   => l_line,
          status => l_status);
    --INSERT INTO AWRCOMP_REPORTS (DB1_SNAP_LIST,DB2_SNAP_LIST,REPORT_CONTENT)VALUES(length(l_line),'a',l_line);      
        exit when l_status=1;
        l_awrcomp_rpt:=l_awrcomp_rpt||l_line||chr(13)||chr(10);
      end loop;
      --dbms_output.put_line(length(l_awrcomp_rpt));
      --update AWRCOMP_REPORTS set REPORT_CONTENT=l_awrcomp_rpt where report_id=p_report_id;
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
      
    end;    
end;