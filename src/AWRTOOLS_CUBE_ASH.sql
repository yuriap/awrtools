create or replace PACKAGE AWRTOOLS_CUBE_ASH AS

  procedure load_cube_ash     (p_sess_id in out number,
                               p_source varchar2,
                               p_dblink varchar2,
                               p_agg varchar2,
                               p_inst_id varchar2,
                               p_start_dt date,
                               p_end_dt date,
                               p_filter varchar2,
                               p_dump_id number default null,
                               p_metric_id number default null,
                               p_metricgroup_id number default null,
                               p_aggr_func varchar2 default null,
                               p_block_analyze boolean default false,
                               p_unknown_analyze boolean default false,
                               p_monitor boolean default false,
                               p_topsess boolean default false);

  procedure load_cube_ash_mon (p_sess_id number,
                               p_source varchar2,
                               p_dblink varchar2,
                               p_agg varchar2,
                               p_inst_id varchar2,
                               p_start_dt date,
                               p_end_dt date,
                               p_filter varchar2,
                               p_dump_id number default null,
                               p_metric_id number default null,
                               p_metricgroup_id number default null,
                               p_aggr_func varchar2 default null,
                               p_block_analyze boolean default false,
                               p_unknown_analyze boolean default false,
                               p_monitor boolean default false,
                               p_topsess boolean default false);

  procedure CLEANUP_CUBE_ASH;
  procedure load_dic(p_db_link varchar2, p_src_tab varchar2);

END AWRTOOLS_CUBE_ASH;
/

