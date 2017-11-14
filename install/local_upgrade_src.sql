spool local_upgrade_src_config.log

@version
prompt Upgrade local scheme of AWR Tools
prompt Version &awrtoolversion

set echo on
@install_config
set echo off
spool off


spool local_upgrade_src.log

--Create source code objects
conn &localscheme./&localscheme.@&localdb.
set echo on

@../src/awrtools_contr_spec 
show errors
@../src/awrtools_contr_body
show errors

@../src/awrtools_loc_utils_spec
show errors
@../src/awrtools_loc_utils_body
show errors

@../src/awrtools_api_spec
show errors
@../src/awrtools_api_body
show errors

@../src/awrtools_reports_spec
show errors
set define off
@../src/awrtools_reports_body
set define on
show errors

set define off

declare
  l_script clob := 
q'^
@../scripts/_getcomph.sql
^';
begin
  delete from awrcomp_scripts where script_id='GETCOMPREPORT';
  insert into awrcomp_scripts (script_id,script_content) values
  ('GETCOMPREPORT',l_script||l_script1);
end;
/

declare
  l_script clob := 
q'^
@../scripts/_getplanawrh
^';
begin
  delete from awrcomp_scripts where script_id='GETAWRSQLREPORT';
  insert into awrcomp_scripts (script_id,script_content) values
  ('GETAWRSQLREPORT',l_script);
end;
/

set define on
commit;


spool off
disc
