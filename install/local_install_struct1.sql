prompt ORA-27475: unknown job can be ignored

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