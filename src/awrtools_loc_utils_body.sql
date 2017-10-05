create or replace package body awrtools_loc_utils as

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
    
    procedure remote_awr_load(p_stg_user varchar2, 
                              p_stg_tablespace varchar2, 
                              p_stg_temp varchar2, 
                              p_dir varchar2, 
                              p_dmpfile varchar2,
                              p_dbid out number,
                              p_min_snap_id out number,
                              p_max_snap_id out number,
                              p_min_snap_dt out timestamp,
                              p_max_snap_dt out timestamp,
                              p_db_description out varchar2)
    is
    begin
      delete from awrdumps@&DBLINK.;
      commit;
      awrtools_rem_utils.awr_load@&DBLINK. (
          P_STG_USER => P_STG_USER,
          P_STG_TABLESPACE => P_STG_TABLESPACE,
          P_STG_TEMP => P_STG_TEMP,
          P_DIR => P_DIR,
          P_DMPFILE => P_DMPFILE) ;
      select
          DBID,MIN_SNAP_ID,MAX_SNAP_ID,MIN_SNAP_DT,MAX_SNAP_DT,DB_DESCRIPTION
          into p_dbid,p_min_snap_id,p_max_snap_id,p_min_snap_dt,p_max_snap_dt,p_db_description
        from awrdumps@&DBLINK.;
      delete from awrdumps@&DBLINK.;
    end;

    procedure awr_load(p_stg_user varchar2, 
                       p_stg_tablespace varchar2, 
                       p_stg_temp varchar2, 
                       p_dir varchar2, 
                       p_dmpfile varchar2,
                       p_dbid out number,
                       p_min_snap_id out number,
                       p_max_snap_id out number,
                       p_min_snap_dt out timestamp,
                       p_max_snap_dt out timestamp,
                       p_db_description out varchar2)
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

    procedure unload_dump(p_is_remote varchar2, p_snap_min number, p_snap_max number, p_dbid number)
    is
    begin
      if p_is_remote='YES' then
        awrtools_rem_utils.drop_snapshot_range@&DBLINK.(low_snap_id => p_snap_min,high_snap_id => p_snap_max,dbid => p_dbid);
      else
        dbms_workload_repository.drop_snapshot_range(low_snap_id => p_snap_min,high_snap_id => p_snap_max,dbid => p_dbid);
      end if;
    end;
end;
/