create or replace package awrtools_logging is
  -- INFO
  -- DEBUG
  procedure log(p_msg clob, p_loglevel varchar2 default 'INFO');
  procedure cleanup;
end;
/
create or replace package body awrtools_logging is
  procedure log(p_msg clob, p_loglevel varchar2 default 'INFO')
  is
    PRAGMA AUTONOMOUS_TRANSACTION;
    l_level varchar2(100):=awrtools_api.getconf('LOGGING_LEVEL');
  begin
    if (l_level='INFO' and p_loglevel='INFO') or
       (l_level='DEBUG' and p_loglevel in ('INFO', 'DEBUG'))
    then
      insert into AWRTOOLS_LOG values (default, p_msg);
      commit;
    end if;
  end;
  procedure cleanup
  is
  begin
    delete from AWRTOOLS_LOG where ts < sysdate-to_number(awrtools_api.getconf('LOGS_EXPIRE_TIME'));
    dbms_output.put_line('Deleted '||sql%rowcount||' log row(s).');
    commit;
  exception
    when others then rollback;dbms_output.put_line(sqlerrm);
  end;
end;
/