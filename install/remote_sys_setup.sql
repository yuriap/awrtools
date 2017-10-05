conn sys/&remotesys.@&remotedb. as sysdba

create or replace directory &dirname. as '&dirpath.';
create tablespace &tblspc_name. datafile size 100m autoextend on next 100m maxsize 10000m;

create user &remotescheme. identified by &remotescheme.
default tablespace &tblspc_name.
temporary tablespace temp;
alter user &remotescheme. quota unlimited on &tblspc_name.;
grant dba to &remotescheme.;
grant execute on dbms_session to &remotescheme.;
GRANT CREATE ANY CONTEXT TO &remotescheme.;
grant read, write on directory &dirname. to &remotescheme.;
grant execute on dbms_swrf_internal to &remotescheme.;
grant create user to &remotescheme.;
grant drop user to &remotescheme.;
grant alter user to &remotescheme.;
grant select any table to &remotescheme.;
grant create job to &remotescheme.;
grant execute on dbms_workload_repository to &remotescheme.;
grant select on dba_users to &remotescheme.;
grant select on dba_hist_sysmetric_history to &remotescheme.;
grant execute on dbms_lock to awrtools20;

disc