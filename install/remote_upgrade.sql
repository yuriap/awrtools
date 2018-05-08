spool .\logs\local_upgrade_config.log

@version
prompt Upgrade remote scheme of AWR Tools
prompt Version &awrtoolversion

set echo on
@install_config
set echo off
spool off

spool .\logs\remote_upgrade.log

set echo on
@cleanup
@remote_install

set echo off
spool off

disc