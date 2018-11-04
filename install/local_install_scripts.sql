set define off
set serveroutput on

declare
  l_script clob := 
q'^
@../scripts/_getplanawrh
^';
begin
  delete from awrcomp_scripts where script_id='GETAWRSQLREPORT';
  insert into awrcomp_scripts (script_id,script_content) values ('GETAWRSQLREPORT',l_script);
end;
/

declare
  l_script clob := 
q'^
@../scripts/_getcomph.sql
^';
begin
  delete from awrcomp_scripts where script_id='GETCOMPREPORT';
  insert into awrcomp_scripts (script_id,script_content) values ('GETCOMPREPORT',l_script||l_script1);
  dbms_output.put_line('#1: '||dbms_lob.getlength(l_script)||' bytes; #2: '||dbms_lob.getlength(l_script1)||' bytes;');
end;
/

declare
  l_script clob;
begin
  l_script := 
q'^
@../scripts/__prn_tbl_html.sql
^';
  delete from awrcomp_scripts where script_id='PROC_PRNHTMLTBL';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_PRNHTMLTBL',l_script);

  l_script := 
q'^
@../scripts/__getftxt.sql
^';
  delete from awrcomp_scripts where script_id='PROC_GETGTXT';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_GETGTXT',l_script);

  l_script := 
q'^
@../scripts/__nonshared1.sql
^';
  delete from awrcomp_scripts where script_id='PROC_NON_SHARED';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_NON_SHARED',l_script);

  l_script := 
q'^
@../scripts/__vsql_stat.sql
^';
  delete from awrcomp_scripts where script_id='PROC_VSQL_STAT';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_VSQL_STAT',l_script);

  l_script := 
q'^
@../scripts/__offload_percent1.sql
^';
  delete from awrcomp_scripts where script_id='PROC_OFFLOAD_PCT1';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_OFFLOAD_PCT1',l_script);
  
  l_script := 
q'^
@../scripts/__offload_percent2.sql
^';
  delete from awrcomp_scripts where script_id='PROC_OFFLOAD_PCT2';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_OFFLOAD_PCT2',l_script);
  
  l_script := 
q'^
@../scripts/__sqlmon1.sql
^';
  delete from awrcomp_scripts where script_id='PROC_SQLMON';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_SQLMON',l_script);

  l_script := 
q'^
@../scripts/__sqlwarea.sql
^';
  delete from awrcomp_scripts where script_id='PROC_SQLWORKAREA';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_SQLWORKAREA',l_script);

  l_script := 
q'^
@../scripts/__optenv.sql
^';
  delete from awrcomp_scripts where script_id='PROC_OPTENV';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_OPTENV',l_script);

  l_script := 
q'^
@../scripts/__rac_plans.sql
^';
  delete from awrcomp_scripts where script_id='PROC_RACPLAN';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_RACPLAN',l_script);

  l_script := 
q'^
@../scripts/__sqlmon_hist.sql
^';
  delete from awrcomp_scripts where script_id='PROC_SQLMON_HIST';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_SQLMON_HIST',l_script);
  
  l_script := 
q'^
@../scripts/__getplanawrh_sect.sql
^';
  delete from awrcomp_scripts where script_id='PROC_AWR_SECT';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_SQLMON_HIST',l_script);
end;
/

declare
  l_script clob;
begin
  l_script :=
q'{
@@../scripts/__sqlstat.sql
}';
  delete from awrcomp_scripts where script_id='PROC_AWRSQLSTAT';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRSQLSTAT',l_script);
  
  l_script := 
q'[
@@../scripts/__ash_summ
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHSUMM';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHSUMM',l_script);

  l_script := 
q'[
@@../scripts/__ash_p1
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHP1';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHP1',l_script);

  l_script := 
q'[
@@../scripts/__ash_p1_1
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHP1_1';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHP1_1',l_script);

  l_script := 
q'[
@@../scripts/__ash_p2
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHP2';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHP2',l_script);

  l_script := 
q'[
@@../scripts/__ash_p3
]';
  delete from awrcomp_scripts where script_id='PROC_AWRASHP3';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRASHP3',l_script);
  l_script := 
q'[
@@../scripts/awr.css
]';
  delete from awrcomp_scripts where script_id='PROC_AWRCSS';
  insert into awrcomp_scripts (script_id,script_content) values ('PROC_AWRCSS',l_script);  
end;
/

set define on
commit;