create or replace PACKAGE BODY AWRTOOLS_CUBE_ASH AS

  procedure CLEANUP_CUBE_ASH
  is
  begin
    delete from cube_ash_sess where sess_created < (systimestamp - to_number(awrtools_api.getconf('CUBE_EXPIRE_TIME'))/24/60);
    dbms_output.put_line('Deleted '||sql%rowcount||' session(s).');
    commit;
  exception
    when others then rollback;dbms_output.put_line(sqlerrm);
  end;

  procedure load_cube_ash_i   (p_sess_id in out number,
                               p_source varchar2,
                               p_dblink varchar2,
                               p_agg varchar2,
                               p_inst_id varchar2,
                               p_start_dt date,
                               p_end_dt date,
                               p_filter varchar2,
                               p_dump_id number default null,
                               p_metric_id number default null,
                               p_metricgroup_id number default null,
                               p_aggr_func varchar2 default null,
                               p_block_analyze boolean default false,
                               p_unknown_analyze boolean default false,
                               p_monitor boolean default false,
                               p_topsess boolean default false)
  is
    l_dbid     number;
    l_min_snap number;
    l_max_snap number;
    l_int_size number;
    l_inst_id  number;
    l_inst_list varchar2(32765);
    l_start_dt date;
    l_end_dt date;
    l_interval number;

    l_sql_template varchar2(32765):=
   q'[SELECT   /*+ driving_site(x) */ :P_SESS_ID, <GROUPBY_COL>
            ,NVL(WAIT_CLASS,'CPU'),nvl(sql_id,'<UNKNOWN SQL>'),nvl(event, 'CPU'),nvl(EVENT_ID,-1),MODULE,ACTION,SQL_ID,SQL_PLAN_HASH_VALUE,current_obj#
            ,COUNT(1)
            ,GROUPING_ID (<GROUPBY_COL>, NVL(WAIT_CLASS,'CPU')) g1
            ,GROUPING_ID (nvl(sql_id,'<UNKNOWN SQL>')) g2
            ,GROUPING_ID (nvl(event, 'CPU'), nvl(EVENT_ID,-1)) g3
            ,GROUPING_ID (module,ACTION) g4
            ,GROUPING_ID (sql_id, SQL_PLAN_HASH_VALUE) g5
            ,GROUPING_ID (current_obj#) g6
     FROM   <SOURCE_TABLE> x
    WHERE   <DBID>
      AND   <INSTANCE_NUMBER> in (<P_INST_ID>)
      AND   <SNAP_FILTER>
      AND   SAMPLE_TIME BETWEEN :P_START_DT AND :P_END_DT
      AND   <FILTER>
    GROUP BY  grouping sets (
                            (<GROUPBY_COL>, NVL(WAIT_CLASS,'CPU')),
                            (nvl(sql_id,'<UNKNOWN SQL>')),
                            (nvl(event, 'CPU'), nvl(EVENT_ID,-1)),
                            (module,ACTION),
                            (sql_id, SQL_PLAN_HASH_VALUE),
                            (current_obj# )
                           )]';

    l_sql_template_metrics varchar2(32765):=
q'[insert into cube_metrics (sess_id, metric_id, end_time, value)
   select   :P_SESS_ID, metric_id, <GROUPBY_COL>, <AGGFNC>
     from   <SOURCE_TABLE>
    where   <DBID>
      AND   <INSTANCE_NUMBER> in (<P_INST_ID>)
      AND   <SNAP_FILTER>
      AND   end_time BETWEEN :P_START_DT AND :P_END_DT
      and   metric_id = :P_METRIC_ID
      and   group_id=:p_metricgroup_id
    group by <GROUPBY_COL>, metric_id]';

    l_sql_block_template varchar2(32765):=
   q'[insert into CUBE_BLOCK_ASH (SESS_ID,SESSION_ID,SESSION_SERIAL#,INST_ID,SQL_ID,MODULE,ACTION,BLOCKING_SESSION,BLOCKING_SESSION_SERIAL#,BLOCKING_INST_ID,CNT)
      select /*+ driving_site(x) */
            :P_SESS_ID, session_id, session_serial#, <INSTANCE_NUMBER>, sql_id, module, action, blocking_session, blocking_session_serial#, blocking_inst_id, cnt<MULT> from(
      select  x1.*, sum(cnt)over() tot from (
         select
                 session_id, session_serial#, <INSTANCE_NUMBER>, sql_id, module, action, blocking_session, blocking_session_serial#, blocking_inst_id,
                 count(1) cnt
            from <SOURCE_TABLE> x
           where <DBID>
             AND <INSTANCE_NUMBER> in (<P_INST_ID>)
             AND <SNAP_FILTER>
             AND SAMPLE_TIME BETWEEN :P_START_DT AND :P_END_DT
             AND <FILTER>
             and wait_class = 'Application'
           group by session_id, session_serial#, <INSTANCE_NUMBER>, sql_id, module, action, blocking_session, blocking_session_serial#, blocking_inst_id) x1)
           where cnt/tot>0.001]';

    l_sql_unknown_template varchar2(32765):=
   q'[insert into cube_ash_unknown (sess_id,unknown_type,session_type,program,client_id,machine,ecid,username,smpls)
      select /*+ driving_site(x) */
            :P_SESS_ID, unknown_type,
            session_type, program, client_id, machine, ecid, coalesce((select username from <DBA_USERS> u where u.user_id=x2.user_id),to_char(x2.user_id)) username, cnt from(
      select  x1.*, sum(cnt)over() tot from (
         select  case when sql_id is null and module is null then 'SQL_ID and MODULE'
                        when sql_id is null and module is not null then 'SQL_ID'
                        when sql_id is not null and module is null then 'MODULE' end unknown_type,
                 session_type, program, client_id, machine, ecid, user_id, count(1) cnt
            from <SOURCE_TABLE> x
           where <DBID>
             AND <INSTANCE_NUMBER> in (<P_INST_ID>)
             AND <SNAP_FILTER>
             AND SAMPLE_TIME BETWEEN :P_START_DT AND :P_END_DT
             AND <FILTER>
             and (sql_id is null or (module is null and action is null))
           group by case when sql_id is null and module is null then 'SQL_ID and MODULE'
                        when sql_id is null and module is not null then 'SQL_ID'
                        when sql_id is not null and module is null then 'MODULE' end,
                    session_type,program, client_id,machine,ecid,user_id) x1)x2
           where cnt/tot>0.005]';

    l_sql_topsess_template varchar2(32765):=
    q'[INSERT INTO cube_top_sess (sess_id,session_id,session_serial#,inst_id,module,action,program,client_id,machine,ecid,username,smpls)
      select /*+ driving_site(x) */
                :P_SESS_ID, session_id, session_serial#, <INSTANCE_NUMBER>, module, action, program,client_id,machine,ecid,user_id, cnt<MULT> from(
          select
                 session_id, session_serial#, <INSTANCE_NUMBER>, module, action,program,client_id,machine,ecid,user_id,
                 count(1) cnt
            from <SOURCE_TABLE> x
           where <DBID>
             AND <INSTANCE_NUMBER> in (<P_INST_ID>)
             AND <SNAP_FILTER>
             AND SAMPLE_TIME BETWEEN :P_START_DT AND :P_END_DT
             AND <FILTER>
           group by session_id, session_serial#, <INSTANCE_NUMBER>, module, action,program,client_id,machine,ecid,user_id)]';


    l_sql varchar2(32765);
    l_crsr sys_refcursor;
  begin
    awrtools_logging.log('Start load_data_cube','DEBUG');

    if p_monitor and not(p_dblink <> '$LOCAL$' and p_source = 'V$VIEW') then
      raise_application_error(-20000, 'Monitor mode is availiable only for remote V$ input.');
    end if;
    if p_monitor and p_sess_id is null then
      raise_application_error(-20000, 'P_SESS_ID must be specified for Monitor mode.');
    end if;

    if not p_monitor then
      insert into cube_ash_sess (sess_id, sess_created) values (sq_cube.nextval, default) returning sess_id into p_sess_id;
    end if;

    if p_monitor then
      select max(sample_time)+0.5/24/3600 into l_start_dt from cube_ash where sess_id=p_sess_id;
      l_interval:=p_end_dt-p_start_dt;
      if l_start_dt is null then
        l_start_dt:=p_start_dt;
        l_end_dt:=p_end_dt;
      else
        execute immediate 'select systimestamp from dual@'||p_dblink into l_end_dt;
        l_start_dt:=l_end_dt-l_interval;
      end if;
    else
      l_start_dt:=p_start_dt;
      l_end_dt:=p_end_dt;
    end if;

    if p_dblink <> '$LOCAL$' then
      if instr(p_inst_id,'-1')>0 then
        open l_crsr for 'select inst_id from gv$instance@'||p_dblink||' order by 1';
        loop
          fetch l_crsr into l_inst_id;
          exit when l_crsr%notfound;
          l_inst_list:=l_inst_list||l_inst_id||',';
        end loop;
        close l_crsr;
        l_inst_list:=rtrim(l_inst_list,',');
      else
        l_inst_list:=replace(replace(p_inst_id,':',','),';',',');
      end if;
      if p_source = 'AWR' then
        execute immediate 'select dbid from v$database@'||p_dblink into l_dbid;
        execute immediate replace('select min(snap_id)
            from dba_hist_snapshot@'||p_dblink||'
           where end_interval_time>=:P_START_DT
             and dbid=:P_DBID
             and instance_number in (<P_INST_ID>)','<P_INST_ID>',l_inst_list) into l_min_snap using l_start_dt, l_dbid;
        execute immediate replace('select min(snap_id)
            from dba_hist_snapshot@'||p_dblink||'
           where end_interval_time>=:P_END_DT
             and dbid=:P_DBID
             and instance_number in (<P_INST_ID>)','<P_INST_ID>',l_inst_list) into l_max_snap using l_end_dt, l_dbid;
        if l_max_snap is null then
          execute immediate replace('select max(snap_id)
              from dba_hist_snapshot@'||p_dblink||'
             where dbid=:P_DBID
               and instance_number in (<P_INST_ID>)','<P_INST_ID>',l_inst_list) into l_max_snap using l_dbid;
        end if;
      end if;
    else
      SELECT
             dbid,
             min_snap_id,
             max_snap_id
        into l_dbid, l_min_snap, l_max_snap
        FROM awrdumps d, AWRTOOLPROJECT p
       where dump_id=p_dump_id and d.proj_id=p.proj_id;
      if instr(p_inst_id,'-1')>0 then
        open l_crsr for 'select unique inst_id from DBA_HIST_DATABASE_INSTANCE where dbid=:dbid and snap_id between :id1 and :id2 order by 1' using l_dbid, l_min_snap, l_max_snap;
        loop
          fetch l_crsr into l_inst_id;
          exit when l_crsr%notfound;
          l_inst_list:=l_inst_list||l_inst_id||',';
        end loop;
        close l_crsr;
        l_inst_list:=rtrim(l_inst_list,',');
      else
        l_inst_list:=replace(replace(p_inst_id,':',','),';',',');
      end if;
    end if;

    awrtools_logging.log('p_sess_id:'||p_sess_id,'DEBUG');
    awrtools_logging.log('l_dbid:'||l_dbid,'DEBUG');
    awrtools_logging.log('p_inst_id:'||p_inst_id,'DEBUG');
    awrtools_logging.log('l_min_snap:'||l_min_snap,'DEBUG');
    awrtools_logging.log('l_max_snap:'||l_max_snap,'DEBUG');
    awrtools_logging.log('p_start_dt:'||p_start_dt,'DEBUG');
    awrtools_logging.log('p_end_dt:'||p_end_dt,'DEBUG');
    awrtools_logging.log('l_start_dt:'||l_start_dt,'DEBUG');
    awrtools_logging.log('l_end_dt:'||l_end_dt,'DEBUG');
    awrtools_logging.log('p_metric_id:'||p_metric_id,'DEBUG');
    awrtools_logging.log('p_aggr_func:'||p_aggr_func,'DEBUG');


    l_sql := replace(replace(replace(replace(replace(replace(l_sql_template,
                                                          '<SOURCE_TABLE>',case
                                                                             when p_source = 'V$VIEW' then case when p_dblink = '$LOCAL$' then 'gv$active_session_history'
                                                                                                          else 'gv$active_session_history@'||p_dblink
                                                                                                          end
                                                                             when p_source = 'AWR' then case when p_dblink = '$LOCAL$' then 'dba_hist_active_sess_history'
                                                                                                        else 'dba_hist_active_sess_history@'||p_dblink
                                                                                                        end
                                                                           end),
                                                  '<DBID>',case when p_source = 'V$VIEW' then ':P_DBID is null' else 'DBID = :P_DBID' end),
                                          '<INSTANCE_NUMBER>',case when p_source = 'V$VIEW' then 'INST_ID' else 'INSTANCE_NUMBER' end),
                                  '<SNAP_FILTER>',case when p_source = 'AWR' then 'SNAP_ID BETWEEN :P_MIN_SNAP AND :P_MAX_SNAP' else ':P_MIN_SNAP is null and :P_MAX_SNAP is null' end),
                          '<FILTER>',nvl(p_filter,'1=1')),'<P_INST_ID>',l_inst_list);
    case
      when p_agg = 'no_agg'  then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[cast(sample_time as date)]'); --somehow duplicates can be produced here and main diagram breaks, because several samples during a single second can appear.
      when p_agg = 'by_mi'   then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(sample_time,'mi')]');
      when p_agg = 'by_hour' then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(sample_time,'hh')]');
      when p_agg = 'by_day'  then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(sample_time,'dd')]');
      else
        null;
    end case;

    declare
      type ta_sess_id is table of cube_ash.sess_id%type; la_sess_id ta_sess_id;
      type ta_sample_time is table of cube_ash.sample_time%type; la_sample_time ta_sample_time;
      type ta_wait_class is table of cube_ash.wait_class%type; la_wait_class ta_wait_class;
      type ta_sql_id is table of cube_ash.sql_id%type; la_sql_id ta_sql_id;
      type ta_event is table of cube_ash.event%type; la_event ta_event;
      type ta_event_id is table of cube_ash.event_id%type; la_event_id ta_event_id;
      type ta_module is table of cube_ash.module%type; la_module ta_module;
      type ta_action is table of cube_ash.action%type; la_action ta_action;
      type ta_sql_id1 is table of cube_ash.sql_id1%type; la_sql_id1 ta_sql_id1;
      type ta_sql_plan_hash_value is table of cube_ash.sql_plan_hash_value%type; la_sql_plan_hash_value ta_sql_plan_hash_value;
      type ta_segment_id is table of cube_ash.segment_id%type; la_segment_id ta_segment_id;
      type ta_smpls is table of cube_ash.smpls%type; la_smpls ta_smpls;
      type ta_g1 is table of cube_ash.g1%type; la_g1 ta_g1;
      type ta_g2 is table of cube_ash.g2%type; la_g2 ta_g2;
      type ta_g3 is table of cube_ash.g3%type; la_g3 ta_g3;
      type ta_g4 is table of cube_ash.g4%type; la_g4 ta_g4;
      type ta_g5 is table of cube_ash.g5%type; la_g5 ta_g5;
      type ta_g6 is table of cube_ash.g6%type; la_g6 ta_g6;
    begin
      awrtools_logging.log('Start extracting cube','DEBUG');
      awrtools_logging.log(l_sql,'DEBUG');
      --execute immediate l_sql using p_sess_id, l_dbid, p_inst_id, l_min_snap, l_max_snap, p_start_dt, p_end_dt;
      open l_crsr for l_sql using p_sess_id, l_dbid, /*p_inst_id,*/ l_min_snap, l_max_snap, l_start_dt, l_end_dt;
      fetch l_crsr bulk collect into la_sess_id, la_sample_time, la_wait_class, la_sql_id, la_event, la_event_id,
                          la_module, la_action, la_sql_id1,la_sql_plan_hash_value,
                          la_segment_id, la_smpls , la_g1, la_g2, la_g3, la_g4, la_g5, la_g6;
      close l_crsr;
      awrtools_logging.log('Start saving cube','DEBUG');
      if p_monitor then
        delete from cube_ash where sess_id=p_sess_id;
        delete from cube_ash_timeline where sess_id=p_sess_id;
      end if;
      forall i in la_sess_id.first..la_sess_id.last
        INSERT INTO cube_ash
                 (sess_id, sample_time, wait_class, sql_id, event, event_id,
                  module, action, sql_id1,sql_plan_hash_value,
                  segment_id, smpls , g1, g2, g3, g4, g5, g6)
          values (la_sess_id(i), la_sample_time(i), la_wait_class(i), la_sql_id(i), la_event(i), la_event_id(i),
                  la_module(i), la_action(i), la_sql_id1(i),la_sql_plan_hash_value(i),
                  la_segment_id(i), la_smpls(i), la_g1(i), la_g2(i), la_g3(i), la_g4(i), la_g5(i), la_g6(i));
    exception
      when others then
        awrtools_logging.log('Error SQL: '||chr(10)||l_sql||chr(10)||sqlerrm);
        raise_application_error(-20000,sqlerrm);
    end;

    if not p_monitor then
      awrtools_logging.log('Start loading seg ids','DEBUG');
      --delete from cube_ash_seg where sess_id=p_sess_id;
      insert into cube_ash_seg (sess_id,segment_id)
      select * from (select p_sess_id, SEGMENT_ID from cube_ash where sess_id=p_sess_id and g6=0 order by smpls desc) where rownum<21;
      if p_dblink != '$LOCAL$' then
        begin
          awrtools_logging.log('Start loading seg names','DEBUG');
          l_sql := q'[update cube_ash_seg set segment_name=(select object_type||': '||owner||'.'||object_name from dba_objects]'||
                              case when p_dblink != '$LOCAL$' then '@'||p_dblink else null end||
                              q'[ where object_id=SEGMENT_ID) where sess_id=]'||p_sess_id;
          execute immediate l_sql;
        exception
          when others then
            awrtools_logging.log('Error SQL: '||chr(10)||l_sql||chr(10)||sqlerrm);
            raise_application_error(-20000,sqlerrm);
        end;
      end if;
      awrtools_logging.log('End loading cube','DEBUG');
    end if;

    --commit;
    --dbms_stats.gather_table_stats(ownname=> sys_context('USERENV','CURRENT_USER'), tabname=>'remote_ash', cascade=>true);

    if p_agg = 'no_agg' then
      insert /* append */ into cube_ash_timeline select unique p_sess_id, sample_time from cube_ash where sess_id = p_sess_id and g1=0;
    else
      if p_agg = 'by_mi' then
        insert /* append */ into cube_ash_timeline
          select p_sess_id,
                 trunc(l_start_dt,'mi')+(level-1)/24/60 from dual connect by level <=round((l_end_dt-trunc(l_start_dt,'mi'))*24*60)+1;
      end if;
      if p_agg = 'by_hour' then
        insert /* append */ into cube_ash_timeline
          select p_sess_id,
                 trunc(l_start_dt,'hh')+(level-1)/24 from dual connect by level <=round((l_end_dt-trunc(l_start_dt,'hh'))*24)+1;
      end if;
      if p_agg = 'by_day' then
        insert /* append */ into cube_ash_timeline
          select p_sess_id,
                 trunc(l_start_dt)+(level-1) from dual connect by level <=round(l_end_dt-trunc(l_start_dt))+1;
      end if;
    end if;

    if p_metric_id is not null then

      l_sql := replace(replace(replace(replace(replace(replace(l_sql_template_metrics,
                                                            '<SOURCE_TABLE>',case
                                                                               when p_source = 'V$VIEW' then case when p_dblink = '$LOCAL$' then 'gv$sysmetric_history'
                                                                                                            else 'gv$sysmetric_history@'||p_dblink
                                                                                                            end
                                                                               when p_source = 'AWR' then case when p_dblink = '$LOCAL$' then 'dba_hist_sysmetric_history'
                                                                                                          else 'dba_hist_sysmetric_history@'||p_dblink
                                                                                                          end
                                                                             end),
                                                    '<DBID>',case when p_source = 'V$VIEW' then ':P_DBID is null' else 'DBID = :P_DBID' end),
                                            '<INSTANCE_NUMBER>',case when p_source = 'V$VIEW' then 'INST_ID' else 'INSTANCE_NUMBER' end),
                                    '<SNAP_FILTER>',case when p_source = 'AWR' then 'SNAP_ID BETWEEN :P_MIN_SNAP AND :P_MAX_SNAP' else ':P_MIN_SNAP is null and :P_MAX_SNAP is null' end),
                            '<AGGFNC>',case when p_aggr_func in ('AVG', 'COUNT', 'SUM') then p_aggr_func||'(value)'
                                            when instr(p_aggr_func,'PCT')>0 then 'PERCENTILE_CONT('||to_number(ltrim(p_aggr_func,'PCT'))/100||') WITHIN GROUP (ORDER BY value ASC)'
                                            end),
                            '<P_INST_ID>',l_inst_list);

      select interval_size into l_int_size from V$METRICGROUP where group_id = p_metricgroup_id;
      case
        when p_agg = 'no_agg'  then
          l_sql := replace(l_sql,'<GROUPBY_COL>','end_time');
        when p_agg = 'by_mi'   then
          if l_int_size<6000 then
            l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(end_time,'mi')]');
          else
            l_sql := replace(l_sql,'<GROUPBY_COL>','end_time');
          end if;
        when p_agg = 'by_hour' then
          if l_int_size<360000 then
            l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(end_time,'hh')]');
          else
            l_sql := replace(l_sql,'<GROUPBY_COL>','end_time');
          end if;
        when p_agg = 'by_day'  then
          l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(end_time,'dd')]');
        else
          null;
      end case;

      begin
        awrtools_logging.log('Start metrics loading','DEBUG');
        awrtools_logging.log(l_sql,'DEBUG');
        if p_monitor then
          delete from cube_metrics where sess_id=p_sess_id;
        end if;
        execute immediate l_sql using p_sess_id, l_dbid, /*p_inst_id,*/ l_min_snap, l_max_snap, l_start_dt, l_end_dt, p_metric_id, p_metricgroup_id;
        awrtools_logging.log('End metrics loading','DEBUG');
      exception
        when others then
          awrtools_logging.log('Error SQL: '||chr(10)||l_sql||chr(10)||sqlerrm);
          raise_application_error(-20000,sqlerrm);
      end;
    end if;

    if p_block_analyze then
      l_sql := replace(replace(replace(replace(replace(replace(replace(l_sql_block_template,
                                                          '<SOURCE_TABLE>',case
                                                                             when p_source = 'V$VIEW' then case when p_dblink = '$LOCAL$' then 'gv$active_session_history'
                                                                                                          else 'gv$active_session_history@'||p_dblink
                                                                                                          end
                                                                             when p_source = 'AWR' then case when p_dblink = '$LOCAL$' then 'dba_hist_active_sess_history'
                                                                                                        else 'dba_hist_active_sess_history@'||p_dblink
                                                                                                        end
                                                                           end),
                                                  '<DBID>',case when p_source = 'V$VIEW' then ':P_DBID is null' else 'DBID = :P_DBID' end),
                                          '<INSTANCE_NUMBER>',case when p_source = 'V$VIEW' then 'INST_ID' else 'INSTANCE_NUMBER' end),
                                  '<SNAP_FILTER>',case when p_source = 'AWR' then 'SNAP_ID BETWEEN :P_MIN_SNAP AND :P_MAX_SNAP' else ':P_MIN_SNAP is null and :P_MAX_SNAP is null' end),
                          '<FILTER>',nvl(p_filter,'1=1')),
                          '<MULT>',case when p_source = 'AWR' then '*10' else null end),'<P_INST_ID>',l_inst_list);
      begin
        awrtools_logging.log('Start block loading','DEBUG');
        awrtools_logging.log(l_sql,'DEBUG');
