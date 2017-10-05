create or replace package body awrtools_contr as

  function getprojstatus(p_proj_id awrtoolproject.proj_id%type) return awrtoolproject.proj_status%type
  is
    l_status awrtoolproject.proj_status%type;
  begin
    select PROJ_STATUS into l_status from awrtoolproject where proj_id=p_proj_id;
    return l_status;
  exception
    when no_data_found then return null;
  end;

  function lcc_project_check_action(p_proj_id awrtoolproject.proj_id%type, p_action number) return boolean
  is
    l_status awrtoolproject.proj_status%type:=case when p_proj_id is null then null else getprojstatus(p_proj_id) end;
  begin
    return
      case
        when p_action = c_project_create and p_proj_id is null then true
        when p_action = c_project_edit and p_proj_id is not null and l_status in (c_projstate_new,c_projstate_active) then true
        when p_action = c_project_drop and p_proj_id is not null and l_status in (c_projstate_new,c_projstate_active) then true
        when p_action = c_project_analyze and p_proj_id is not null and l_status in (c_projstate_new,c_projstate_active) then true
        when p_action = c_project_lock and p_proj_id is not null and l_status in (c_projstate_new,c_projstate_active) then true
        when p_action = c_project_unlock and p_proj_id is not null and l_status in (c_projstate_locked) then true
      else
        false
      end;
  end;

  procedure lcc_project_set_status(p_proj_id awrtoolproject.proj_id%type, p_status awrtoolproject.proj_status%type)
  is
  begin
    UPDATE awrtoolproject set
        proj_status = p_status
    where proj_id = p_proj_id;
  end;  
  
  procedure lcc_project_exec_action(p_proj_id awrtoolproject.proj_id%type, p_action number)
  is
  begin
    case
      when p_action = c_project_create then 
        begin
          awrtools_contr.lcc_project_set_status(p_proj_id,awrtools_contr.c_projstate_new);
        end;    
      when p_action = c_project_analyze then 
        begin
          awrtools_contr.lcc_project_set_status(p_proj_id,awrtools_contr.c_projstate_active);
        end;         
      when p_action = c_project_lock then 
        begin
          awrtools_contr.lcc_project_set_status(p_proj_id,awrtools_contr.c_projstate_locked);
        end;
      when p_action = c_project_unlock then 
        begin
          awrtools_contr.lcc_project_set_status(p_proj_id,awrtools_contr.c_projstate_active);
        end;        
      else
        raise_application_error(-20000,'Unimplemented project action: '||p_action);
      end case;  
  end;
-------------------------------------------------------------------------------------
  function getdumpstatus(p_dump_id awrdumps.dump_id%type) return awrdumps.status%type
  is
    l_status awrtoolproject.proj_status%type;
  begin
    select status into l_status from awrdumps where dump_id=p_dump_id;
    return l_status;
  exception
    when no_data_found then return null;    
  end;

  function getdumpproj(p_dump_id awrdumps.dump_id%type) return awrtoolproject.proj_id%type
  is
    l_proj_id awrtoolproject.proj_id%type;
  begin
    select proj_id into l_proj_id from awrdumps where dump_id=p_dump_id;
    return l_proj_id;
  exception
    when no_data_found then return null;    
  end;
  /*
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
  c_dumpstate_archived    constant awrdumps.status%type := 'ARCHIVED';--   dump file removed and AWR unloaded  
  */
  function lcc_dump_check_action(p_dump_id awrdumps.dump_id%type, p_action number) return boolean
  is
    l_status awrtoolproject.proj_status%type := case when p_dump_id is null then null else getdumpstatus(p_dump_id) end;
    l_projallows boolean := case when p_dump_id is null then null else lcc_project_check_action(getdumpproj(p_dump_id),c_project_analyze) end;
  begin
    return 
      case
        when p_action = c_dump_create and p_dump_id is null then true
        when p_action = c_dump_loadfile and p_dump_id is not null and l_status in (c_dumpstate_new) then true
        when p_action = c_dump_load2awr and p_dump_id is not null and l_status in (c_dumpstate_dmploaded) then true
        when p_action = c_dump_unloadawr and p_dump_id is not null and l_status in (c_dumpstate_awrloaded,c_dumpstate_compressed) then true
        when p_action = c_dump_removefile and p_dump_id is not null and l_status in (c_dumpstate_dmploaded,c_dumpstate_awrloaded) then true
        when p_action = c_dump_any and p_dump_id is not null and l_status in (c_dumpstate_dmploaded,c_dumpstate_awrloaded,c_dumpstate_compressed) then true
      else
        false
      end 
      and l_projallows;
  end;
  
  procedure lcc_dump_set_status(p_dump_id awrdumps.dump_id%type, p_status awrdumps.status%type)
  is
  begin
    update AWRDUMPS set status=p_status where dump_id=p_dump_id;
  end;
  
  procedure lcc_dump_exec_action(p_dump_id awrdumps.dump_id%type, p_action number)
  is
    l_status awrtoolproject.proj_status%type := getdumpstatus(p_dump_id);
  begin
    case
      when p_action = c_dump_create then 
        begin
          awrtools_contr.lcc_dump_set_status(p_dump_id,awrtools_contr.c_dumpstate_new);
        end;    
      when p_action = c_dump_loadfile then 
        begin
          awrtools_contr.lcc_dump_set_status(p_dump_id,awrtools_contr.c_dumpstate_dmploaded);
        end;          
      when p_action = c_dump_load2awr then 
        begin
          awrtools_contr.lcc_dump_set_status(p_dump_id,awrtools_contr.c_dumpstate_awrloaded);
        end;
      when p_action = c_dump_unloadawr then 
        begin
          if l_status = awrtools_contr.c_dumpstate_awrloaded then
            awrtools_contr.lcc_dump_set_status(p_dump_id,awrtools_contr.c_dumpstate_dmploaded);
          end if;
          if l_status = awrtools_contr.c_dumpstate_compressed then
            awrtools_contr.lcc_dump_set_status(p_dump_id,awrtools_contr.c_dumpstate_archived);
          end if;
        end;      
      when p_action = c_dump_removefile then 
        begin
          if l_status = awrtools_contr.c_dumpstate_dmploaded then
            awrtools_contr.lcc_dump_set_status(p_dump_id,awrtools_contr.c_dumpstate_archived);
          end if;
          if l_status = awrtools_contr.c_dumpstate_awrloaded then
            awrtools_contr.lcc_dump_set_status(p_dump_id,awrtools_contr.c_dumpstate_compressed);
          end if;
        end;         
      else
        raise_application_error(-20000,'Unimplemented dump action: '||p_action);
      end case;    
  end;
-------------------------------------------------------------------------------------

end awrtools_contr;
/