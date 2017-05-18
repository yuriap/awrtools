create database link DBAWR1 connect to remawrtools identified by remawrtools using 'localhost:1521/db12c22.localdomain';

--Create tables
create table config (
ckey varchar2(100),
cvalue varchar2(4000),
descr varchar2(200)
);

create table awrdumps (
dump_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
loading_date date default sysdate,
filename varchar2(512),
status varchar2(10) default 'NEW',
dbid number,
min_snap_id number,
max_snap_id number,
min_snap_dt timestamp(3),
max_snap_dt timestamp(3),
is_remote varchar2(10) default 'NO',
db_description varchar2(1000)
);

create table awrdumps_files (
dump_id number references awrdumps(dump_id) on delete cascade,
filebody blob
);

create table awrcomp_d_sortordrs (
dic_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
dic_value varchar2(1000),
dic_display_value varchar2(100),
dic_filename_pref varchar2(100)
);

create table awrcomp_reports(
report_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
db1_dump_id number references awrdumps(dump_id) on delete cascade,
db2_dump_id number references awrdumps(dump_id) on delete cascade,
db1_snap_list varchar2(1000),
db2_snap_list varchar2(1000),
report_sort_ordr number references awrcomp_d_sortordrs(dic_id) on delete set null,
statlimit number,
qry_filter varchar2(1000),
dblink varchar2(30),
report_content blob,
file_mimetype varchar2(30) default 'text/plain',
file_name varchar2(100)
);

create table awrcomp_scripts (
script_id varchar(100) primary key,
script_content clob
);

--Create source code objects
@awrtool_pkg_spec
set define off
@awrtool_pkg_body
set define on

--Load data
insert into config values ('WORKDIR','AWRDATA','Oracle directory for loading AWR dumps');
insert into config values ('AWRSTGUSER','AWRSTG','Staging user for AWR Load package');
insert into config values ('AWRSTGTBLSPS','AWRTOOLSTBS','Default tablespace for AWR staging user');
insert into config values ('AWRSTGTMP','TEMP','Temporary tablespace for AWR staging user');

insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(ELAPSED_TIME_DELTA)','Sort by Elapsed Time','comp_ordr_ela_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(disk_reads_delta)','Sort by Disk Reads','comp_ordr_reads_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(CPU_TIME_DELTA)','Sort by CPU time','comp_ordr_cpu_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(BUFFER_GETS_DELTA)','Sort by LIO','comp_ordr_lio_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(ELAPSED_TIME_DELTA)/decode(sum(EXECUTIONS_DELTA), null, 1,0,1, sum(EXECUTIONS_DELTA))','Sort by Ela/exec','comp_ordr_ela_exec');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(CPU_TIME_DELTA)/decode(sum(EXECUTIONS_DELTA), null, 1,0,1, sum(EXECUTIONS_DELTA))','Sort by CPU/exec','comp_ordr_cpu_exec');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(BUFFER_GETS_DELTA)/decode(sum(EXECUTIONS_DELTA), null, 1,0,1, sum(EXECUTIONS_DELTA))','Sort by LIO/exec','comp_ordr_lio_exec');

set define off

declare
  l_script clob := 
q'{
@@getcomp_iq
}';
begin
  delete from awrcomp_scripts where script_id='GETQUERYLIST';
  insert into awrcomp_scripts (script_id,script_content) values
  ('GETQUERYLIST',l_script);
end;
/

declare
  l_script clob := 
q'{
@@getplanawr_plancomp_q
}';
begin
  delete from awrcomp_scripts where script_id='GETCOMPREPORT';
  insert into awrcomp_scripts (script_id,script_content) values
  ('GETCOMPREPORT',l_script);
end;
/

declare
  l_script clob := 
q'{
@@get_comp_non_comparable_q
}';
begin
  delete from awrcomp_scripts where script_id='GETNONCOMPREPORT';
  insert into awrcomp_scripts (script_id,script_content) values
  ('GETNONCOMPREPORT',l_script);
end;
/

declare
  l_script clob := 
q'{
@@get_sysmetrics_q
}';
begin
  delete from awrcomp_scripts where script_id='GETSYSMETRREPORT';
  insert into awrcomp_scripts (script_id,script_content) values
  ('GETSYSMETRREPORT',l_script);
end;
/

set define on
commit;
