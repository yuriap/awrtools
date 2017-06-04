rem Web AWR Tools. Ver 1.000
--remote sysdba
define dirpath="/u01/app/oracle/files/awrdata/"
create or replace directory awrdata as '&dirpath.';
create tablespace awrtoolstbs datafile size 100m autoextend on next 100m maxsize 10000m;

create user remawrtools identified by remawrtools
default tablespace awrtoolstbs
temporary tablespace temp;
alter user remawrtools quota unlimited on awrtoolstbs;
grant dba to remawrtools;
grant execute on dbms_session to remawrtools;
GRANT CREATE ANY CONTEXT TO remawrtools;
grant read, write on directory AWRDATA to remawrtools;
grant execute on dbms_swrf_internal to remawrtools;
grant create user to remawrtools;
grant drop user to remawrtools;
grant alter user to remawrtools;
grant select any table to remawrtools;
grant create job to remawrtools;
grant execute on dbms_workload_repository to remawrtools;
grant select on dba_users to remawrtools;
grant select on dba_hist_sysmetric_history to remawrtools;