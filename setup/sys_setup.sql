drop user awrtools cascade;
--under sys
define dirpath="/u01/app/oracle/files/awrdata/"

host mkdir -p &dirpath.
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
grant select any table to awrtools;
grant execute on dbms_swrf_internal to awrtools;
grant create user to awrtools;
grant drop user to awrtools;
grant alter user to awrtools;
grant create database link to awrtools;

grant select on dba_hist_sqlstat to awrtools;
grant select on dba_hist_database_instance to awrtools;
grant select on dba_hist_snapshot to awrtools;
grant select on dba_hist_active_sess_history to awrtools;
grant select on dba_procedures to awrtools;
grant select on dba_hist_sqltext to awrtools;
grant select on DBA_HIST_SQL_PLAN to awrtools;
grant select on DBA_HIST_SQL_BIND_METADATA to awrtools;
grant select on DBA_HIST_SQLBIND to awrtools;
grant select on V_$DATABASE to awrtools;
grant select on AWR_ROOT_SQL_PLAN to awrtools;
grant select on AWR_ROOT_SQLTEXT to awrtools;

grant execute on dbms_xplan to awrtools;