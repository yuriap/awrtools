create or replace package awrtools_logging is
  procedure log(p_msg varchar2);
end;
/
create or replace package body awrtools_logging is
  procedure log(p_msg varchar2)
  is
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    insert into AWRTOOLS_LOG values (default, p_msg);
    commit;
  end;
end;
/