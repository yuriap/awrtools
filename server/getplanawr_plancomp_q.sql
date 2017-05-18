declare
  type t_my_rec is record(
    dbid            number,
    sql_id          varchar2(30),
    plan_hash_value number,
    capture         varchar2(200),
    src                varchar2(1));
  type t_my_tab_rec is table of t_my_rec index by pls_integer;
  my_rec t_my_tab_rec;
  type my_arrayofstrings is table of varchar2(1000);
  p1       my_arrayofstrings;
  p2       my_arrayofstrings;
  i        number;
  max_l    number := 0;
  r1       varchar2(1000);
  r2       varchar2(1000);
  l_sql_id varchar2(30) := '&SQLID.';
  
  l_db1_title_s varchar2(200);
  l_db2_title_s varchar2(200);

  l_db1_title_l varchar2(200);
  l_db2_title_l varchar2(200);

  l_db1_title_f varchar2(200);
  l_db2_title_f varchar2(200);
  l_sql_txt varchar2(4000);

  
  cursor stats1 (p_sql_id varchar2,p_plan_hash number) is 
  select 
    s.sql_id
  , s.plan_hash_value
  , s.dbid
  , sum(s.EXECUTIONS_DELTA) EXECUTIONS_DELTA
  , (round(sum(s.ELAPSED_TIME_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as ela_poe
  , (round(sum(s.BUFFER_GETS_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA)),3)) as LIO_poe
  , (round(sum(s.CPU_TIME_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as CPU_poe
  , (round(sum(s.IOWAIT_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as IOWAIT_poe
  , (round(sum(s.ccwait_delta)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as CCWAIT_poe
  , (round(sum(s.APWAIT_delta)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as APWAIT_poe
  , (round(sum(s.CLWAIT_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as CLWAIT_poe
  , (round(sum(s.DISK_READS_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA)),3)) as reads_poe
  , (round(sum(s.DIRECT_WRITES_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA)),3)) as dwrites_poe
  , (round(sum(s.ROWS_PROCESSED_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA)),3)) as Rows_poe
  , ROUND(sum(ELAPSED_TIME_DELTA)/1000000,3) ELA_DELTA_SEC
  , ROUND(sum(CPU_TIME_DELTA)/1000000,3) CPU_DELTA_SEC
  , ROUND(sum(IOWAIT_DELTA)/1000000,3) IOWAIT_DELTA_SEC
  , ROUND(sum(ccwait_delta)/1000000,3) ccwait_delta_SEC
  , ROUND(sum(APWAIT_delta)/1000000,3) APWAIT_delta_SEC
  , ROUND(sum(CLWAIT_DELTA)/1000000,3) CLWAIT_DELTA_SEC
  ,sum(DISK_READS_DELTA)DISK_READS_DELTA
  ,sum(DIRECT_WRITES_DELTA)DISK_WRITES_DELTA
  ,sum(BUFFER_GETS_DELTA)BUFFER_GETS_DELTA
  ,sum(ROWS_PROCESSED_DELTA)ROWS_PROCESSED_DELTA
  ,sum(PHYSICAL_READ_REQUESTS_DELTA)PHY_READ_REQ_DELTA
  ,sum(PHYSICAL_WRITE_REQUESTS_DELTA)PHY_WRITE_REQ_DELTA
  ,round(sum(BUFFER_GETS_DELTA)/decode(sum(ROWS_PROCESSED_DELTA),0,null,sum(ROWS_PROCESSED_DELTA)),3) LIO_PER_ROW
  ,round(sum(DISK_READS_DELTA)/decode(sum(ROWS_PROCESSED_DELTA),0,null,sum(ROWS_PROCESSED_DELTA)),3) IO_PER_ROW
  ,round(sum(s.IOWAIT_DELTA)/decode(sum(s.PHYSICAL_READ_REQUESTS_DELTA)+sum(s.PHYSICAL_WRITE_REQUESTS_DELTA), null, 1,0,1, sum(s.PHYSICAL_READ_REQUESTS_DELTA)+sum(s.PHYSICAL_WRITE_REQUESTS_DELTA))/1000,3) as awg_IO_tim
  ,(sum(s.PHYSICAL_READ_REQUESTS_DELTA)+sum(s.PHYSICAL_WRITE_REQUESTS_DELTA))*0.005 as io_wait_5ms
  ,round((sum(s.PHYSICAL_READ_REQUESTS_DELTA)+sum(s.PHYSICAL_WRITE_REQUESTS_DELTA))/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))*5) io_wait_pe_5ms
from dba_hist_sqlstat s
where
    s.sql_id = p_sql_id
and s.instance_number = 1
and s.dbid=&dbid1.
and s.snap_id in (&snaps1.)
and s.plan_hash_value=p_plan_hash
group by s.dbid,s.plan_hash_value,s.sql_id
;

  cursor stats2 (p_sql_id varchar2,p_plan_hash number) is 
  select 
    s.sql_id
  , s.plan_hash_value
  , s.dbid
  , sum(s.EXECUTIONS_DELTA) EXECUTIONS_DELTA
  , (round(sum(s.ELAPSED_TIME_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as ela_poe
  , (round(sum(s.BUFFER_GETS_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA)),3)) as LIO_poe
  , (round(sum(s.CPU_TIME_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as CPU_poe
  , (round(sum(s.IOWAIT_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as IOWAIT_poe
  , (round(sum(s.ccwait_delta)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as CCWAIT_poe
  , (round(sum(s.APWAIT_delta)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as APWAIT_poe
  , (round(sum(s.CLWAIT_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))/1000,3)) as CLWAIT_poe
  , (round(sum(s.DISK_READS_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA)),3)) as reads_poe
  , (round(sum(s.DIRECT_WRITES_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA)),3)) as dwrites_poe
  , (round(sum(s.ROWS_PROCESSED_DELTA)/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA)),3)) as Rows_poe
  , ROUND(sum(ELAPSED_TIME_DELTA)/1000000,3) ELA_DELTA_SEC
  , ROUND(sum(CPU_TIME_DELTA)/1000000,3) CPU_DELTA_SEC
  , ROUND(sum(IOWAIT_DELTA)/1000000,3) IOWAIT_DELTA_SEC
  , ROUND(sum(ccwait_delta)/1000000,3) ccwait_delta_SEC
  , ROUND(sum(APWAIT_delta)/1000000,3) APWAIT_delta_SEC
  , ROUND(sum(CLWAIT_DELTA)/1000000,3) CLWAIT_DELTA_SEC
  ,sum(DISK_READS_DELTA)DISK_READS_DELTA
  ,sum(DIRECT_WRITES_DELTA)DISK_WRITES_DELTA
  ,sum(BUFFER_GETS_DELTA)BUFFER_GETS_DELTA
  ,sum(ROWS_PROCESSED_DELTA)ROWS_PROCESSED_DELTA
  ,sum(PHYSICAL_READ_REQUESTS_DELTA)PHY_READ_REQ_DELTA
  ,sum(PHYSICAL_WRITE_REQUESTS_DELTA)PHY_WRITE_REQ_DELTA
  ,round(sum(BUFFER_GETS_DELTA)/decode(sum(ROWS_PROCESSED_DELTA),0,null,sum(ROWS_PROCESSED_DELTA)),3) LIO_PER_ROW
  ,round(sum(DISK_READS_DELTA)/decode(sum(ROWS_PROCESSED_DELTA),0,null,sum(ROWS_PROCESSED_DELTA)),3) IO_PER_ROW
  ,round(sum(s.IOWAIT_DELTA)/decode(sum(s.PHYSICAL_READ_REQUESTS_DELTA)+sum(s.PHYSICAL_WRITE_REQUESTS_DELTA), null, 1,0,1, sum(s.PHYSICAL_READ_REQUESTS_DELTA)+sum(s.PHYSICAL_WRITE_REQUESTS_DELTA))/1000,3) as awg_IO_tim
  ,(sum(s.PHYSICAL_READ_REQUESTS_DELTA)+sum(s.PHYSICAL_WRITE_REQUESTS_DELTA))*0.005 as io_wait_5ms
  ,round((sum(s.PHYSICAL_READ_REQUESTS_DELTA)+sum(s.PHYSICAL_WRITE_REQUESTS_DELTA))/decode(sum(s.EXECUTIONS_DELTA), null, 1,0,1, sum(s.EXECUTIONS_DELTA))*5) io_wait_pe_5ms
from dba_hist_sqlstat&dblnk. s
where
    s.sql_id = p_sql_id
and s.instance_number = 1
and s.dbid=&dbid2.
and s.snap_id in (&snaps2.)
and s.plan_hash_value=p_plan_hash
group by s.dbid,s.plan_hash_value,s.sql_id
;
r_stats1 stats1%rowtype;
r_stats2 stats2%rowtype;
l_stat_ln number := 40;
l_single_plan boolean;

procedure get_plan(p_sql_id varchar2, p_plan_hash varchar2, p_dbid number, p_src varchar2, p_data in out my_arrayofstrings)
is
begin
  if p_src='L' then 
    select replace(replace(plan_table_output,chr(13)),chr(10)) bulk collect
      into p_data
      from table(dbms_xplan.display_awr(p_sql_id, p_plan_hash, p_dbid, 'ADVANCED -ALIAS', con_id => 0));
  end if;
  if p_src='R' then  
$IF '&dblnk.' is not null $THEN
    remote_awr_xplan_init&dblnk.(p_sql_id, p_plan_hash, p_dbid);
    select replace(replace(plan_table_output,chr(13)),chr(10)) bulk collect
      into p_data
      from remote_awr_plan&dblnk.;    
$ELSE
    select replace(replace(plan_table_output,chr(13)),chr(10)) bulk collect
      into p_data
      from table(dbms_xplan.display_awr(p_sql_id, p_plan_hash, p_dbid, 'ADVANCED -ALIAS', con_id => 0));
$END
  end if;
end;

procedure get_sql_stat(p_sql_id varchar2, p_plan_hash varchar2, p_src varchar2, p_data in out stats1%rowtype)
is
begin
  if p_src='L' then
    open stats1(p_sql_id,p_plan_hash);
    fetch stats1 into p_data;
    close stats1;
  elsif p_src='R' then
    open stats2(p_sql_id,p_plan_hash);
    fetch stats2 into p_data;
    close stats2;  
  end if;
end;

procedure p(p_msg varchar2) is begin dbms_output.put_line(p_msg);end;
procedure pr(length1 number, length2 number, par1 varchar2, par2 varchar2, par3 varchar2 default null, delim1 varchar2 default ' ',delim2 varchar2 default ' ') 
is begin p(rpad(par1, length1, ' ') || delim1 ||rpad(par2, length2, ' ')|| delim2 ||rpad(par3, length1, ' '));end;
begin
  p(rpad('=',200,'='));
  p('SQL_ID: '||l_sql_id);
  p(rpad('-',21,'-'));
  
  -- get DB titles
$IF '&dblnk.' is not null $THEN  
  select unique 'DB1:         '||sn.DBID, 
  'DB1:         '||sn.DBID||', '||version || ', ' || host_name || ', ' || platform_name || 
  ', Started: ' || to_char(i.STARTUP_TIME,'YYYY/MM/DD HH24:mi:ss') ||
  ', BEGIN: ' || to_char(min(sn.BEGIN_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi:ss') ||
  ', END: ' || to_char(max(sn.END_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi:ss'),
  'DB1: '||sn.DBID||', '||version || ', ' || host_name || --', ' || platform_name || 
  ', B:' || to_char(min(sn.BEGIN_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi') ||
  ', E:' || to_char(max(sn.END_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi')
  into l_db1_title_s,l_db1_title_f,l_db1_title_l
$ELSE                
  select unique 'DB1:'||sn.DBID, 
  'DB1:'||sn.DBID||', '||version || ', ' || host_name || ', ' || platform_name || 
  ', Started: ' || to_char(i.STARTUP_TIME,'YYYY/MM/DD HH24:mi:ss')  ||
  ', BEGIN: ' || to_char(min(sn.BEGIN_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi:ss') ||
  ', END: ' || to_char(max(sn.END_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi:ss'),
  'DB1: '||sn.DBID||', '||version || ', ' || host_name || --', ' || platform_name || 
  ', B:' || to_char(min(sn.BEGIN_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi') ||
  ', E:' || to_char(max(sn.END_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi')
  into l_db1_title_s,l_db1_title_f,l_db1_title_l
$END 
    from dba_hist_database_instance i, 
         dba_hist_snapshot sn 
   where i.dbid = sn.dbid 
     and i.startup_time=sn.startup_time
     and sn.dbid = &dbid1.
     and sn.snap_id in (&snaps1.);

$IF '&dblnk.' is not null $THEN
  select unique 'DB2(remote): '||sn.DBID,
  'DB2(remote): '||sn.DBID||', '||version || ', ' || host_name || ', ' || platform_name || 
  ', Started: ' || to_char(i.STARTUP_TIME,'YYYY/MM/DD HH24:mi:ss')  ||
  ', BEGIN: ' || to_char(min(sn.BEGIN_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi:ss') ||
  ', END: ' || to_char(max(sn.END_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi:ss'),
  'DB2(remote): '||sn.DBID||', '||version || ', ' || host_name || --', ' || platform_name || 
  ', B:' || to_char(min(sn.BEGIN_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi') ||
  ', E:' || to_char(max(sn.END_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi')
  into l_db2_title_s,l_db2_title_f, l_db2_title_l
$ELSE
  select unique 'DB2:'||sn.DBID,
  'DB2:'||sn.DBID||', '||version || ', ' || host_name || ', ' || platform_name || 
  ', Started: ' || to_char(i.STARTUP_TIME,'YYYY/MM/DD HH24:mi:ss')  ||
  ', BEGIN: ' || to_char(min(sn.BEGIN_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi:ss') ||
  ', END: ' || to_char(max(sn.END_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi:ss'),
  'DB2: '||sn.DBID||', '||version || ', ' || host_name || --', ' || platform_name || 
  ', B:' || to_char(min(sn.BEGIN_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi') ||
  ', E:' || to_char(max(sn.END_INTERVAL_TIME) over (),'YYYY/MM/DD HH24:mi')
  into l_db2_title_s,l_db2_title_f, l_db2_title_l
$END  
    from dba_hist_database_instance&dblnk. i, 
         dba_hist_snapshot&dblnk. sn 
   where i.dbid = sn.dbid 
     and i.startup_time=sn.startup_time
     and sn.dbid = &dbid2.
     and sn.snap_id in (&snaps2.);

  p(l_db1_title_f);
  p(l_db2_title_f);
  p(rpad('-',21,'-'));

  p('Query sources from dba_hist_sqlstat:');
  p('DBID, PLAN HASH, PARSING_USER_ID, PARSING SCHEMA, MODULE, ACTION');
  p('----------------------------------------------------------------');
  for i in (select unique dbid,plan_hash_value,PARSING_USER_ID,module,action,
     --'DBID: '||dbid
     case 
       when dbid=&dbid1. and instr('&snaps1.',snap_id)>0 and src='L' then l_db1_title_s
       when dbid=&dbid2. and instr('&snaps2.',snap_id)>0 and src='R' then l_db2_title_s
       else 'DB: N/A '||dbid||','||snap_id||' "&dbid1." "&snaps1." "&dbid2." "&snaps2."' end
     ||'; '||plan_hash_value||'; '||PARSING_USER_ID||'; '||parsing_schema_name||'; '||module||'; '||action a 
     from 
       (
        select 'L' src, x.* from dba_hist_sqlstat x 
         where sql_id=l_sql_id --and plan_hash_value <> 0 
           and (dbid='&dbid1.' and instr('&snaps1.',snap_id)>0)
        union all
        select 'R' src, x.* from dba_hist_sqlstat&dblnk. x
         where sql_id=l_sql_id --and plan_hash_value <> 0 
           and (dbid='&dbid2.' and instr('&snaps2.',snap_id)>0)
       )
     order by 6,dbid,plan_hash_value,PARSING_USER_ID,module,action
    )
  loop
    p(i.a);
  end loop;
  p('----------------------------------------------------------------');
  p('Query sources from dba_hist_active_sess_history (no more than 5 rows from each DB):');
  p('DBID, PLAN HASH, USER_ID, PROGRAM, MODULE, ACTION, CLIENT_ID');
  p('----------------------------------------------------------------');  
  for i in (select unique dbid,sql_plan_hash_value,user_id,module,action,
     --'DBID: '||dbid
     case 
       when dbid=&dbid1. and instr('&snaps1.',snap_id)>0 and src='L' then l_db1_title_s
       when dbid=&dbid2. and instr('&snaps2.',snap_id)>0 and src='R' then l_db2_title_s
       else 'DB: N/A '||dbid||','||snap_id||' "&dbid1." "&snaps1." "&dbid2." "&snaps2."' end
          ||'; '||sql_plan_hash_value||'; '||user_id||'; '||program||'; '||module||'; '||action||'; '||client_id a,plsql_entry_object_id,plsql_entry_subprogram_id 
    from 
      (
       select 'L' src, x.* from dba_hist_active_sess_history x
        where (sql_id=l_sql_id or TOP_LEVEL_SQL_ID=l_sql_id)--and sql_plan_hash_value <> 0 
          and (dbid='&dbid1.' and instr('&snaps1.',snap_id)>0)
          and rownum<6
       union all
       select 'R' src, x.* from dba_hist_active_sess_history&dblnk. x
        where (sql_id=l_sql_id or TOP_LEVEL_SQL_ID=l_sql_id) --and sql_plan_hash_value <> 0 
          and (dbid='&dbid2.' and instr('&snaps2.',snap_id)>0)
          and rownum<6
      )
    order by 6,dbid,sql_plan_hash_value,user_id,module,action)
  loop
    p(i.a);
    for j in (select 'Called from PL/SQL: '||owner||'; '||object_type||'; '||object_name a from dba_procedures where object_id=i.plsql_entry_object_id and subprogram_id=i.plsql_entry_subprogram_id ) loop
      p(j.a);
    end loop;
  end loop;

  for k in (select rownum rn, y.* from (select x.*
              from (select unique s.dbid,
         sql_id,
         plan_hash_value,
         case 
           when s.dbid=&dbid1. and instr('&snaps1.',s.snap_id)>0 and src='L' then l_db1_title_l
           when s.dbid=&dbid2. and instr('&snaps2.',s.snap_id)>0 and src='R' then l_db2_title_l
           else 'DB: N/A '||dbid||','||snap_id||' "&dbid1." "&snaps1." "&dbid2." "&snaps2."' end
         ||'; PH:'||plan_hash_value capture, src
    from 
      (
       select 'L' src, s.* from dba_hist_sqlstat s
        where sql_id = l_sql_id
          and s.dbid in (select dbid from dba_hist_sqltext where sql_id = l_sql_id)
          and (dbid='&dbid1.' and instr('&snaps1.',snap_id)>0)
          --and plan_hash_value <> 0
       union all
       select 'R' src, s.* from dba_hist_sqlstat&dblnk. s
        where sql_id = l_sql_id
          and s.dbid in (select dbid from dba_hist_sqltext where sql_id = l_sql_id)
          and (dbid='&dbid2.' and instr('&snaps2.',snap_id)>0)
          --and plan_hash_value <> 0
      ) s
                    )
            x order by case when src='L' then 0 else 1 end, capture) y ) loop
    my_rec(k.rn).sql_id := k.sql_id;
    my_rec(k.rn).plan_hash_value := k.plan_hash_value;
    my_rec(k.rn).capture := k.capture;
    my_rec(k.rn).src := k.src;
  end loop;
  
  for a in 1 .. my_rec.count loop
    for b in (case when my_rec.count=1 then 1 else a + 1 end) .. my_rec.count loop
      --load plans
      get_plan(my_rec(a).sql_id, my_rec(a).plan_hash_value, &dbid1.,my_rec(a).src,p1);
      get_sql_stat(my_rec(a).sql_id,my_rec(a).plan_hash_value,my_rec(a).src,r_stats1);

      l_single_plan := false;
      
      if a<>b then
        
        l_single_plan := my_rec(a).plan_hash_value=my_rec(b).plan_hash_value and &dbid1.=&dbid2. and my_rec(a).plan_hash_value<>0;
        
        get_plan(my_rec(b).sql_id, my_rec(b).plan_hash_value, &dbid1.,my_rec(b).src,p2);
        get_sql_stat(my_rec(b).sql_id,my_rec(b).plan_hash_value,my_rec(b).src,r_stats2);

        i := greatest(p1.count, p2.count);
        for j in 1 .. p1.count loop
          if length(p1(j)) > max_l then
            max_l := length(p1(j));
          end if;
        end loop;
        for j in 1 .. p2.count loop
          if length(p2(j)) > max_l then
            max_l := length(p2(j));
          end if;
        end loop;             
      else
        i := p1.count;
        
        for j in 1 .. p1.count loop
          if length(p1(j)) > max_l then
            max_l := length(p1(j));
          end if;
        end loop;        
      end if;      
 
      if max_l < 120 then max_l:= 120; end if;
      
      max_l:=max_l+1;
      if max_l<10 then max_l:=100; end if;
      --print
      --header
      p(rpad('=',max_l*2+1,'='));
      
      if a<>b then
        pr(max_l,max_l,my_rec(a).capture,my_rec(b).capture);
      else
        pr(max_l,max_l,my_rec(a).capture,null);
      end if;
      
      p(rpad('-',max_l*2+1,'-'));
      --stats
      pr(max_l,l_stat_ln,'Metric             Value',                          'Metric             Value',    'Delta, %            Delta to ELA/EXEC, %','*');
      p(rpad('-',max_l*2+1,'-'));      
      pr(max_l,l_stat_ln,'EXECS:             '||r_stats1.EXECUTIONS_DELTA,    'EXECS:             '||r_stats2.EXECUTIONS_DELTA,    round(100*((r_stats2.EXECUTIONS_DELTA-r_stats1.EXECUTIONS_DELTA)        /(case when r_stats2.EXECUTIONS_DELTA=0 then case when r_stats1.EXECUTIONS_DELTA=0 then 1 else r_stats1.EXECUTIONS_DELTA end else r_stats2.EXECUTIONS_DELTA end)),2)||'%','*');
      pr(max_l,l_stat_ln,'ELA/EXEC(MS):      '||r_stats1.ela_poe,             'ELA/EXEC(MS):      '||r_stats2.ela_poe,             round(100*((r_stats2.ela_poe-r_stats1.ela_poe)                          /(case when r_stats2.ela_poe=0 then case when r_stats1.ela_poe=0 then 1 else r_stats1.ela_poe end else r_stats2.ela_poe end)),2)||'%','*');
      pr(max_l,l_stat_ln,'LIO/EXEC:          '||r_stats1.LIO_poe,             'LIO/EXEC:          '||r_stats2.LIO_poe,             round(100*((r_stats2.LIO_poe-r_stats1.LIO_poe)                          /(case when r_stats2.LIO_poe=0 then case when r_stats1.LIO_poe=0 then 1 else r_stats1.LIO_poe end else r_stats2.LIO_poe end)),2)||'%','*');
      pr(max_l,l_stat_ln,'CPU/EXEC(MS):      '||r_stats1.CPU_poe,             'CPU/EXEC(MS):      '||r_stats2.CPU_poe,             rpad(round(100*((r_stats2.CPU_poe-r_stats1.CPU_poe)                     /(case when r_stats2.CPU_poe=0 then case when r_stats1.CPU_poe=0 then 1 else r_stats1.CPU_poe end else r_stats2.CPU_poe end)),2)||'%',20,' ')||
         round(100*((r_stats2.CPU_poe-r_stats1.CPU_poe)                          /(case when r_stats2.ela_poe=0 then case when r_stats1.ela_poe=0 then 1 else r_stats1.ela_poe end else r_stats2.ela_poe end)),2)||'%','*');
      pr(max_l,l_stat_ln,'IOWAIT/EXEC(MS):   '||r_stats1.IOWAIT_poe,          'IOWAIT/EXEC(MS):   '||r_stats2.IOWAIT_poe,          rpad(round(100*((r_stats2.IOWAIT_poe-r_stats1.IOWAIT_poe)               /(case when r_stats2.IOWAIT_poe=0 then case when r_stats1.IOWAIT_poe=0 then 1 else r_stats1.IOWAIT_poe end else r_stats2.IOWAIT_poe end)),2)||'%',20,' ')||
         round(100*((r_stats2.IOWAIT_poe-r_stats1.IOWAIT_poe)                    /(case when r_stats2.ela_poe=0 then case when r_stats1.ela_poe=0 then 1 else r_stats1.ela_poe end else r_stats2.ela_poe end)),2)||'%','*');
      pr(max_l,l_stat_ln,'CCWAIT/EXEC(MS):   '||r_stats1.CCWAIT_poe,          'CCWAIT/EXEC(MS):   '||r_stats2.CCWAIT_poe,          rpad(round(100*((r_stats2.CCWAIT_poe-r_stats1.CCWAIT_poe)               /(case when r_stats2.CCWAIT_poe=0 then case when r_stats1.CCWAIT_poe=0 then 1 else r_stats1.CCWAIT_poe end else r_stats2.CCWAIT_poe end)),2)||'%',20,' ')||
         round(100*((r_stats2.CCWAIT_poe-r_stats1.CCWAIT_poe)                    /(case when r_stats2.ela_poe=0 then case when r_stats1.ela_poe=0 then 1 else r_stats1.ela_poe end else r_stats2.ela_poe end)),2)||'%','*');
      pr(max_l,l_stat_ln,'APWAIT/EXEC(MS):   '||r_stats1.APWAIT_poe,          'APWAIT/EXEC(MS):   '||r_stats2.APWAIT_poe,          rpad(round(100*((r_stats2.APWAIT_poe-r_stats1.APWAIT_poe)               /(case when r_stats2.APWAIT_poe=0 then case when r_stats1.APWAIT_poe=0 then 1 else r_stats1.APWAIT_poe end else r_stats2.APWAIT_poe end)),2)||'%',20,' ')||
         round(100*((r_stats2.APWAIT_poe-r_stats1.APWAIT_poe)                    /(case when r_stats2.ela_poe=0 then case when r_stats1.ela_poe=0 then 1 else r_stats1.ela_poe end else r_stats2.ela_poe end)),2)||'%','*');
      pr(max_l,l_stat_ln,'CLWAIT/EXEC(MS):   '||r_stats1.CLWAIT_poe,          'CLWAIT/EXEC(MS):   '||r_stats2.CLWAIT_poe,          rpad(round(100*((r_stats2.CLWAIT_poe-r_stats1.CLWAIT_poe)               /(case when r_stats2.CLWAIT_poe=0 then case when r_stats1.CLWAIT_poe=0 then 1 else r_stats1.CLWAIT_poe end else r_stats2.CLWAIT_poe end)),2)||'%',20,' ')||
         round(100*((r_stats2.CLWAIT_poe-r_stats1.CLWAIT_poe)                    /(case when r_stats2.ela_poe=0 then case when r_stats1.ela_poe=0 then 1 else r_stats1.ela_poe end else r_stats2.ela_poe end)),2)||'%','*');
      
      pr(max_l,l_stat_ln,'READS/EXEC:        '||r_stats1.reads_poe,           'READS/EXEC:        '||r_stats2.reads_poe,           round(100*((r_stats2.reads_poe-r_stats1.reads_poe)                      /(case when r_stats2.reads_poe=0 then case when r_stats1.reads_poe=0 then 1 else r_stats1.reads_poe end else r_stats2.reads_poe end)),2)||'%','*');
      pr(max_l,l_stat_ln,'WRITES/EXEC:       '||r_stats1.dwrites_poe,         'WRITES/EXEC:       '||r_stats2.dwrites_poe,         round(100*((r_stats2.dwrites_poe-r_stats1.dwrites_poe)                  /(case when r_stats2.dwrites_poe=0 then case when r_stats1.dwrites_poe=0 then 1 else r_stats1.dwrites_poe end else r_stats2.dwrites_poe end)),2)||'%','*');      
      
      pr(max_l,l_stat_ln,'ROWS/EXEC:         '||r_stats1.Rows_poe,            'ROWS/EXEC:         '||r_stats2.Rows_poe,            round(100*((r_stats2.Rows_poe-r_stats1.Rows_poe)                        /(case when r_stats2.Rows_poe=0 then case when r_stats1.Rows_poe=0 then 1 else r_stats1.Rows_poe end else r_stats2.Rows_poe end)),2)||'%','*');
      pr(max_l,l_stat_ln,'ELA(SEC):          '||r_stats1.ELA_DELTA_SEC,       'ELA(SEC):          '||r_stats2.ELA_DELTA_SEC,       round(100*((r_stats2.ELA_DELTA_SEC-r_stats1.ELA_DELTA_SEC)              /(case when r_stats2.ELA_DELTA_SEC=0 then case when r_stats1.ELA_DELTA_SEC=0 then 1 else r_stats1.ELA_DELTA_SEC end else r_stats2.ELA_DELTA_SEC end)),2)||'%','*');
      pr(max_l,l_stat_ln,'CPU(SEC):          '||r_stats1.CPU_DELTA_SEC,       'CPU(SEC):          '||r_stats2.CPU_DELTA_SEC,       round(100*((r_stats2.CPU_DELTA_SEC-r_stats1.CPU_DELTA_SEC)              /(case when r_stats2.CPU_DELTA_SEC=0 then case when r_stats1.CPU_DELTA_SEC=0 then 1 else r_stats1.CPU_DELTA_SEC end else r_stats2.CPU_DELTA_SEC end)),2)||'%','*');

      pr(max_l,l_stat_ln,'IOWAIT(SEC):       '||r_stats1.IOWAIT_DELTA_SEC,    'IOWAIT(SEC):       '||r_stats2.IOWAIT_DELTA_SEC,    round(100*((r_stats2.IOWAIT_DELTA_SEC-r_stats1.IOWAIT_DELTA_SEC)        /(case when r_stats2.IOWAIT_DELTA_SEC=0 then case when r_stats1.IOWAIT_DELTA_SEC=0 then 1 else r_stats1.IOWAIT_DELTA_SEC end else r_stats2.IOWAIT_DELTA_SEC end)),2)||'%','*');
      pr(max_l,l_stat_ln,'CCWAIT(SEC):       '||r_stats1.CCWAIT_DELTA_SEC,    'CCWAIT(SEC):       '||r_stats2.CCWAIT_DELTA_SEC,    round(100*((r_stats2.CCWAIT_DELTA_SEC-r_stats1.CCWAIT_DELTA_SEC)        /(case when r_stats2.CCWAIT_DELTA_SEC=0 then case when r_stats1.CCWAIT_DELTA_SEC=0 then 1 else r_stats1.CCWAIT_DELTA_SEC end else r_stats2.CCWAIT_DELTA_SEC end)),2)||'%','*');
      pr(max_l,l_stat_ln,'APWAIT(SEC):       '||r_stats1.APWAIT_DELTA_SEC,    'APWAIT(SEC):       '||r_stats2.APWAIT_DELTA_SEC,    round(100*((r_stats2.APWAIT_DELTA_SEC-r_stats1.APWAIT_DELTA_SEC)        /(case when r_stats2.APWAIT_DELTA_SEC=0 then case when r_stats1.APWAIT_DELTA_SEC=0 then 1 else r_stats1.APWAIT_DELTA_SEC end else r_stats2.APWAIT_DELTA_SEC end)),2)||'%','*');
      pr(max_l,l_stat_ln,'CLWAIT(SEC):       '||r_stats1.CLWAIT_DELTA_SEC,    'CLWAIT(SEC):       '||r_stats2.CLWAIT_DELTA_SEC,    round(100*((r_stats2.CLWAIT_DELTA_SEC-r_stats1.CLWAIT_DELTA_SEC)        /(case when r_stats2.CLWAIT_DELTA_SEC=0 then case when r_stats1.CLWAIT_DELTA_SEC=0 then 1 else r_stats1.CLWAIT_DELTA_SEC end else r_stats2.CLWAIT_DELTA_SEC end)),2)||'%','*');
      
      pr(max_l,l_stat_ln,'READS:             '||r_stats1.DISK_READS_DELTA,    'READS:             '||r_stats2.DISK_READS_DELTA,    round(100*((r_stats2.DISK_READS_DELTA-r_stats1.DISK_READS_DELTA)        /(case when r_stats2.DISK_READS_DELTA=0 then case when r_stats1.DISK_READS_DELTA=0 then 1 else r_stats1.DISK_READS_DELTA end else r_stats2.DISK_READS_DELTA end)),2)||'%','*');
      pr(max_l,l_stat_ln,'DIR WRITES:        '||r_stats1.DISK_WRITES_DELTA,   'DIR WRITES:        '||r_stats2.DISK_WRITES_DELTA,   round(100*((r_stats2.DISK_WRITES_DELTA-r_stats1.DISK_WRITES_DELTA)      /(case when r_stats2.DISK_WRITES_DELTA=0 then case when r_stats1.DISK_WRITES_DELTA=0 then 1 else r_stats1.DISK_WRITES_DELTA end else r_stats2.DISK_WRITES_DELTA end)),2)||'%','*');      

      pr(max_l,l_stat_ln,'READ REQ:          '||r_stats1.PHY_READ_REQ_DELTA,  'READ REQ:          '||r_stats2.PHY_READ_REQ_DELTA,  round(100*((r_stats2.PHY_READ_REQ_DELTA-r_stats1.PHY_READ_REQ_DELTA)    /(case when r_stats2.PHY_READ_REQ_DELTA=0 then case when r_stats1.PHY_READ_REQ_DELTA=0 then 1 else r_stats1.PHY_READ_REQ_DELTA end else r_stats2.PHY_READ_REQ_DELTA end)),2)||'%','*');
      pr(max_l,l_stat_ln,'WRITE REQ:         '||r_stats1.PHY_WRITE_REQ_DELTA, 'WRITE REQ:         '||r_stats2.PHY_WRITE_REQ_DELTA, round(100*((r_stats2.PHY_WRITE_REQ_DELTA-r_stats1.PHY_WRITE_REQ_DELTA)  /(case when r_stats2.PHY_WRITE_REQ_DELTA=0 then case when r_stats1.PHY_WRITE_REQ_DELTA=0 then 1 else r_stats1.PHY_WRITE_REQ_DELTA end else r_stats2.PHY_WRITE_REQ_DELTA end)),2)||'%','*');      

      
      pr(max_l,l_stat_ln,'LIO:               '||r_stats1.BUFFER_GETS_DELTA,   'LIO:               '||r_stats2.BUFFER_GETS_DELTA,   round(100*((r_stats2.BUFFER_GETS_DELTA-r_stats1.BUFFER_GETS_DELTA)      /(case when r_stats2.BUFFER_GETS_DELTA=0 then case when r_stats1.BUFFER_GETS_DELTA=0 then 1 else r_stats1.BUFFER_GETS_DELTA end else r_stats2.BUFFER_GETS_DELTA end)),2)||'%','*');
      pr(max_l,l_stat_ln,'ROWS:              '||r_stats1.ROWS_PROCESSED_DELTA,'ROWS:              '||r_stats2.ROWS_PROCESSED_DELTA,round(100*((r_stats2.ROWS_PROCESSED_DELTA-r_stats1.ROWS_PROCESSED_DELTA)/(case when r_stats2.ROWS_PROCESSED_DELTA=0 then case when r_stats1.ROWS_PROCESSED_DELTA=0 then 1 else r_stats1.ROWS_PROCESSED_DELTA end else r_stats2.ROWS_PROCESSED_DELTA end)),2)||'%','*');
      pr(max_l,l_stat_ln,'LIO/ROW:           '||r_stats1.LIO_PER_ROW,         'LIO/ROW:           '||r_stats2.LIO_PER_ROW,         round(100*((r_stats2.LIO_PER_ROW-r_stats1.LIO_PER_ROW)                  /(case when r_stats2.LIO_PER_ROW=0 then case when r_stats1.LIO_PER_ROW=0 then 1 else r_stats1.LIO_PER_ROW end else r_stats2.LIO_PER_ROW end)),2)||'%','*');
      pr(max_l,l_stat_ln,'PIO/ROW:           '||r_stats1.IO_PER_ROW,          'PIO/ROW:           '||r_stats2.IO_PER_ROW,          round(100*((r_stats2.IO_PER_ROW-r_stats1.IO_PER_ROW)                    /(case when r_stats2.IO_PER_ROW=0 then case when r_stats1.IO_PER_ROW=0 then 1 else r_stats1.IO_PER_ROW end else r_stats2.IO_PER_ROW end)),2)||'%','*');
      pr(max_l,l_stat_ln,'AVG IO (MS):       '||r_stats1.awg_IO_tim,          'AVG IO (MS):       '||r_stats2.awg_IO_tim,          round(100*((r_stats2.awg_IO_tim-r_stats1.awg_IO_tim)                    /(case when r_stats2.awg_IO_tim=0 then case when r_stats1.awg_IO_tim=0 then 1 else r_stats1.awg_IO_tim end else r_stats2.awg_IO_tim end)),2)||'%','*');      
      pr(max_l,l_stat_ln,'IOWT/EXEC(MS)5ms:  '||r_stats1.io_wait_pe_5ms,      'IOWT/EXEC(MS)5ms:  '||r_stats2.io_wait_pe_5ms,      round(100*((r_stats2.io_wait_pe_5ms-r_stats1.io_wait_pe_5ms)            /(case when r_stats2.io_wait_pe_5ms=0 then case when r_stats1.io_wait_pe_5ms=0 then 1 else r_stats1.io_wait_pe_5ms end else r_stats2.io_wait_pe_5ms end)),2)||'%','*');      
      pr(max_l,l_stat_ln,'IOWAIT(SEC)5ms:    '||r_stats1.io_wait_5ms,         'IOWAIT(SEC)5ms:    '||r_stats2.io_wait_5ms,         round(100*((r_stats2.io_wait_5ms-r_stats1.io_wait_5ms)                  /(case when r_stats2.io_wait_5ms=0 then case when r_stats1.io_wait_5ms=0 then 1 else r_stats1.io_wait_5ms end else r_stats2.io_wait_5ms end)),2)||'%','*');      
      
      p(rpad('-',max_l*2+1,'-'));
      p('ASH Wait Profile, sec (approx)');
      p(rpad('-',max_l*2+1,'-'));
      -- wait profile
      for ww in (
                 with locals as ( 
                 select x.*, count(1)*10 cntl from (
                 select nvl(wait_class, '_') wait_class, nvl(event, session_state) event
                   from dba_hist_active_sess_history
                  where dbid = &dbid1.
                    and snap_id in (&snaps1.)
                    and (sql_id = l_sql_id or TOP_LEVEL_SQL_ID = l_sql_id)) x
                  group by wait_class, event),
                  remotes as ( 
                 select x.*, count(1)*10 cntr from (
                 select nvl(wait_class, '_') wait_class, nvl(event, session_state) event
                   from dba_hist_active_sess_history&dblnk.
                  where dbid = &dbid2.
                    and snap_id in (&snaps2.)
                    and (sql_id = l_sql_id or TOP_LEVEL_SQL_ID = l_sql_id)) x
                  group by wait_class, event)
                 select decode(wait_class,'_','.',wait_class) wait_class,event,cntl,cntr,round(100*(cntr-cntl)/decode(cntr,0,1,cntr),2) delta
                 from locals full outer join remotes using (wait_class,event)
                 order by 1 nulls first,2)
      loop
        pr(max_l,70,rpad(ww.wait_class,20,' ')||rpad(ww.event,35,' ')||ww.cntl, rpad(ww.wait_class,20,' ')||rpad(ww.event,35,' ')||ww.cntr, ww.delta||'%','*');      
      end loop;      
      p(rpad('-',max_l*2+1,'-'));
      --plans
      if l_single_plan then
        p('ATTENTION: single plan available only');
        p(rpad('-',max_l*2+1,'-'));
      end if;
      if my_rec(a).plan_hash_value=0 then
        p('ATTENTION: no plan available, plan_hash_value=0');
        p('-----------------------------------------------');
        select sql_text into l_sql_txt from dba_hist_sqltext where sql_id = l_sql_id and dbid = &dbid1.;
        p(l_sql_txt);
        p(rpad('-',max_l*2+1,'-'));
      end if;
      
      for j in 1 .. i loop
        if p1.exists(j) then
          r1:=rpad('.'||nvl(rtrim(replace(p1(j),chr(9),' ')),' '), max_l, ' ');
        else
          r1 := rpad('.', max_l, ' ');
        end if;
        if p2.exists(j) and not l_single_plan then
          r2 := p2(j);
        else
          r2 := null;
        end if;
        if trim(ltrim(r1,'.'))=trim(r2) then
          p(r1 || '+' || r2);
        else
          p(r1 || case when r2 is null then '*' else '-' || r2 end);
        end if;
      end loop;
    end loop;
  end loop;
end;
