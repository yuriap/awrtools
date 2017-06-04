rem Web AWR Tools. Ver 1.000

begin
  for i in (select proj_id from awrtoolproject) loop
    awrtools_api.archive_project(i.proj_id);
  end loop;
end;
/

drop table awrcomp_scripts;
drop table awrconfig;
drop table awrcomp_reports;
drop table awrdumps_files;
drop table awrdumps;
drop table awrtoolproject;
drop table awrcomp_d_sortordrs;
drop table awrcomp_d_report_types;


define DBLINK=DBAWR1

create database link &DBLINK. connect to remawrtools identified by remawrtools using 'localhost:1521/db12c22.localdomain';

--Create tables

CREATE TABLE awrtoolproject (
    proj_id            NUMBER GENERATED ALWAYS AS IDENTITY primary key,
    proj_name          VARCHAR2(100),
    proj_date          DATE default sysdate,
    proj_description   VARCHAR2(4000),
    proj_status        varchar2(10) default 'ACTIVE' not null check (proj_status in ('ACTIVE','ARCHIVED','COMPRESSED'))
);


create table awrconfig (
ckey varchar2(100),
cvalue varchar2(4000),
descr varchar2(200)
);

create table awrdumps (
dump_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
proj_id NUMBER NOT NULL REFERENCES awrtoolproject ( proj_id ) on delete cascade,
loading_date date default sysdate,
filename varchar2(512),
status varchar2(10) default 'NEW' check (status in ('NEW','LOADED','UNLOADED','COMPRESSED')),
dbid number,
min_snap_id number,
max_snap_id number,
min_snap_dt timestamp(3),
max_snap_dt timestamp(3),
is_remote varchar2(10) default 'NO' NOT NULL check (is_remote in ('YES','NO')),
db_description varchar2(1000),
dump_description varchar2(4000)
);

create index awrdumps_proj on awrdumps(proj_id);

create table awrdumps_files (
dump_id number NOT NULL unique references awrdumps(dump_id) on delete cascade,
filebody blob
);


create table awrcomp_d_sortordrs (
dic_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
dic_value varchar2(1000) NOT NULL,
dic_display_value varchar2(100),
dic_filename_pref varchar2(100) NOT NULL
);

create table awrcomp_d_report_types (
dic_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
dic_value varchar2(1000) NOT NULL,
dic_display_value varchar2(100),
dic_filename_pref varchar2(100) NOT NULL
);

create table awrcomp_reports(
report_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
created date default sysdate,
db1_dump_id number NOT NULL references awrdumps(dump_id) on delete cascade,
db2_dump_id number NOT NULL references awrdumps(dump_id) on delete cascade,
db1_snap_list varchar2(1000),
db2_snap_list varchar2(1000),
report_type number references awrcomp_d_sortordrs(dic_id),
report_sort_ordr number references awrcomp_d_report_types(dic_id),
statlimit number,
qry_filter varchar2(1000),
dblink varchar2(30),
report_content blob,
file_mimetype varchar2(30) default 'text/plain',
file_name varchar2(100)
);

create index awrdumpsrep1_dump_id on awrcomp_reports(db1_dump_id);
create index awrdumpsrep2_dump_id on awrcomp_reports(db2_dump_id);

create table awrcomp_scripts (
script_id varchar(100) primary key,
script_content clob
);

--Create source code objects
@awrtool_pkg_spec
set define off
@awrtool_pkg_body
set define on
@awrtool_api_spec
@awrtool_api_body
@awrtools_contr_spec 
@awrtools_contr_body

--Load data
insert into awrconfig values ('WORKDIR','AWRDATA','Oracle directory for loading AWR dumps');
insert into awrconfig values ('AWRSTGUSER','AWRSTG','Staging user for AWR Load package');
insert into awrconfig values ('AWRSTGTBLSPS','AWRTOOLSTBS','Default tablespace for AWR staging user');
insert into awrconfig values ('AWRSTGTMP','TEMP','Temporary tablespace for AWR staging user');
insert into awrconfig values ('DBLINK','&DBLINK.','DB link name for remote AWR repository');
insert into awrconfig values ('TOOLVERSION','1.2','AWR tool version');

insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(ELAPSED_TIME_DELTA)','Sort by Elapsed Time','ela_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(disk_reads_delta)','Sort by Disk Reads','reads_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(CPU_TIME_DELTA)','Sort by CPU time','cpu_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(BUFFER_GETS_DELTA)','Sort by LIO','lio_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(ELAPSED_TIME_DELTA)/decode(sum(EXECUTIONS_DELTA), null, 1,0,1, sum(EXECUTIONS_DELTA))','Sort by Ela/exec','ela_exec');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(CPU_TIME_DELTA)/decode(sum(EXECUTIONS_DELTA), null, 1,0,1, sum(EXECUTIONS_DELTA))','Sort by CPU/exec','cpu_exec');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('sum(BUFFER_GETS_DELTA)/decode(sum(EXECUTIONS_DELTA), null, 1,0,1, sum(EXECUTIONS_DELTA))','Sort by LIO/exec','lio_exec');

insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref) values('AWRCOMP','AWR query plan compare report','comp_ordr_');
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref) values('AWRMETRICS','AWR metrics report','sysmetrics');


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
