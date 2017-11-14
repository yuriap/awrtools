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
    dic_filename_pref varchar2(100) NOT NULL
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
    created        date default sysdate,
    db1_dump_id    number NOT NULL references awrdumps(dump_id) on delete cascade,
    db2_dump_id    number references awrdumps(dump_id) on delete cascade,
    db1_start_snap number,
    db1_end_snap   number,
    db2_start_snap number,
    db2_end_snap   number,
    report_type    number references awrcomp_d_report_types(dic_id),
    sortcol        number references awrcomp_d_sortordrs(dic_id),
    sortlimit      number,
    filter         varchar2(1000),
    dblink         varchar2(30),
	sql_id         varchar2(100),
    report_content blob,
    file_mimetype  varchar2(30) default 'text/html',
    file_name      varchar2(100)
);

create index awrdumpsrep1_dump_id on awrcomp_reports(db1_dump_id);
create index awrdumpsrep2_dump_id on awrcomp_reports(db2_dump_id);

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

insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref) values('AWRCOMP','AWR query plan compare report','comp_ordr_');
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref) values('AWRSQLREPORT','AWR SQL report','awr_');


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
