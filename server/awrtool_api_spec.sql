create or replace package awrtools_api as 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
     --project
   procedure add_project(p_proj_name AWRTOOLPROJECT.PROJ_NAME%type, 
                         p_proj_descr AWRTOOLPROJECT.PROJ_DESCRIPTION%type);
   procedure edit_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type,
                          p_proj_name AWRTOOLPROJECT.PROJ_NAME%type, 
                          p_proj_date AWRTOOLPROJECT.proj_date%type,
                          p_proj_descr AWRTOOLPROJECT.PROJ_DESCRIPTION%type);
   procedure del_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type);
   procedure archive_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type);
   procedure compress_project(p_proj_id awrtoolproject.proj_id%type);
   
   procedure del_report(p_report_id awrcomp_reports.report_id%type);
end awrtools_api;
/