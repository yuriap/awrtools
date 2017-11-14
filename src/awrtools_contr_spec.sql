create or replace package awrtools_contr as 

  -- Project actions
  c_project_create        constant number :=1;
  c_project_edit          constant number :=2;
  c_project_drop          constant number :=3;
  c_project_analyze       constant number :=4; -- any operations with dumps (load/unload dump file, load/unload data into AWR repo) and reports
  c_project_lock          constant number :=5;
  c_project_unlock        constant number :=6;
  
  --Project states
  c_projstate_new         constant awrtoolproject.proj_status%type := 'NEW';
  c_projstate_active      constant awrtoolproject.proj_status%type := 'ACTIVE';
  c_projstate_locked      constant awrtoolproject.proj_status%type := 'LOCKED';
  
  
  --Dump actions
  c_dump_create           constant number :=1;
  c_dump_loadfile         constant number :=2;
  c_dump_load2awr         constant number :=3;
  c_dump_unloadawr        constant number :=4;
  c_dump_removefile       constant number :=5;
  c_dump_any              constant number :=6;
  
  --Dump states
  c_dumpstate_new         constant awrdumps.status%type := 'NEW';       -- no dump file loaded
  c_dumpstate_dmploaded   constant awrdumps.status%type := 'DMPLOADED'; -- dump file is loaded in table
  c_dumpstate_awrloaded   constant awrdumps.status%type := 'AWRLOADED'; -- dump in AWR repo and in table
  c_dumpstate_compressed  constant awrdumps.status%type := 'COMPRESSED';-- dump file removed AWR is loaded
  c_dumpstate_archived    constant awrdumps.status%type := 'ARCHIVED';  -- dump file removed and AWR unloaded  
  
  --Project life-cycle set state
  procedure lcc_project_exec_action(p_proj_id awrtoolproject.proj_id%type, p_action number);
  
  --Dump lifecycle set state
  procedure lcc_dump_exec_action(p_dump_id awrdumps.dump_id%type, p_action number);

  --Action availability  
  --Project
  function lcc_project_check_action(p_proj_id awrtoolproject.proj_id%type, p_action number) return boolean;
  
  --Dump
  function lcc_dump_check_action(p_dump_id awrdumps.dump_id%type, p_action number) return boolean;
  
end awrtools_contr;
/