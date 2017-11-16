conn &localscheme./&localscheme.@&localdb.

prompt The error here can be ignored during the very first install session
begin
  for i in (select proj_id from awrtoolproject) loop
    awrtools_api.del_project(i.proj_id);
  end loop;
end;
/

pause Make sure cleanup has been done correctly, otherwise AWR repo needs to be cleaned up manually. Press Enter to continue...

drop table awrcomp_scripts;
drop table awrconfig;
drop table awrcomp_reports_params;
drop table awrcomp_reports;
drop table awrdumps_files;
drop table awrdumps;
drop table awrtoolproject;
drop table awrcomp_d_sortordrs;
drop table awrcomp_d_report_types;
drop database link &DBLINK.;

disc