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
    db_description varchar2(1000),
    dump_description varchar2(4000)
);

create index awrdumps_proj on awrdumps(proj_id);

create table awrdumps_files (
    dump_id number NOT NULL unique references awrdumps(dump_id) on delete cascade,
    filebody blob
);

alter table AWRDUMPS_FILES move lob (FILEBODY) store as (compress high);


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

alter table awrcomp_reports move lob (report_content) store as (compress high);

create table awrcomp_reports_params (
    report_id      number references awrcomp_reports(report_id) on delete cascade,
    param_name     varchar2(128),
    param_value    varchar2(4000)
);    

create or replace synonym awrdumps_rem for awrdumps@&DBLINK.;

create or replace synonym awrtools_rem_utils_rem for awrtools_rem_utils@&DBLINK.;

create or replace synonym dba_hist_snapshot_rem for dba_hist_snapshot@&DBLINK.;
create or replace synonym v$database_rem for v$database@&DBLINK.;
    
create index IDX_PARAMS_RPT_ID on awrcomp_reports_params(report_id);

CREATE OR REPLACE FORCE EDITIONABLE VIEW AWRCOMP_REMOTE_DATA as
select x1.snap_id, x1.dbid, x1.instance_number, x1.startup_time, x1.begin_interval_time, x1.end_interval_time, x1.snap_level,x1.error_count, 
       decode(loc.proj_name,null,'<UNKNOWN PROJECT>',loc.proj_name) project, loc.proj_id
from dba_hist_snapshot_rem x1,
     (select dbid, min_snap_id, max_snap_id, proj_name, d.proj_id from awrdumps d, AWRTOOLPROJECT p where status='AWRLOADED' and d.proj_id=p.proj_id) loc
where x1.dbid<>(select dbid from v$database_rem) 
and x1.dbid=loc.dbid(+) and x1.snap_id between loc.min_snap_id(+) and loc.max_snap_id(+)
order by x1.dbid,x1.snap_id;

--Online ASH Dashboard
create table remote_ash_sess (
sess_id number generated always as identity,
sess_created timestamp default systimestamp,
primary key (sess_id));

create table remote_ash_timeline (
sess_id      number references remote_ash_sess(sess_id) on delete cascade,
sample_time  date);

create table remote_ash (
sess_id      number references remote_ash_sess(sess_id) on delete cascade,
sample_time  date,
wait_class   VARCHAR2(64),
sql_id       VARCHAR2(13),
event        VARCHAR2(64),
module       VARCHAR2(64),
action       VARCHAR2(64),
SQL_PLAN_HASH_VALUE number,
sec          number);

create index idx_remote_ash_timeline_1 on remote_ash_timeline(sess_id);
create index idx_remote_ash_1 on remote_ash(sess_id);

--Logging
create table AWRTOOLS_LOG (
ts timestamp default systimestamp,
msg clob)
;
create index idx_log_ts on AWRTOOLS_LOG(ts);

--Online reports
create table AWRTOOLS_ONLINE_RPT (
    id number primary key,
    ts timestamp default systimestamp,
    file_mimetype  varchar2(30) default 'text/html',
    file_name      varchar2(100),
    report blob,
	reportc clob)
;
create index idx_rpt_ts on AWRTOOLS_ONLINE_RPT(ts);
create sequence sq_online_rpt;


--Create source code objects

@../src/awrtools_contr_spec 
show errors
@../src/awrtools_contr_body
show errors

@../src/awrtools_loc_utils_spec
show errors
set define off
@../src/awrtools_loc_utils_body
set define on
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

@../src/awrtools_logging
@../src/AWRTOOLS_REMOTE_ANALYTICS

--Load data
insert into awrconfig values ('WORKDIR',upper('&dirname.'),'Oracle directory for loading AWR dumps');
insert into awrconfig values ('AWRSTGUSER','&AWRSTG.','Staging user for AWR Load package');
insert into awrconfig values ('AWRSTGTBLSPS','&tblspc_name.','Default tablespace for AWR staging user');
insert into awrconfig values ('AWRSTGTMP','TEMP','Temporary tablespace for AWR staging user');
insert into awrconfig values ('DBLINK','&DBLINK.','DB link name for remote AWR repository');
insert into awrconfig values ('TOOLVERSION','&awrtoolversion.','AWR tool version');

insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('ELAPSED_TIME_DELTA','Sort by Elapsed Time','ela_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('DISK_READS_DELTA','Sort by Disk Reads','reads_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('CPU_TIME_DELTA','Sort by CPU time','cpu_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('BUFFER_GETS_DELTA','Sort by LIO','lio_tot');

insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRCOMP','AWR query plan compare report (custom)','comp_ordr_',10);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRSQLREPORT','AWR SQL report (custom)','awr_',20);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('SQLMULTIPLAN','Analyze SQLs with multiple plans (custom)','awr_multi_',30);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRRPT','AWR report (standard)','awrrpt_',40);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRGLOBALRPT','AWR global report (standard)','awrrpt_glob_',50);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRSQRPT','AWR SQL report (standard)','awrsql_',60);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRDIFF','AWR diff (standard)','awr_diff_',70);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRGLOBALDIFF','AWR global diff (standard)','awr_diff_glob_',80);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('ASHRPT','ASH report (standard)','awr_ash_',90);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('ASHGLOBALRPT','ASH global report (standard)','awr_ash_glob_',100);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('ASHANALYTICS','ASH analytics report (standard)','ash_analyt_',110);

