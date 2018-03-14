insert into awrconfig values ('WORKDIR',upper('&dirname.'),'Oracle directory for loading AWR dumps');
insert into awrconfig values ('AWRSTGUSER','&AWRSTG.','Staging user for AWR Load package');
insert into awrconfig values ('AWRSTGTBLSPS','&tblspc_name.','Default tablespace for AWR staging user');
insert into awrconfig values ('AWRSTGTMP','TEMP','Temporary tablespace for AWR staging user');
insert into awrconfig values ('DBLINK','&DBLINK.','DB link name for remote AWR repository');
insert into awrconfig values ('TOOLVERSION','&awrtoolversion.','AWR tool version');

insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('ELAPSED_TIME_DELTA','Sort by Elapsed Time','ela_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('DISK_READS_DELTA','Sort by Disk Reads','reads_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('CPU_TIME_DELTA','Sort by CPU time','cpu_tot');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value,dic_filename_pref) values('BUFFER_GETS_DELTA','Sort by LIO','lio_tot');

insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRCOMP','AWR query plan compare report (custom)','comp_ordr_',10);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRSQLREPORT','AWR SQL report (custom)','awr_',20);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('SQLMULTIPLAN','Analyze SQLs with multiple plans (custom)','awr_multi_',30);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRRPT','AWR report (standard)','awrrpt_',40);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRGLOBALRPT','AWR global report (standard)','awrrpt_glob_',50);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRSQRPT','AWR SQL report (standard)','awrsql_',60);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRDIFF','AWR diff (standard)','awr_diff_',70);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('AWRGLOBALDIFF','AWR global diff (standard)','awr_diff_glob_',80);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('ASHRPT','ASH report (standard)','awr_ash_',90);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('ASHGLOBALRPT','ASH global report (standard)','awr_ash_glob_',100);
insert into awrcomp_d_report_types(dic_value,dic_display_value,dic_filename_pref, dic_ordr) values('ASHANALYTICS','ASH analytics report (standard)','ash_analyt_',110);