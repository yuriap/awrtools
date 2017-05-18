create or replace package awrtool_pkg as

  function getconf(p_key varchar2) return varchar2;
  function getscript(p_script_id varchar2) return clob;
  procedure save_dump(p_blob blob, p_filename varchar2, p_dir varchar2);
  procedure remove_dump(p_filename varchar2, p_dir varchar2);
  procedure awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
                       p_dbid out number,p_min_snap_id out number,p_max_snap_id out number,p_min_snap_dt out timestamp,p_max_snap_dt out timestamp,p_db_description out varchar2);
  procedure remote_awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
                       p_dbid out number,p_min_snap_id out number,p_max_snap_id out number,p_min_snap_dt out timestamp,p_max_snap_dt out timestamp,p_db_description out varchar2);
  procedure create_awrcomp_report(p_report_id AWRCOMP_REPORTS.REPORT_ID%type);
end;
/