--        if p_monitor then
--          delete from CUBE_BLOCK_ASH where sess_id=p_sess_id;
--        end if;
        execute immediate l_sql using p_sess_id, l_dbid, /*p_inst_id,*/ l_min_snap, l_max_snap, l_start_dt, l_end_dt;
        awrtools_logging.log('End block loading','DEBUG');
      exception
        when others then
          awrtools_logging.log('Error SQL: '||chr(10)||l_sql||chr(10)||sqlerrm);
          raise_application_error(-20000,sqlerrm);
      end;
    end if;

    if p_unknown_analyze then
      l_sql := replace(replace(replace(replace(replace(replace(replace(replace(l_sql_unknown_template,
                                                          '<SOURCE_TABLE>',case
                                                                             when p_source = 'V$VIEW' then case when p_dblink = '$LOCAL$' then 'gv$active_session_history'
                                                                                                          else 'gv$active_session_history@'||p_dblink
                                                                                                          end
                                                                             when p_source = 'AWR' then case when p_dblink = '$LOCAL$' then 'dba_hist_active_sess_history'
                                                                                                        else 'dba_hist_active_sess_history@'||p_dblink
                                                                                                        end
                                                                           end),
                                                  '<DBID>',case when p_source = 'V$VIEW' then ':P_DBID is null' else 'DBID = :P_DBID' end),
                                          '<INSTANCE_NUMBER>',case when p_source = 'V$VIEW' then 'INST_ID' else 'INSTANCE_NUMBER' end),
                                  '<SNAP_FILTER>',case when p_source = 'AWR' then 'SNAP_ID BETWEEN :P_MIN_SNAP AND :P_MAX_SNAP' else ':P_MIN_SNAP is null and :P_MAX_SNAP is null' end),
                          '<FILTER>',nvl(p_filter,'1=1')),
                          '<MULT>',case when p_source = 'AWR' then '*10' else null end),'<P_INST_ID>',l_inst_list),
                          '<DBA_USERS>',case when p_dblink = '$LOCAL$' then 'dba_users' else 'dba_users@'||p_dblink end);
      begin
        awrtools_logging.log('Start unknown loading','DEBUG');
        awrtools_logging.log(l_sql,'DEBUG');
