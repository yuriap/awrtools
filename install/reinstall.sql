spool .\logs\uninstall.log
@uninstall
spool off

spool .\logs\install.log
@install
spool off
set echo off

disc