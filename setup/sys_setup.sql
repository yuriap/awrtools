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

create table awrtools.config (
ckey varchar2(100),
cvalue varchar2(4000)
);

insert into awrtools.config values ('WORKDIR','AWRDATA');
insert into awrtools.config values ('AWRSTGUSER','AWRSTG');
insert into awrtools.config values ('AWRSTGTBLSPS','AWRTOOLSTBS');
insert into awrtools.config values ('AWRSTGTMP','TEMP');

commit;

create or replace procedure awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2)
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

  execute immediate 'drop user '||p_stg_user||' cascade';
end;
/

grant execute on awr_load to awrtools;
create synonym awrtools.awr_load for awr_load;
