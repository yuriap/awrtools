CREATE OR REPLACE PACKAGE AWRTOOLS_REMOTE_ANALYTICS AS 

  procedure load_data_cube(p_sess_id out number, p_source varchar2, p_dblink varchar2, p_agg varchar2, p_inst_id number, p_start_dt date, p_end_dt date, p_filter varchar2, p_dump_id number default null);
  procedure AWRTOOL_CLEANUP_ASHSESS;
  
END AWRTOOLS_REMOTE_ANALYTICS;
/
CREATE OR REPLACE PACKAGE BODY AWRTOOLS_REMOTE_ANALYTICS AS 

  procedure AWRTOOL_CLEANUP_ASHSESS
  is
  begin
    delete from remote_ash_sess where sess_created < (systimestamp - 1/24);
    dbms_output.put_line('Deleted '||sql%rowcount||' session(s).');
    commit;
  end;

  procedure load_data_cube(p_sess_id out number, p_source varchar2, p_dblink varchar2, p_agg varchar2, p_inst_id number, p_start_dt date, p_end_dt date, p_filter varchar2, p_dump_id number default null)
  is
    l_dbid number;
    l_min_snap number;
    l_max_snap number;
    
    l_sql_template varchar2(32765):=
q'[INSERT INTO REMOTE_ASH 
   SELECT   :P_SESS_ID, <GROUPBY_COL>, NVL(WAIT_CLASS,'CPU'),SQL_ID,EVENT,MODULE,ACTION,SQL_PLAN_HASH_VALUE, COUNT(1)
     FROM   <SOURCE_TABLE>
    WHERE   <DBID>
      AND   <INSTANCE_NUMBER> = :P_INST_ID         
      AND   <SNAP_FILTER>
      AND   SAMPLE_TIME BETWEEN :P_START_DT AND :P_END_DT
      AND   <FILTER>
    GROUP BY  <GROUPBY_COL>, NVL(WAIT_CLASS,'CPU'), SQL_ID, EVENT, MODULE, ACTION, SQL_PLAN_HASH_VALUE]';
    l_sql varchar2(32765);
  begin
    insert into remote_ash_sess values (default, default) returning sess_id into p_sess_id;
    
    if p_dblink <> '$LOCAL$' then
      if p_source = 'AWR' then
        execute immediate 'select dbid from v$database@'||p_dblink into l_dbid;
        execute immediate 'select min(snap_id) 
            from dba_hist_snapshot@'||p_dblink||'
           where end_interval_time>=:P_START_DT
             and dbid=:P_DBID
             and instance_number=:P_INST_ID' into l_min_snap using p_start_dt, l_dbid, p_inst_id;  
        execute immediate 'select min(snap_id) 
            from dba_hist_snapshot@'||p_dblink||'
           where end_interval_time>=:P_END_DT
             and dbid=:P_DBID
             and instance_number=:P_INST_ID' into l_max_snap using p_end_dt, l_dbid, p_inst_id; 
        if l_max_snap is null then
          execute immediate 'select max(snap_id) 
              from dba_hist_snapshot@'||p_dblink||'
             where dbid=:P_DBID
               and instance_number=:P_INST_ID' into l_max_snap using l_dbid, p_inst_id;         
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
    
    l_sql := replace(replace(replace(replace(replace(l_sql_template,
                                                          '<SOURCE_TABLE>',case 
                                                                             when p_source = 'V$ASH' then case when p_dblink = '$LOCAL$' then 'gv$active_session_history'
                                                                                                          else 'gv$active_session_history@'||p_dblink
                                                                                                          end
                                                                             when p_source = 'AWR' then case when p_dblink = '$LOCAL$' then 'dba_hist_active_sess_history' 
                                                                                                        else 'dba_hist_active_sess_history@'||p_dblink
                                                                                                        end
                                                                           end),
                                                  '<DBID>',case when p_source = 'V$ASH' then ':P_DBID is null' else 'DBID = :P_DBID' end),
                                          '<INSTANCE_NUMBER>',case when p_source = 'V$ASH' then 'INST_ID' else 'INSTANCE_NUMBER' end),
                                  '<SNAP_FILTER>',case when p_source = 'AWR' then 'SNAP_ID BETWEEN :P_MIN_SNAP AND :P_MAX_SNAP' else ':P_MIN_SNAP is null and :P_MAX_SNAP is null' end),
                          '<FILTER>',nvl(p_filter,'1=1')); 
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
/*    
    awrtools_logging.log(l_sql);
    awrtools_logging.log('p_sess_id:'||p_sess_id);
    awrtools_logging.log('l_dbid:'||l_dbid);
    awrtools_logging.log('p_inst_id:'||p_inst_id);
    awrtools_logging.log('l_min_snap:'||l_min_snap);
    awrtools_logging.log('l_max_snap:'||l_max_snap);
    awrtools_logging.log('p_start_dt:'||p_start_dt);
    awrtools_logging.log('p_end_dt:'||p_end_dt);
*/    
    begin    
      execute immediate l_sql using p_sess_id, l_dbid, p_inst_id, l_min_snap, l_max_snap, p_start_dt, p_end_dt;
    exception
      when others then      
        raise_application_error(-20000,sqlerrm);
    end;
    --commit;
    --dbms_stats.gather_table_stats(ownname=> sys_context('USERENV','CURRENT_USER'), tabname=>'remote_ash', cascade=>true);
    insert /*+ append */ into remote_ash_timeline select unique p_sess_id, sample_time from remote_ash where sess_id = p_sess_id;
    commit;
    --dbms_stats.gather_table_stats(ownname=> sys_context('USERENV','CURRENT_USER'), tabname=>'remote_ash_timeline', cascade=>true);
  end;

END AWRTOOLS_REMOTE_ANALYTICS;
/