--under sys
define dirpath="/u01/app/oracle/files/awrdata/"


!mkdir -p &dirpath.
create or replace directory awrdata as '&dirpath.';

create tablespace awrtoolstbs datafile size 100m autoextend on next 100m maxsize 10000m;

create user awrtools identified by awrtools
default tablespace awrtoolstbs
temporary tablespace temp;
alter user awrtools quota unlimited on awrtoolstbs;

grant connect, resource to awrtools;
grant read, write on directory AWRDATA to awrtools;
grant select_catalog_role to awrtools;
grant execute on dbms_workload_repository to awrtools;

create table awrtools.config (
ckey varchar2(100),
cvalue varchar2(4000),
descr varchar2(200)
);

insert into awrtools.config values ('WORKDIR','AWRDATA','Oracle directory for loading AWR dumps');
insert into awrtools.config values ('AWRSTGUSER','AWRSTG','Staging user for AWR Load package');
insert into awrtools.config values ('AWRSTGTBLSPS','AWRTOOLSTBS','Default tablespace for AWR staging user');
insert into awrtools.config values ('AWRSTGTMP','TEMP','Temporary tablespace for AWR staging user');

commit;

create or replace procedure awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
p_dbid out number,
p_min_snap_id out number,
p_max_snap_id out number,
p_min_snap_dt out timestamp,
p_max_snap_dt out timestamp,
p_db_description out varchar2)
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
  dbms_swrf_internal.awr_load(schname  => p_stg_user,
                              dmpfile  => p_dmpfile,
                              dmpdir   => p_dir);
  dbms_swrf_internal.move_to_awr(schname => p_stg_user);
  dbms_swrf_internal.clear_awr_dbid;

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
/

grant execute on awr_load to awrtools;
create synonym awrtools.awr_load for awr_load;
 
