rem AWR Tools scheme for local database
define localscheme=awrtools20

rem AWR Tools scheme for remote database
define remotescheme=awrtools20

rem Path for directory object for dump processing
rem Make sure the directory already exists and accessible for both local and remote databases
define dirpath="/u01/app/oracle/files/awrdata/"
define dirname=awrdata20

rem Tablespace name for AWR Tools
define tblspc_name=awrtool20tbs

rem Local database connection string host:port/service_name
define localdb=192.168.56.102:1521/db12c21m.localdomain

rem Remote database connection string host:port/service_name
define remotedb=192.168.56.102:1521/db12c22.localdomain

rem Connection string host:port/service_name from local to remote database
define dblinkstr=localhost:1521/db12c22.localdomain

rem Local SYS password (can be empty)
define localsys=qazwsx

rem Remote SYS password (can be empty)
define remotesys=qazwsx

rem Database link from local database to remote database
define DBLINK=DBAWR1