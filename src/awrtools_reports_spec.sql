create or replace package awrtools_reports as
  procedure create_awrcomp_report(p_report_id AWRCOMP_REPORTS.REPORT_ID%type);
end;
/