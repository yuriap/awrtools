spool local_upgrade.log

@version
prompt Upgrade local scheme of AWR Tools
prompt Version &awrtoolversion

set echo on
@install_config
@cleanup
@local_install

spool off