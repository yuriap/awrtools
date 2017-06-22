rem Web AWR Tools. Ver 1.000
--remote schema
CREATE OR REPLACE CONTEXT remote_awr_xplan_ctx USING remote_awr_xplan_init;
create or replace procedure remote_awr_xplan_init(p_sql_id varchar2, p_plan_hash varchar2, p_dbid varchar2)
is
begin
  DBMS_SESSION.set_context('remote_awr_xplan_ctx', 'sql_id' , p_sql_id);          
  DBMS_SESSION.set_context('remote_awr_xplan_ctx', 'plan_hash' , p_plan_hash);   
  DBMS_SESSION.set_context('remote_awr_xplan_ctx', 'dbid' , p_dbid);   
end;
/
create or replace view remote_awr_plan as
select plan_table_output 
from table(dbms_xplan.display_awr(SYS_CONTEXT('remote_awr_xplan_ctx', 'sql_id'), 
                                  SYS_CONTEXT('remote_awr_xplan_ctx', 'plan_hash'), 
                                  SYS_CONTEXT('remote_awr_xplan_ctx', 'dbid'), 'ADVANCED -ALIAS'));

create table awrdumps (
dbid number,
min_snap_id number,
max_snap_id number,
min_snap_dt timestamp(3),
max_snap_dt timestamp(3),
db_description varchar2(1000)
);

@@awrtool_pkg_rem