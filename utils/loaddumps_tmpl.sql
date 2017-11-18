spool loaddumps.log
set serveroutput on

variable p_proj_id number

--remove all projects
begin
  for i in (select proj_id from awrtoolproject) loop
    awrtools_api.del_project(i.proj_id);
  end loop;
end;
/

--create project
declare
  l_name    awrtoolproject.proj_name%type := '<Project name>';
  l_descr    awrtoolproject.proj_description%type := '<Project description>';
begin
  awrtools_api.add_project(l_name,l_descr,:p_proj_id);
  commit;
  dbms_output.put_line('Project "'||l_name||'" has been created. PROJ_ID='||:p_proj_id);
end;
/

declare
  l_filename AWRDUMPS.filename%type := '<duump_file_name>.dmp';
  l_dump_description AWRDUMPS.dump_description%type := q'[Dump description]';
begin
  awrtools_api.load_dump_from_file(:p_proj_id, l_filename, l_dump_description);
  commit;
  dbms_output.put_line('Dump "'||l_filename||'" has been loaded into PROJ_ID='||:p_proj_id);
end;
/
spool off

set serveroutput off