begin
  dbms_scheduler.drop_job(job_name => 'AWRTOOL_CLEANUP');
end;
/
begin
  dbms_scheduler.create_job(job_name => 'AWRTOOL_CLEANUP',
                            job_type => 'PLSQL_BLOCK',
                            job_action => 'begin AWRTOOLS_REMOTE_ANALYTICS.AWRTOOL_CLEANUP_ASHSESS; AWRTOOLS_LOGGING.cleanup; AWRTOOLS_REMOTE_ANALYTICS.AWRTOOL_CLEANUP_RPT; end;',
                            start_date => trunc(systimestamp,'hh'),
                            repeat_interval => 'FREQ=MINUTELY; INTERVAL=15',
                            enabled => true);
end;
/

set define off
set serveroutput on

declare
  l_script clob := 
q'^
@../scripts/_getplanawrh
^';
begin
  delete from awrcomp_scripts where script_id='GETAWRSQLREPORT';
  insert into awrcomp_scripts (script_id,script_content) values ('GETAWRSQLREPORT',l_script);
end;
/

declare
  l_script clob := 
q'^
@../scripts/_getcomph.sql
^';
begin
  delete from awrcomp_scripts where script_id='GETCOMPREPORT';
  insert into awrcomp_scripts (script_id,script_content) values 'GETCOMPREPORT',l_script||l_script1);
  dbms_output.put_line('#1: '||dbms_lob.getlength(l_script)||' bytes; #2: '||dbms_lob.getlength(l_script1)||' bytes;');
end;
/

declare
  l_script clob;
begin
  l_script := 
q'^
@../scripts/__prn_tbl_html.sql
^';
  delete from awrcomp_scripts where script_id='PROC_PRNHTMLTBL';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_PRNHTMLTBL',l_script);

  l_script := 
q'^
@../scripts/__getftxt.sql
^';
  delete from awrcomp_scripts where script_id='PROC_GETGTXT';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_GETGTXT',l_script);

  l_script := 
q'^
@../scripts/__nonshared1.sql
^';
  delete from awrcomp_scripts where script_id='PROC_NON_SHARED';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_NON_SHARED',l_script);

  l_script := 
q'^
@../scripts/__vsql_stat.sql
^';
  delete from awrcomp_scripts where script_id='PROC_VSQL_STAT';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_VSQL_STAT',l_script);

  l_script := 
q'^
@../scripts/__offload_percent1.sql
^';
  delete from awrcomp_scripts where script_id='PROC_OFFLOAD_PCT1';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_OFFLOAD_PCT1',l_script);
  
  l_script := 
q'^
@../scripts/__sqlmon1.sql
^';
  delete from awrcomp_scripts where script_id='PROC_SQLMON';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_SQLMON',l_script);

  l_script := 
q'^
@../scripts/__sqlwarea.sql
^';
  delete from awrcomp_scripts where script_id='PROC_SQLWORKAREA';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_SQLWORKAREA',l_script);

  l_script := 
q'^
@../scripts/__optenv.sql
^';
  delete from awrcomp_scripts where script_id='PROC_OPTENV';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_OPTENV',l_script);

  l_script := 
q'^
@../scripts/__rac_plans.sql
^';
  delete from awrcomp_scripts where script_id='PROC_RACPLAN';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_RACPLAN',l_script);

  l_script := 
q'^
@../scripts/__sqlmon_hist.sql
^';
  delete from awrcomp_scripts where script_id='PROC_SQLMON_HIST';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_SQLMON_HIST',l_script);
end;
/

declare
  l_script clob;
begin
  l_script :=
q'{
@@../scripts/__sqlstat.sql
}';
  delete from awrcomp_scripts where script_id='PROC_AWRSQLSTAT';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRSQLSTAT',l_script);
  
  l_script := 
q'[
@@../scripts/__ash_summ
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHSUMM';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHSUMM',l_script);

  l_script := 
q'[
@@../scripts/__ash_p1
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHP1';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHP1',l_script);

  l_script := 
q'[
@@../scripts/__ash_p1_1
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHP1_1';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHP1_1',l_script);

  l_script := 
q'[
@@../scripts/__ash_p2
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHP2';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHP2',l_script);

  l_script := 
q'[
@@../scripts/__ash_p3
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHP3';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHP3',l_script);
  l_script := 
q'[
@@../scripts/awr.css
]';
  delete from awrcomp_scripts where script_id='PROC_AWRCSS';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRCSS',l_script);  
end;
/

set define on
commit;

disc
