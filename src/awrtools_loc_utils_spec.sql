create or replace package awrtools_loc_utils as
  procedure save_dump(p_blob blob, p_filename varchar2, p_dir varchar2);
  procedure remove_dump(p_filename varchar2, p_dir varchar2);
  procedure awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
                       p_dbid out number,p_min_snap_id out number,p_max_snap_id out number,p_min_snap_dt out timestamp,p_max_snap_dt out timestamp,p_db_description out varchar2);
  procedure remote_awr_load(p_stg_user varchar2, p_stg_tablespace varchar2, p_stg_temp varchar2, p_dir varchar2, p_dmpfile varchar2,
                       p_dbid out number,p_min_snap_id out number,p_max_snap_id out number,p_min_snap_dt out timestamp,p_max_snap_dt out timestamp,p_db_description out varchar2);
  procedure unload_dump(p_is_remote varchar2, p_snap_min number, p_snap_max number, p_dbid number);
  procedure print_text_as_table(p_text clob, p_t_header varchar2, p_width number, p_search varchar2 default null, p_replacement varchar2 default null, p_comparison boolean default false);
  function get_search_query_local(p_startsearch varchar2, p_search_type varchar2, p_search_condition varchar2) return varchar2;
  function get_search_query_remote(p_startsearch varchar2, p_search_type varchar2, p_search_condition varchar2, p_sourcedb varchar2, p_sourcetab varchar2) return varchar2;
end;
/