--        if p_monitor then
--          delete from cube_ash_unknown where sess_id=p_sess_id;
--        end if;
        execute immediate l_sql using p_sess_id, l_dbid, /*p_inst_id,*/ l_min_snap, l_max_snap, l_start_dt, l_end_dt;
        awrtools_logging.log('End unknown loading','DEBUG');
      exception
        when others then
          awrtools_logging.log('Error SQL: '||chr(10)||l_sql);
          raise_application_error(-20000,sqlerrm||chr(10)||sqlerrm);
      end;
    end if;

    if p_topsess then
      l_sql := replace(replace(replace(replace(replace(replace(replace(replace(l_sql_topsess_template,
                                                          '<SOURCE_TABLE>',case
                                                                             when p_source = 'V$VIEW' then case when p_dblink = '$LOCAL$' then 'gv$active_session_history'
                                                                                                          else 'gv$active_session_history@'||p_dblink
                                                                                                          end
                                                                             when p_source = 'AWR' then case when p_dblink = '$LOCAL$' then 'dba_hist_active_sess_history'
                                                                                                        else 'dba_hist_active_sess_history@'||p_dblink
                                                                                                        end
                                                                           end),
                                                  '<DBID>',case when p_source = 'V$VIEW' then ':P_DBID is null' else 'DBID = :P_DBID' end),
                                          '<INSTANCE_NUMBER>',case when p_source = 'V$VIEW' then 'INST_ID' else 'INSTANCE_NUMBER' end),
                                  '<SNAP_FILTER>',case when p_source = 'AWR' then 'SNAP_ID BETWEEN :P_MIN_SNAP AND :P_MAX_SNAP' else ':P_MIN_SNAP is null and :P_MAX_SNAP is null' end),
                          '<FILTER>',nvl(p_filter,'1=1')),
                          '<MULT>',case when p_source = 'AWR' then '*10' else null end),'<P_INST_ID>',l_inst_list),
                          '<DBA_USERS>',case when p_dblink = '$LOCAL$' then 'dba_users' else 'dba_users@'||p_dblink end);
      begin
        awrtools_logging.log('Start top sess loading','DEBUG');
        awrtools_logging.log(l_sql,'DEBUG');
        execute immediate l_sql using p_sess_id, l_dbid, l_min_snap, l_max_snap, l_start_dt, l_end_dt;
        awrtools_logging.log('End unknown loading','DEBUG');
      exception
        when others then
          awrtools_logging.log('Error SQL: '||chr(10)||l_sql);
          raise_application_error(-20000,sqlerrm||chr(10)||sqlerrm);
      end;
    end if;
    
    commit;
    awrtools_logging.log('End load_data_cube','DEBUG');
    --dbms_stats.gather_table_stats(ownname=> sys_context('USERENV','CURRENT_USER'), tabname=>'remote_ash_timeline', cascade=>true);
  end;

  procedure load_cube_ash_mon (p_sess_id number,
                               p_source varchar2,
                               p_dblink varchar2,
                               p_agg varchar2,
                               p_inst_id varchar2,
                               p_start_dt date,
                               p_end_dt date,
                               p_filter varchar2,
                               p_dump_id number default null,
                               p_metric_id number default null,
                               p_metricgroup_id number default null,
                               p_aggr_func varchar2 default null,
                               p_block_analyze boolean default false,
                               p_unknown_analyze boolean default false,
                               p_monitor boolean default false,
                               p_topsess boolean default false)
  is
    l_sess_id number := p_sess_id;
  begin
    for i in 1..to_number(awrtools_api.getconf('MONITOR_ITERATIONS')) loop
      awrtools_logging.log('Start load Cube from job: '||i,'DEBUG');
      load_cube_ash_i   (p_sess_id =>         load_cube_ash_mon.l_sess_id,
                         p_source =>          load_cube_ash_mon.p_source,
                         p_dblink =>          load_cube_ash_mon.p_dblink,
                         p_agg =>             load_cube_ash_mon.p_agg,
                         p_inst_id =>         load_cube_ash_mon.p_inst_id,
                         p_start_dt =>        load_cube_ash_mon.p_start_dt,
                         p_end_dt =>          load_cube_ash_mon.p_end_dt,
                         p_filter =>          load_cube_ash_mon.p_filter,
                         p_dump_id =>         load_cube_ash_mon.p_dump_id,
                         p_metric_id =>       load_cube_ash_mon.p_metric_id,
                         p_metricgroup_id =>  load_cube_ash_mon.p_metricgroup_id,
                         p_aggr_func =>       load_cube_ash_mon.p_aggr_func,
                         p_block_analyze =>   load_cube_ash_mon.p_block_analyze,
                         p_unknown_analyze => load_cube_ash_mon.p_unknown_analyze,
                         p_monitor =>         load_cube_ash_mon.p_monitor,
                         p_topsess =>         load_cube_ash_mon.p_topsess);
      dbms_lock.sleep(to_number(awrtools_api.getconf('MONITOR_PAUSE')));
    end loop;
  end;

  procedure load_cube_ash     (p_sess_id in out number,
                               p_source varchar2,
                               p_dblink varchar2,
                               p_agg varchar2,
                               p_inst_id varchar2,
                               p_start_dt date,
                               p_end_dt date,
                               p_filter varchar2,
                               p_dump_id number default null,
                               p_metric_id number default null,
                               p_metricgroup_id number default null,
                               p_aggr_func varchar2 default null,
                               p_block_analyze boolean default false,
                               p_unknown_analyze boolean default false,
                               p_monitor boolean default false,
                               p_topsess boolean default false)
  is
    l_cnt number;
    l_job_name varchar2(30):='ASHMONITOR';
    l_job_body varchar2(32765);
  begin

    select count(1) into l_cnt from USER_SCHEDULER_RUNNING_JOBS where job_name=l_job_name;
    if p_monitor then
      if l_cnt>0 then
        begin
          dbms_scheduler.stop_job(job_name => l_job_name);
        exception
          when others then awrtools_logging.log('Stopping job '||l_job_name||' error: '||chr(10)||sqlerrm);
        end;
      end if;
      --if l_cnt=0 then
        insert into cube_ash_sess (sess_id, sess_created) values (sq_cube.nextval, default) returning sess_id into p_sess_id;
        l_job_body:=
