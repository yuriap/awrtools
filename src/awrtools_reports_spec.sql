create or replace package awrtools_reports as

  function create_report(p_report_type varchar2, p_proj_id AWRTOOLPROJECT.proj_id%type, p_copy_from AWRCOMP_REPORTS.REPORT_ID%type default null) return AWRCOMP_REPORTS.REPORT_ID%type;
  
  procedure create_report(p_report_id AWRCOMP_REPORTS.REPORT_ID%type);
  function get_report_params_visibility(p_report_type varchar2, p_control_name varchar2) return boolean result_cache;
  
  procedure save_param(p_report_id AWRCOMP_REPORTS.REPORT_ID%type, p_param_name varchar2, p_param_value varchar2);
  function get_param(p_report_id AWRCOMP_REPORTS.REPORT_ID%type, p_param_name varchar2) return varchar2 result_cache;
end;
/