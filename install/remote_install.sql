@install_config

conn &remotescheme./&remotescheme.@&remotedb.

CREATE OR REPLACE CONTEXT rem_&remotescheme._ctx USING remote_awr_xplan_init;
create or replace procedure remote_awr_xplan_init(p_sql_id varchar2, p_plan_hash varchar2, p_dbid varchar2)
is
begin
  DBMS_SESSION.set_context('rem_&remotescheme._ctx', 'sql_id' , p_sql_id);          
  DBMS_SESSION.set_context('rem_&remotescheme._ctx', 'plan_hash' , p_plan_hash);   
  DBMS_SESSION.set_context('rem_&remotescheme._ctx', 'dbid' , p_dbid);   
end;
/
show errors
create or replace view remote_awr_plan as
select plan_table_output 
from table(dbms_xplan.display_awr(SYS_CONTEXT('rem_&remotescheme._ctx', 'sql_id'), 
                                  SYS_CONTEXT('rem_&remotescheme._ctx', 'plan_hash'), 
                                  SYS_CONTEXT('rem_&remotescheme._ctx', 'dbid'), 'ADVANCED -ALIAS'));
show errors

create table awrdumps (
  dbid number,
  min_snap_id number,
  max_snap_id number,
  min_snap_dt timestamp(3),
  max_snap_dt timestamp(3),
  db_description varchar2(1000)
);

@../src/awrtools_rem_utils
show errors

disc