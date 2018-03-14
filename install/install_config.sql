rem AWR Tools scheme for local database
define localscheme=awrtools21

rem AWR Tools scheme for remote database
define remotescheme=awrtools21

rem Path for directory object for dump processing
rem Make sure the directory already exists and accessible for both local and remote databases
define dirpath="/u01/app/oracle/files/awrdata/"
define dirname=awrdata21

rem Tablespace name for AWR Tools
define tblspc_name=awrtool21tbs

rem Local database connection string host:port/service_name
define localdb=localhost:1521/db12c21m.localdomain

rem Remote database connection string host:port/service_name
define remotedb=localhost:1521/db12c22.localdomain

rem Connection string host:port/service_name from local to remote database
define dblinkstr=localhost:1521/db12c22.localdomain

rem Local SYS password (can be empty)
define localsys=qazwsx

rem Remote SYS password (can be empty)
define remotesys=qazwsx

rem Database link from local database to remote database
define DBLINK=DBAWR2

rem Staging user for load AWR dump into repository
define AWRSTG=awrstg21