q'[begin AWRTOOLS_CUBE_ASH.load_cube_ash_mon(
   p_sess_id=>]'||p_sess_id||q'[,
   p_source=>']'||p_source||q'[',
   p_dblink=>']'||p_dblink||q'[',
   p_agg=>']'||p_agg||q'[',
   p_inst_id=>']'||p_inst_id||q'[',
   p_start_dt=>to_date(']'||to_char(p_start_dt,'YYYYMMDDHH24MISS')||q'[','YYYYMMDDHH24MISS'),
   p_end_dt=>to_date(']'||to_char(p_end_dt,'YYYYMMDDHH24MISS')||q'[','YYYYMMDDHH24MISS'),]'||chr(10)||
   case when p_filter is null then q'[p_filter=>null,]' else q'[p_filter=>q'~]'||p_filter||q'[~',]' end||chr(10)||
   case when p_dump_id is null then q'[p_dump_id=>null,]' else q'[p_dump_id=>]'||p_dump_id||q'[,]' end ||chr(10)||
   case when p_metric_id is null then q'[p_metric_id=>null,]' else  q'[p_metric_id=>]'||p_metric_id||q'[,]' end ||chr(10)||
   case when p_metricgroup_id is null then q'[p_metricgroup_id=>null,']' else q'[p_metricgroup_id=>]'||p_metricgroup_id||q'[,]' end ||chr(10)||
