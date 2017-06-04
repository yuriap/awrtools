rem Web AWR Tools. Ver 1.000
select 'prompt TOP SQL #' || rownum || chr(13) || chr(10) || cmd cmd, '-- &ordcol.(' || tot || ')' capt
  from (select 'define SQLID=' || sql_id || chr(13) || chr(10) || '@getplanawr_plancomp' cmd, &ordcol_expr. tot --,parsing_schema_name,module,action
          from (select db2.*
                  from (select sql_id --,CPU_TIME_DELTA,ELAPSED_TIME_DELTA,BUFFER_GETS_DELTA,EXECUTIONS_DELTA
                          from dba_hist_sqlstat
                         where dbid = &dbid1.
                           and snap_id in (&snaps1.)
                           and parsing_schema_name <> 'SYS'
                           and decode(module, 'performance_info', 0, 1) = 1
                           --and decode(module, 'SQL*Plus', 0, 1) = 1
                           and decode(module, 'MMON_SLAVE', 0, 1) = 1
                           --and plan_hash_value <> 0
                           and &filter.
                        intersect
                        select sql_id --,CPU_TIME_DELTA,ELAPSED_TIME_DELTA,BUFFER_GETS_DELTA,EXECUTIONS_DELTA
                          from dba_hist_sqlstat&dblnk.
                         where dbid = &dbid2.
                           and snap_id in (&snaps2.)
                           and parsing_schema_name <> 'SYS'
                           and decode(module, 'performance_info', 0, 1) = 1
                           --and decode(module, 'SQL*Plus', 0, 1) = 1
                           and decode(module, 'MMON_SLAVE', 0, 1) = 1
                           --and plan_hash_value <> 0
                           and &filter.) db1,
                       (select *
                          from dba_hist_sqlstat
                         where dbid = &dbid1. and snap_id in (&snaps1.)
                           and parsing_schema_name <> 'SYS'
                           and decode(module, 'performance_info', 0, 1) = 1
                           --and decode(module, 'SQL*Plus', 0, 1) = 1
                           and decode(module, 'MMON_SLAVE', 0, 1) = 1
                           --and plan_hash_value <> 0
                           and &filter.
                        union all
                        select *
                          from dba_hist_sqlstat&dblnk.
                         where dbid = &dbid2. and snap_id in (&snaps2.)
                           and parsing_schema_name <> 'SYS'
                           and decode(module, 'performance_info', 0, 1) = 1
                           --and decode(module, 'SQL*Plus', 0, 1) = 1
                           and decode(module, 'MMON_SLAVE', 0, 1) = 1
                           --and plan_hash_value <> 0
                           and &filter.
                        ) db2
                 where db1.sql_id = db2.sql_id)
         group by sql_id having &ordcol_expr. > &statlimit.
         order by tot desc)