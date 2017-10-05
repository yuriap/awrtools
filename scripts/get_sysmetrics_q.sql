with a as (select * from dba_hist_sysmetric_history&p_dblnk. where dbid=&p_dbid. and snap_id in (&p_snapshots.) and instance_number=1)
select * 
from
(select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'SREADTIM' metric_name1,round(value, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'Average Synchronous Single-Block Read Latency')
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'READS' metric_name1,round(value, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'Physical Reads Per Sec')
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'WRITES' metric_name1,round(value, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'Physical Writes Per Sec')   
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'REDO' metric_name1,round(value/1024/1024, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'Redo Generated Per Sec')   
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'IOPS' metric_name1,round(value, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'I/O Requests per Second') 
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'MBPS' metric_name1,round(value, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'I/O Megabytes per Second')  
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'DBCPU' metric_name1,round(value/100, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'CPU Usage Per Sec')  
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'HOSTCPU' metric_name1,round(value/100, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'Host CPU Usage Per Sec')    
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'EXECS' metric_name1,round(value, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'Executions Per Sec')
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'NETW' metric_name1,round(value/1024/1024, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'Network Traffic Volume Per Sec')
union all
select to_char(end_time,'yyyy-mm-dd hh24:mi:ss') end_time, 'CALLS' metric_name1,round(value, 3) val1, metric_unit metric1
  from a
 where metric_name in ( 'User Calls Per Sec')    
) pivot
(max(val1)val,max(metric1)metr for metric_name1 in 
  ('SREADTIM' as SREADTIM, 
   'READS' as READS, 
   'WRITES' WRITES, 
   'REDO' as REDO,
   'IOPS' as IOPS,
   'MBPS' as MBPS,
   'DBCPU' as DBCPU,
   'HOSTCPU' as HOSTCPU,
   'EXECS' as EXECS,
   'NETW' as NETW,
   'CALLS' as CALLS   ))
order by 1,2 desc