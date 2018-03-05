conn &localscheme./&localscheme.@&localdb.

set serveroutput on

prompt The error here can be ignored during the very first install session
begin
  for i in (select proj_id from awrtoolproject) loop
    awrtools_api.del_project(i.proj_id);
  end loop;
end;
/

pause Make sure cleanup has been done correctly, otherwise AWR repo needs to be cleaned up manually. Press Enter to continue...

begin
  dbms_scheduler.drop_job(job_name => 'AWRTOOL_CLEANUP');
end;
/

declare
  type t_names is table of varchar2(512);
  l_names t_names;
 
  procedure drop_tables is
  begin
    dbms_output.put_line('Dropping tables...');
    select table_name bulk collect
      into l_names
      from user_tables
     where table_name like 'AWR%'
        or table_name like 'REMOTE_ASH%'
     order by 1;
    for i in 1 .. l_names.count loop
      begin
        execute immediate 'drop table ' || l_names(i);
		dbms_output.put_line('Dropped ' || l_names(i));
      exception
        when others then
          dbms_output.put_line('Dropping error of ' || l_names(i) || ': ' || sqlerrm);
      end;
    end loop;
  end;
  procedure drop_dblinks is
  begin
    dbms_output.put_line('Dropping dblinks...');
    select db_link bulk collect
      into l_names
      from user_db_links
     order by 1;
    for i in 1 .. l_names.count loop
      begin
        execute immediate 'drop database link ' || l_names(i);
		dbms_output.put_line('Dropped ' || l_names(i));
      exception
        when others then
          dbms_output.put_line('Dropping error of ' || l_names(i) || ': ' || sqlerrm);
      end;
    end loop;
  end;  
begin
  drop_dblinks();
  drop_tables();
  drop_tables();
  drop_tables();
end;
/

disc