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
     (select dbid, min_snap_id, max_snap_id, proj_name, d.proj_id from awrdumps d, AWRTOOLPROJECT p where status='AWRLOADED' and d.proj_id=p.proj_id and IS_REMOTE='YES') loc
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
event_id     number,
module       VARCHAR2(64),
action       VARCHAR2(64),
SQL_PLAN_HASH_VALUE number,
segment_id   number,
sec          number);

create index idx_remote_ash_timeline_1 on remote_ash_timeline(sess_id);
create index idx_remote_ash_1 on remote_ash(sess_id);

create table remote_ash_seg (
sess_id      number references remote_ash_sess(sess_id) on delete cascade,
segment_id   number,
segment_name varchar2(260));

create index idx_remote_ash_seg on remote_ash_seg(sess_id);

create table remote_metrics (
sess_id      number references remote_ash_sess(sess_id) on delete cascade,
metric_id    number,
end_time     date,
value        number
);

create index idx_remote_metric on remote_metrics(sess_id);

--Logging
create table AWRTOOLS_LOG (
ts timestamp default systimestamp,
msg clob)
;
create index idx_log_ts on AWRTOOLS_LOG(ts);

--Online reports
create table AWRTOOLS_ONLINE_RPT (
    id number primary key,
	parent_id number references AWRTOOLS_ONLINE_RPT on delete cascade,
    ts timestamp default systimestamp,
    file_mimetype  varchar2(30) default 'text/html',
    file_name      varchar2(100),
    report blob,
	reportc clob)
;
create index idx_rpt_ts on AWRTOOLS_ONLINE_RPT(ts);
create index idx_rpt_prnt on AWRTOOLS_ONLINE_RPT(parent_id);
create sequence sq_online_rpt;
