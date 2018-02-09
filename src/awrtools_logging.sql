create or replace package awrtools_logging is
  procedure log(p_msg clob);
  procedure cleanup;
end;
/
create or replace package body awrtools_logging is
  procedure log(p_msg clob)
  is
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    insert into AWRTOOLS_LOG values (default, p_msg);
    commit;
  end;
  procedure cleanup
  is
  begin
    delete from AWRTOOLS_LOG where ts>sysdate-8;
    dbms_output.put_line('Deleted '||sql%rowcount||' log row(s).');
    commit;
  exception
    when others then rollback;dbms_output.put_line(sqlerrm);
  end;
end;
/