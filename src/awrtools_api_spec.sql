create or replace package awrtools_api as

   --project
   procedure add_project(p_proj_name AWRTOOLPROJECT.PROJ_NAME%type,
                         p_proj_descr AWRTOOLPROJECT.PROJ_DESCRIPTION%type,
                         p_proj_id out AWRTOOLPROJECT.PROJ_ID%type);
   procedure edit_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type,
                          p_proj_name AWRTOOLPROJECT.PROJ_NAME%type,
                          p_proj_date AWRTOOLPROJECT.proj_date%type,
                          p_proj_descr AWRTOOLPROJECT.PROJ_DESCRIPTION%type);
   procedure del_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type);
   procedure lock_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type);
   procedure unlock_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type);

   procedure del_report(p_report_id awrcomp_reports.report_id%type);

   function getconf(p_key varchar2) return varchar2 RESULT_CACHE;
   function getscript(p_script_id varchar2) return clob;

   procedure create_new_dump(p_proj_id AWRDUMPS.proj_id%type,
                             p_filename AWRDUMPS.filename%type,
                             p_dump_description AWRDUMPS.dump_description%type,
                             p_filebody AWRDUMPS_FILES.filebody%type);
   procedure load_dump_into_repo(p_dump_id awrdumps.dump_id%type, p_dest varchar2);
   procedure unload_dump(p_dump_id awrdumps.dump_id%type);
   procedure del_file(p_dump_id awrdumps.dump_id%type);
   procedure load_dump_from_file(p_proj_id AWRDUMPS.proj_id%type,
                                 p_filename AWRDUMPS.filename%type,
                                 p_dump_description AWRDUMPS.dump_description%type,
                                 p_loading_date AWRDUMPS.loading_date%type default null,
                                 p_dbid AWRDUMPS.dbid%type default null,
                                 p_min_snap_id AWRDUMPS.min_snap_id%type default null,
                                 p_max_snap_id AWRDUMPS.max_snap_id%type default null,
                                 p_min_snap_dt AWRDUMPS.min_snap_dt%type default null,
                                 p_max_snap_dt AWRDUMPS.max_snap_dt%type default null,
                                 p_db_description AWRDUMPS.db_description%type default null);
end awrtools_api;
/