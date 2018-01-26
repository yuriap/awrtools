Web AWR Tools. Ver 2.7

AWR dump warehouse with web-based UI.

The main aims are:
1) to have some user-friendly interface to manipulate AWR dumps (load, store, comment, unload).
2) to create customized reports from raw AWR data using user-friendly interface, Currently, there are two custom reports "SQL queries compare report (HTML)" and "AWR SQL Report (HTML)" and all standard AWR reports.
3) to share scripts with command-line AWR Tools. Exact the same main scripts are used for both tools.
4) to be able to analyze AWR dumps which contain overlapping snapshot ranges (relevant to a situation when FLASHBACK DATABASE is in use for testing different scenarios).

Setup

1. Prepare two database instances on the same host. First one must have APEX 5 installed.
2. Edit file install/install_config.sql. Write all necessary parameters. Local database is that with APEX installed.
   - both instances must have access to a directory which is used for temporary storage of a dump file (/u01/app/oracle/files/awrdata/ by default)
3. Make "install" as a current directory.
4. Execute the following scripts in the mentioned sequence:

@install

5. Check logs for errors. Fix it if exists and rerun the same script sequence.
7. Install APEX application apexapp/f*.sql, use workspace attached to local user (see item 2 of this instruction).

Uninstall
1. Make sure the file install/install_config.sql contains correct configuration for uninstalled system.
2. Run the following script:

@uninstall

Use-cases:
1. Create a project.
2. Load two or more raw AWR dumps.
3. Load dumps into AWR repository, if snapshot ranges are overlapping, load the second dump into the second (remote) database.
4. Create reports (the are stored automatically).
5. Compress dump: Delete a dump file from database storage. AWR data is available for analysis.
6. Unload AWR range: unload AWR data from AWR repository for a dump. AWR data can be loaded in the future if the dump file is still in the database. 

Version 1.2
Fixes:
1) Report query print engine.
2) Interface

Version 1.2.1
Changes:
1) Loading AWR dump interface to show loaded data more compact.

Version 2.0
Changes:
1) Refactoring code and UI.

Version 2.1
Changes:
1) SQL queries compare report in HTML format only
2) Added new AWR SQL Report.

Version 2.2
1) Added all standard AWR reports

Version 2.3
1) Added protection from loadin already loaded snapshots
2) Snapshot reports (local and remote) shows the project which each snapshot belongs to or some "UNKNOWN" project for those loaded by any other means.

Version 2.4
1) Custom AWR SQL report now has an embeded AWR SQL Compare section

Version 2.5
1) Custom "Analyze SQLs with multiple plans" report added

Version 2.6
1) Added coloring for compared query plans

Version 2.7
1) Added SQL query search form

Version 3.0
1) Added Online Analytic Tool - allows to analyze ASH data from local AWR warehouse as well as from remote one through dblink, V$ASH is also in use.
How to connect DB through DB link to target DB within VPN is on and make it possible to access APEX at the same time:
 - use HOSTNAME instead of IP address in all Oracle Net related configs like listener.ora and tnsnames.ora and any other related network services (see below Oracle REST Data Services )
 - stop all shared servers and dispatchers (notice, Embedded PL/QSL Gateway does not work without shared servers)
 - deploy Oracle REST Data Services (https://docs.oracle.com/cd/E37099_01/doc.20/e25066/install.htm#AELIG7015) and configure it to work with APEX
 - after starting VPN session, put IP address of VPN network adapter to hosts file for your HOSTNAME
 - restart Oracle Net Listener, Oracle Database Instance and start Oracle REST Data Services.

Version 3.0.1
1) Installation bug fix.
2) Interface tiny fixes and improvements.