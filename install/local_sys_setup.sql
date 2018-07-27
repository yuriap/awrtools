conn sys/&localsys.@&localdb. as sysdba

create or replace directory &dirname. as '&dirpath.';
create tablespace &tblspc_name. datafile size 100m autoextend on next 100m maxsize 10000m;

create user &localscheme. identified by &localscheme.
default tablespace &tblspc_name.
temporary tablespace temp;
alter user &localscheme. quota unlimited on &tblspc_name.;

grant connect, resource to &localscheme.;
grant read, write on directory &dirname. to &localscheme.;
grant select_catalog_role to &localscheme.;
grant execute on dbms_workload_repository to &localscheme.;
grant select any table to &localscheme.;
grant execute on dbms_swrf_internal to &localscheme.;
grant execute on dbms_lock to &localscheme.;
grant create user to &localscheme.;
grant drop user to &localscheme.;
grant alter user to &localscheme.;
grant create database link to &localscheme.;
grant create view to &localscheme.;
grant create synonym to &localscheme.;
grant create job to &localscheme.;

grant select on dba_hist_sqlstat to &localscheme.;
grant select on dba_hist_database_instance to &localscheme.;
grant select on dba_hist_snapshot to &localscheme.;
grant select on dba_hist_active_sess_history to &localscheme.;
grant select on dba_procedures to &localscheme.;
grant select on dba_hist_sqltext to &localscheme.;
grant select on DBA_HIST_SQL_PLAN to &localscheme.;
grant select on DBA_HIST_SQL_BIND_METADATA to &localscheme.;
grant select on DBA_HIST_SQLBIND to &localscheme.;
grant select on V_$DATABASE to &localscheme.;
grant select on AWR_ROOT_SQL_PLAN to &localscheme.;
grant select on AWR_ROOT_SQLTEXT to &localscheme.;
grant select on dba_users to &localscheme.;
grant select on dba_hist_sysmetric_history to &localscheme.;
grant select on v_$active_session_history to &localscheme.;
grant select on dba_hist_reports to &localscheme.;
grant select on gv_$active_session_history to &localscheme.;
grant select on V_$METRICGROUP to &localscheme.;
grant select on DBA_HIST_METRIC_NAME to &localscheme.;
grant select on V_$METRICNAME to &localscheme.;

grant execute on dbms_xplan to &localscheme.;

grant select on AWR_PDB_SQL_PLAN to &localscheme.;
grant select on AWR_PDB_SQLTEXT to &localscheme.;

disc