q'[p_aggr_func=>']'||p_aggr_func||q'[',
   p_block_analyze=>]'||case when p_block_analyze then 'TRUE' else 'FALSE' end||q'[,
   p_unknown_analyze=>]'||case when p_unknown_analyze then 'TRUE' else 'FALSE' end||q'[,
   p_topsess=>]'||case when p_topsess then 'TRUE' else 'FALSE' end||q'[,
   p_monitor=>]'||case when p_monitor then 'TRUE' else 'FALSE' end||q'[); end;]';
        awrtools_logging.log(l_job_body,'DEBUG');
        dbms_scheduler.create_job(job_name => l_job_name,
                                  job_type => 'PLSQL_BLOCK',
                                  job_action => l_job_body,
                                  start_date => systimestamp,
                                  enabled => true,
                                  AUTO_DROP => true);
      --end if;
    else
      if l_cnt>0 then
        begin
          dbms_scheduler.stop_job(job_name => l_job_name);
        exception
          when others then awrtools_logging.log('Stopping job '||l_job_name||' error: '||chr(10)||sqlerrm);
        end;
      end if;
      load_cube_ash_i   (p_sess_id => p_sess_id,
                         p_source => p_source,
                         p_dblink => p_dblink,
                         p_agg => p_agg,
                         p_inst_id => p_inst_id,
                         p_start_dt => p_start_dt,
                         p_end_dt => p_end_dt,
                         p_filter => p_filter,
                         p_dump_id => p_dump_id,
                         p_metric_id => p_metric_id,
                         p_metricgroup_id => p_metricgroup_id,
                         p_aggr_func => p_aggr_func,
                         p_block_analyze => p_block_analyze,
                         p_unknown_analyze => p_unknown_analyze,
                         p_monitor => p_monitor,
                         p_topsess => p_topsess);
    end if;
  end;

   procedure load_dic(p_db_link varchar2, p_src_tab varchar2)
   is
     l_cnt number;
     dicRACNODES varchar2(32):='RACNODELST';
     dicMETRICLSTV$ varchar2(32):='METRICLSTV$';
     dicMETRICLSTAWR varchar2(32):='METRICLSTAWR';
   begin
     select count(1) into l_cnt from cube_dic where dic_type=dicRACNODES and src_db=p_db_link and created>(sysdate-to_number(awrtools_api.getconf('CUBEDIC_EXPIRE_TIME_RACNDS')));
     if l_cnt=0 then
       awrtools_logging.log('Reloading dictionary: '||dicRACNODES||':'||p_db_link);
       delete from cube_dic where src_db=p_db_link and dic_type=dicRACNODES;
       execute immediate
