create or replace PACKAGE AWRTOOLS_CUBE_ASH AS

  procedure load_cube_ash(p_sess_id out number,
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
                               p_block_analyze boolean default false);

  procedure CLEANUP_CUBE_ASH;

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

  procedure load_cube_ash(p_sess_id out number,
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
                               p_block_analyze boolean default false)
  is
    l_dbid     number;
    l_min_snap number;
    l_max_snap number;
    l_int_size number;
    l_inst_id  number;
    l_inst_list varchar2(32765);

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
   select   :P_SESS_ID, metric_id, <GROUPBY_COL>, <AGGFNC>(value)
     from   <SOURCE_TABLE>
    where   <DBID>
      AND   <INSTANCE_NUMBER> in (<P_INST_ID>)
      AND   <SNAP_FILTER>
      AND   end_time BETWEEN :P_START_DT AND :P_END_DT
      and   metric_id = :P_METRIC_ID
      and   group_id=:p_metricgroup_id
    group by <GROUPBY_COL>, metric_id]';

    l_sql_block_template varchar2(32765):=
   q'[insert into CUBE_BLOCK_ASH
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

    l_sql varchar2(32765);
    l_crsr sys_refcursor;
  begin
    awrtools_logging.log('Start load_data_cube','DEBUG');

    insert into cube_ash_sess values (default, default) returning sess_id into p_sess_id;

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
             and instance_number in (<P_INST_ID>)','<P_INST_ID>',l_inst_list) into l_min_snap using p_start_dt, l_dbid;
        execute immediate replace('select min(snap_id)
            from dba_hist_snapshot@'||p_dblink||'
           where end_interval_time>=:P_END_DT
             and dbid=:P_DBID
             and instance_number in (<P_INST_ID>)','<P_INST_ID>',l_inst_list) into l_max_snap using p_end_dt, l_dbid;
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
    end if;

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
        l_sql := replace(l_sql,'<GROUPBY_COL>','sample_time');
      when p_agg = 'by_mi'   then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(sample_time,'mi')]');
      when p_agg = 'by_hour' then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(sample_time,'hh')]');
      when p_agg = 'by_day'  then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(sample_time,'dd')]');
      else
        null;
    end case;

    awrtools_logging.log(l_sql,'DEBUG');
    awrtools_logging.log('p_sess_id:'||p_sess_id,'DEBUG');
    awrtools_logging.log('l_dbid:'||l_dbid,'DEBUG');
    awrtools_logging.log('p_inst_id:'||p_inst_id,'DEBUG');
    awrtools_logging.log('l_inst_list:'||l_inst_list,'DEBUG');
    awrtools_logging.log('l_min_snap:'||l_min_snap,'DEBUG');
    awrtools_logging.log('l_max_snap:'||l_max_snap,'DEBUG');
    awrtools_logging.log('p_start_dt:'||p_start_dt,'DEBUG');
    awrtools_logging.log('p_end_dt:'||p_end_dt,'DEBUG');

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
      open l_crsr for l_sql using p_sess_id, l_dbid, /*p_inst_id,*/ l_min_snap, l_max_snap, p_start_dt, p_end_dt;
      fetch l_crsr bulk collect into la_sess_id, la_sample_time, la_wait_class, la_sql_id, la_event, la_event_id, 
                          la_module, la_action, la_sql_id1,la_sql_plan_hash_value, 
                          la_segment_id, la_smpls , la_g1, la_g2, la_g3, la_g4, la_g5, la_g6;
      close l_crsr;
      awrtools_logging.log('Start saving cube','DEBUG');
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
        awrtools_logging.log('Error SQL: '||chr(10)||l_sql);
        raise_application_error(-20000,sqlerrm);
    end;

    awrtools_logging.log('Start loading seg ids','DEBUG');
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
          awrtools_logging.log('Error SQL: '||chr(10)||l_sql);
          raise_application_error(-20000,sqlerrm);
      end;
    end if;
    awrtools_logging.log('End loading cube','DEBUG');

    --commit;
    --dbms_stats.gather_table_stats(ownname=> sys_context('USERENV','CURRENT_USER'), tabname=>'remote_ash', cascade=>true);

    if p_agg = 'no_agg' then
      insert /* append */ into cube_ash_timeline select unique p_sess_id, sample_time from cube_ash where sess_id = p_sess_id and g1=0;
    else
      if p_agg = 'by_mi' then
        insert /* append */ into cube_ash_timeline
          select p_sess_id,
                 trunc(p_start_dt,'mi')+(level-1)/24/60 from dual connect by level <=round((p_end_dt-trunc(p_start_dt,'mi'))*24*60)+1;
      end if;
      if p_agg = 'by_hour' then
        insert /* append */ into cube_ash_timeline
          select p_sess_id,
                 trunc(p_start_dt,'hh')+(level-1)/24 from dual connect by level <=round((p_end_dt-trunc(p_start_dt,'hh'))*24)+1;
      end if;
      if p_agg = 'by_day' then
        insert /* append */ into cube_ash_timeline
          select p_sess_id,
                 trunc(p_start_dt)+(level-1) from dual connect by level <=round(p_end_dt-trunc(p_start_dt))+1;
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
                            '<AGGFNC>',p_aggr_func),'<P_INST_ID>',l_inst_list);
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

    awrtools_logging.log(l_sql,'DEBUG');
    awrtools_logging.log('p_sess_id:'||p_sess_id,'DEBUG');
    awrtools_logging.log('l_dbid:'||l_dbid,'DEBUG');
    awrtools_logging.log('p_inst_id:'||p_inst_id,'DEBUG');
    awrtools_logging.log('l_min_snap:'||l_min_snap,'DEBUG');
    awrtools_logging.log('l_max_snap:'||l_max_snap,'DEBUG');
    awrtools_logging.log('p_start_dt:'||p_start_dt,'DEBUG');
    awrtools_logging.log('p_end_dt:'||p_end_dt,'DEBUG');
    awrtools_logging.log('p_metric_id:'||p_metric_id,'DEBUG');
    awrtools_logging.log('p_aggr_func:'||p_aggr_func,'DEBUG');

      begin
        awrtools_logging.log('Start metrics loading','DEBUG');
        awrtools_logging.log(l_sql,'DEBUG');
        execute immediate l_sql using p_sess_id, l_dbid, /*p_inst_id,*/ l_min_snap, l_max_snap, p_start_dt, p_end_dt, p_metric_id, p_metricgroup_id;
        awrtools_logging.log('End metrics loading','DEBUG');
      exception
        when others then
          awrtools_logging.log('Error SQL: '||chr(10)||l_sql);
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
        execute immediate l_sql using p_sess_id, l_dbid, /*p_inst_id,*/ l_min_snap, l_max_snap, p_start_dt, p_end_dt;
        awrtools_logging.log('End block loading','DEBUG');
      exception
        when others then
          awrtools_logging.log('Error SQL: '||chr(10)||l_sql);
          raise_application_error(-20000,sqlerrm);
      end;
    end if;
    commit;
    awrtools_logging.log('End load_data_cube','DEBUG');
    --dbms_stats.gather_table_stats(ownname=> sys_context('USERENV','CURRENT_USER'), tabname=>'remote_ash_timeline', cascade=>true);
  end;

END AWRTOOLS_CUBE_ASH;
/