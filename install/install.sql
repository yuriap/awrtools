spool install_config.log

@version
prompt Installation of AWR Tools
prompt Version &awrtoolversion

set echo on
@install_config
set echo off
spool off

spool install.log

set echo on
@local_sys_setup
@remote_sys_setup
@remote_install
@local_install

spool off
set echo off

disc