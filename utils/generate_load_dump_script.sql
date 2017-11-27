declare
  l_header_scr varchar2(32765) := q'[spool loaddumps.log
set serveroutput on

variable p_proj_id number

--remove all projects
begin
  for i in (select proj_id from awrtoolproject) loop
    awrtools_api.del_project(i.proj_id);
  end loop;
end;
/]';

  l_proj_scr varchar2(32765) := q'[--create project
declare
  l_name    awrtoolproject.proj_name%type := '<Project name>';
  l_descr    awrtoolproject.proj_description%type := q'{<Project description>}';
begin
  awrtools_api.add_project(l_name,l_descr,:p_proj_id);
  commit;
  dbms_output.put_line('Project "'||l_name||'" has been created. PROJ_ID='||:p_proj_id);
end;
/]';

l_dump_scr varchar2(32765) := q'[
declare
  l_filename AWRDUMPS.filename%type := '<dump_file_name>';
  l_dump_description AWRDUMPS.dump_description%type := q'{<Dump description>}';
begin
  awrtools_api.load_dump_from_file(:p_proj_id, l_filename, l_dump_description);
  commit;
  dbms_output.put_line('Dump "'||l_filename||'" has been loaded into PROJ_ID='||:p_proj_id);
end;
/]';

  l_footer_scr varchar2(32765) := q'[spool off
set serveroutput off]';

procedure p(p_msg varchar2) is begin dbms_output.put_line(p_msg); end;

begin
   p(l_header_scr);
   for i in (SELECT PROJ_ID, PROJ_NAME, PROJ_DESCRIPTION FROM AWRTOOLPROJECT order by PROJ_ID) loop
     p(replace(replace(l_proj_scr,'<Project name>',i.PROJ_NAME),'<Project description>',i.PROJ_DESCRIPTION));
     for j in (SELECT PROJ_ID, FILENAME, DUMP_DESCRIPTION FROM AWRDUMPS where PROJ_ID=i.PROJ_ID) loop
       p(replace(replace(l_dump_scr,'<dump_file_name>',j.FILENAME),'<Dump description>',j.DUMP_DESCRIPTION));
     end loop;
   end loop;
   p(l_footer_scr);
end;