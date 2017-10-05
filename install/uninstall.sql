spool uninstall.log

@version
prompt Uninstall of AWR Tools
prompt Version &awrtoolversion

set echo on

rem Unload all loaded AWR ranges
@cleanup

rem Remote unsinstall
conn sys/&remotesys.@&remotedb. as sysdba

drop user &remotescheme. cascade;
drop directory &dirname.;
drop tablespace &tblspc_name.;

disc

conn sys/&localsys.@&localdb. as sysdba

drop user &localscheme. cascade;
drop directory &dirname.;
drop tablespace &tblspc_name.;


disc

spool off