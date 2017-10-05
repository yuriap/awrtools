conn &localscheme./&localscheme.@&localdb.

prompt The error here can be ignored during the very first install session
begin
  for i in (select proj_id from awrtoolproject) loop
    awrtools_api.archive_project(i.proj_id);
  end loop;
end;
/

drop table awrcomp_scripts;
drop table awrconfig;
drop table awrcomp_reports;
drop table awrdumps_files;
drop table awrdumps;
drop table awrtoolproject;
drop table awrcomp_d_sortordrs;
drop table awrcomp_d_report_types;
drop database link &DBLINK.;

disc