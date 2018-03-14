spool local_upgrade_src_config.log

@version
prompt Upgrade local scheme of AWR Tools
prompt Version &awrtoolversion

set echo on
@install_config
set echo off
spool off


spool local_upgrade_src.log

--Create source code objects
conn &localscheme./&localscheme.@&localdb.

--Create source code objects
@local_install_src

--Load scripts
@local_install_scripts

disc

spool off