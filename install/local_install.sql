conn &localscheme./&localscheme.@&localdb.

create database link &DBLINK. connect to &remotescheme. identified by &remotescheme. using '&dblinkstr.';

--Create tables

create table awrconfig (
    ckey varchar2(100),
    cvalue varchar2(4000),
    descr varchar2(200)
);

create table awrcomp_scripts (
    script_id varchar(100) primary key,
    script_content clob
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
    dic_filename_pref varchar2(100) NOT NULL,
	dic_ordr number
);

CREATE TABLE awrtoolproject (
    proj_id            NUMBER GENERATED ALWAYS AS IDENTITY primary key,
    proj_name          VARCHAR2(100),
    proj_date          DATE default sysdate,
    proj_description   VARCHAR2(4000),
    proj_status        varchar2(10) /* default 'ACTIVE' not null check (proj_status in ('ACTIVE','ARCHIVED','COMPRESSED'))*/
);


create table awrdumps (
    dump_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
    proj_id NUMBER NOT NULL REFERENCES awrtoolproject ( proj_id ) on delete cascade,
    loading_date date default sysdate,
    filename varchar2(512),
    status varchar2(10), /* default 'NEW' check (status in ('NEW','LOADED','UNLOADED','COMPRESSED')), */
    dbid number,
    min_snap_id number,
    max_snap_id number,
    min_snap_dt timestamp(3),
    max_snap_dt timestamp(3),
    is_remote varchar2(10) default 'NO' NOT NULL check (is_remote in ('YES','NO')),
	sql_id varchar2(100),
    db_description varchar2(1000),
    dump_description varchar2(4000)
);

create index awrdumps_proj on awrdumps(proj_id);

create table awrdumps_files (
    dump_id number NOT NULL unique references awrdumps(dump_id) on delete cascade,
    filebody blob
);




create table awrcomp_reports(
    report_id      NUMBER GENERATED ALWAYS AS IDENTITY primary key,
	proj_id        NUMBER NOT NULL REFERENCES awrtoolproject ( proj_id ) on delete cascade,
    created        date default sysdate,
    report_type    number references awrcomp_d_report_types(dic_id),
    report_content blob,
    file_mimetype  varchar2(30) default 'text/html',
    file_name      varchar2(100),
	report_params_displ varchar2(1000)
);

create table awrcomp_reports_params (
    report_id      number references awrcomp_reports(report_id) on delete cascade,
	param_name     varchar2(128),
    param_value    varchar2(4000)
);	
	
create index IDX_PARAMS_RPT_ID on awrcomp_reports_params(report_id);
	
create or replace view awrcomp_remote_data as
select snap_id, dbid, instance_number, startup_time, begin_interval_time, end_interval_time, snap_level,error_count from dba_hist_snapshot@&DBLINK. x2 where dbid<>(select dbid from v$database@&DBLINK.);

--Create source code objects

@../src/awrtools_contr_spec 
show errors
@../src/awrtools_contr_body
show errors

@../src/awrtools_loc_utils_spec
show errors
@../src/awrtools_loc_utils_body
show errors

@../src/awrtools_api_spec
show errors
@../src/awrtools_api_body
show errors

@../src/awrtools_reports_spec
show errors
set define off
@../src/awrtools_reports_body
set define on
show errors


--Load data
insert into awrconfig values ('WORKDIR',upper('&dirname.'),'Oracle directory for loading AWR dumps');
insert into awrconfig values ('AWRSTGUSER','AWRSTG','Staging user for AWR Load package');
insert into awrconfig values ('AWRSTGTBLSPS','&tblspc_name.','Default tablespace for AWR staging user');
insert into awrconfig values ('AWRSTGTMP','TEMP','Temporary tablespace for AWR staging user');
insert into awrconfig values ('DBLINK','&DBLINK.','DB link name for remote AWR repository');
insert into awrconfig values ('TOOLVERSION','&awrtoolversion.','AWR tool version');

insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('ELAPSED_TIME_DELTA','Sort by Elapsed Time','ela_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('DISK_READS_DELTA','Sort by Disk Reads','reads_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('CPU_TIME_DELTA','Sort by CPU time','cpu_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('BUFFER_GETS_DELTA','Sort by LIO','lio_tot');

insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRCOMP','AWR query plan compare report (custom)','comp_ordr_',1);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRSQLREPORT','AWR SQL report (custom)','awr_',2);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRRPT','AWR report (standard)','awrrpt_',3);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRGLOBALRPT','AWR global report (standard)','awrrpt_glob_',4);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRSQRPT','AWR SQL report (standard)','awrsql_',5);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRDIFF','AWR diff (standard)','awr_diff_',6);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRGLOBALDIFF','AWR global diff (standard)','awr_diff_glob_',7);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('ASHRPT','ASH report (standard)','awr_ash_',8);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('ASHGLOBALRPT','ASH global report (standard)','awr_ash_glob_',9);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('ASHANALYTICS','ASH analytics report (standard)','ash_analyt_',10);


set define off

declare
  l_script clob := 
q'^
@../scripts/_getcomph.sql
^';
begin
  delete from awrcomp_scripts where script_id='GETCOMPREPORT';
  insert into awrcomp_scripts (script_id,script_content) values
  ('GETCOMPREPORT',l_script||l_script1);
end;
/

declare
  l_script clob := 
q'^
@../scripts/_getplanawrh
^';
begin
  delete from awrcomp_scripts where script_id='GETAWRSQLREPORT';
  insert into awrcomp_scripts (script_id,script_content) values
  ('GETAWRSQLREPORT',l_script);
end;
/

set define on
commit;

disc
