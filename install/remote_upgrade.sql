spool remote_upgrade.log

@version
prompt Upgrade remote scheme of AWR Tools
prompt Version &awrtoolversion

set echo on
@cleanup
@remote_install

spool off