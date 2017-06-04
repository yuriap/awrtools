rem Web AWR Tools. Ver 1.000
create or replace package awrtools_contr as 

  --Project life-cycle
  procedure lcc_project_create(p_proj_id awrtoolproject.proj_id%type);
  procedure lcc_project_arcive(p_proj_id awrtoolproject.proj_id%type);
  procedure lcc_project_compress(p_proj_id awrtoolproject.proj_id%type);
  
  --Dump lifecycle
  procedure lcc_dump_create(p_dump_id awrdumps.dump_id%type);
  procedure lcc_dump_load(p_dump_id awrdumps.dump_id%type);
  procedure lcc_dump_unload(p_dump_id awrdumps.dump_id%type);
  procedure lcc_dump_compress(p_dump_id awrdumps.dump_id%type);

  --Action availability  
  --Project
  function lcc_project_load(p_proj_id awrtoolproject.proj_id%type) return boolean;
  function lcc_project_report(p_proj_id awrtoolproject.proj_id%type) return boolean;
  function lcc_project_archive(p_proj_id awrtoolproject.proj_id%type) return boolean;
  function lcc_project_compress(p_proj_id awrtoolproject.proj_id%type) return boolean;
  --Dump
  function lcc_dump_loadawr(p_dump_id awrdumps.dump_id%type) return boolean;
  function lcc_dump_unloadawr(p_dump_id awrdumps.dump_id%type) return boolean;
  function lcc_dump_delfile(p_dump_id awrdumps.dump_id%type) return boolean;
  
end awrtools_contr;
/