q'[insert into cube_dic (src_db, dic_type, name, id)
select :p_db_link, :p_dic_type, instance_name||' (Node'||inst_id||')', inst_id from gv$instance@]'||p_db_link||q'[
union all
select :p_db_link, :p_dic_type, 'Cluster wide', -1 from dual]' using p_db_link, dicRACNODES, p_db_link, dicRACNODES;
     --dbms_output.put_line
     end if;

     if p_src_tab='V$VIEW' then
       select count(1) into l_cnt from cube_dic where dic_type=dicMETRICLSTV$ and src_db=p_db_link and created>(sysdate-to_number(awrtools_api.getconf('CUBEDIC_EXPIRE_TIME_MTRC')));
       if l_cnt=0 then
         awrtools_logging.log('Reloading dictionary: '||dicMETRICLSTV$||':'||p_db_link);
         delete from cube_dic where src_db=p_db_link and dic_type=dicMETRICLSTV$;
         execute immediate
q'[insert into cube_dic (src_db, dic_type, name, id, id1)
select :p_db_link, :metrnm, metric_name||' ('||metric_unit||')' name, metric_id id, group_id from V$METRICNAME
where metric_id in (select unique metric_id from gv$sysmetric_history@]'||p_db_link||q'[)
]' using  p_db_link, dicMETRICLSTV$;
       end if;
     end if;

     if p_src_tab='AWR' then
       select count(1) into l_cnt from cube_dic where dic_type=dicMETRICLSTAWR and src_db=p_db_link and created>(sysdate-to_number(awrtools_api.getconf('CUBEDIC_EXPIRE_TIME_MTRC')));
       if l_cnt=0 then
         awrtools_logging.log('Reloading dictionary: '||dicMETRICLSTAWR||':'||p_db_link);
         delete from cube_dic where src_db=p_db_link and dic_type=dicMETRICLSTAWR;
         execute immediate
q'[insert into cube_dic (src_db, dic_type, name, id, id1)
select :p_db_link, :metrnm, metric_name||' ('||metric_unit||')' name,metric_id id, group_id from DBA_HIST_METRIC_NAME
where dbid = (select dbid from v$database)
and metric_id in (select unique metric_id from dba_hist_sysmetric_history@]'||p_db_link||q'[ where dbid = (select dbid from v$database@]'||p_db_link||q'[))
]' using  p_db_link, dicMETRICLSTAWR;
       end if;
     end if;
     commit;
   end;

END AWRTOOLS_CUBE_ASH;
/