spool reinstall.log

@version
prompt Reinstallation (recreation) of AWR Tools
prompt Version &awrtoolversion

set echo on
@install_config
spool off

@uninstall

spool reinstall.log append
@remote_sys_setup
@local_sys_setup

@remote_install
@local_install

spool off