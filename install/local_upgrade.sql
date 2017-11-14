spool local_upgrade_config.log

@version
prompt Upgrade local scheme of AWR Tools
prompt Version &awrtoolversion

set echo on
@install_config
set echo off
spool off

spool local_upgrade.log

set echo on
@cleanup
@local_install

spool off
set echo off