create or replace package awrtool_pkg as

  procedure awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2);
  
  procedure awr_load_i(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
                       p_dbid out number,p_min_snap_id out number,p_max_snap_id out number,p_min_snap_dt out timestamp,p_max_snap_dt out timestamp,p_db_description out varchar2);
  procedure drop_snapshot_range(low_snap_id number, high_snap_id number, dbid number);
end;
/
create or replace package body awrtool_pkg as

    procedure drop_snapshot_range(low_snap_id number, high_snap_id number, dbid number)
	is
	  l_cnt number;
	begin
	    --single user procedure (no any checks)
	    dbms_scheduler.create_job(job_name => 'DROPAWRRANGE',
                            job_type => 'PLSQL_BLOCK' ,
                            job_action => 'begin	
      dbms_workload_repository.drop_snapshot_range(low_snap_id => '||low_snap_id||',high_snap_id => '||high_snap_id||',dbid => '||dbid||');	
end;'
							,
                            start_date => systimestamp,
                            enabled => true,
                            auto_drop => true);
	end;

    procedure awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2)
	is
	  l_cnt number;
	begin
	    --single user procedure (no any checks)
	    dbms_scheduler.create_job(job_name => 'AWRDUMPLOAD',
                            job_type => 'PLSQL_BLOCK' ,
                            job_action => 'declare
l_dbid number;
l_min_snap_id number;
l_max_snap_id number;
l_min_snap_dt timestamp(3);
l_max_snap_dt timestamp(3);
l_db_description awrdumps.db_description%type;
begin							
      awrtool_pkg.awr_load_i(p_stg_user => '''||p_stg_user||''',
        p_stg_tablespace => '''||p_stg_tablespace||''', 
        p_stg_temp => '''||p_stg_temp||''', 
        p_dir => '''||p_dir||''', 
        p_dmpfile => '''||p_dmpfile||''',
        p_dbid=>l_dbid,
        p_min_snap_id=>l_min_snap_id,
        p_max_snap_id=>l_max_snap_id,
        p_min_snap_dt=>l_min_snap_dt,
        p_max_snap_dt=>l_max_snap_dt,
        p_db_description=>l_db_description);
    insert into awrdumps values(l_dbid,l_min_snap_id,l_max_snap_id,l_min_snap_dt,l_max_snap_dt,l_db_description);
    commit;
end;'
							,
                            start_date => systimestamp,
                            enabled => true,
                            auto_drop => true);
	    loop
	      select count(1) into l_cnt from awrdumps;
	      exit when l_cnt>0;
	    end loop;

	end;
	
    procedure awr_load_i(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
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
end;
/