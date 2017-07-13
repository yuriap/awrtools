create or replace package body awrtools_contr as

  procedure lcc_project_create(p_proj_id awrtoolproject.proj_id%type) as
  begin
    UPDATE awrtoolproject set
        proj_status = 'ACTIVE'
    where proj_id = p_proj_id;
  end lcc_project_create;

  procedure lcc_project_arcive(p_proj_id awrtoolproject.proj_id%type) as
  begin
    UPDATE awrtoolproject set
        proj_status = 'ARCHIVED'
    where proj_id = p_proj_id;
  end lcc_project_arcive;

  procedure lcc_project_compress(p_proj_id awrtoolproject.proj_id%type) as
  begin
    UPDATE awrtoolproject set
        proj_status = 'COMPRESSED'
    where proj_id = p_proj_id;
  end lcc_project_compress;

  procedure lcc_dump_create(p_dump_id awrdumps.dump_id%type) as
  begin
    update AWRDUMPS set status='NEW' where dump_id=p_dump_id;
  end lcc_dump_create;

  procedure lcc_dump_load(p_dump_id awrdumps.dump_id%type) as
  begin
    update AWRDUMPS set status='LOADED' where dump_id=p_dump_id;
  end lcc_dump_load;

  procedure lcc_dump_unload(p_dump_id awrdumps.dump_id%type) as
  begin
    update AWRDUMPS set status='UNLOADED' where dump_id=p_dump_id;
  end lcc_dump_unload;

  procedure lcc_dump_compress(p_dump_id awrdumps.dump_id%type) as
  begin
    update AWRDUMPS set status='COMPRESSED' where dump_id=p_dump_id;
  end lcc_dump_compress;

  function getprojstatus(p_proj_id awrtoolproject.proj_id%type) return awrtoolproject.proj_status%type
  is
    l_status awrtoolproject.proj_status%type;
  begin
    select PROJ_STATUS into l_status from awrtoolproject where proj_id=p_proj_id;
    return l_status;
  end;
-------------------------------------------------------------------------------------
  function lcc_project_load(p_proj_id awrtoolproject.proj_id%type) return boolean as
  begin
    return case when getprojstatus(p_proj_id) in ('ACTIVE','ARCHIVED') then true else false end;
  exception
    when no_data_found then return false;
  end lcc_project_load;

  function lcc_project_report(p_proj_id awrtoolproject.proj_id%type) return boolean as
    l_cnt number;
  begin
    select count(*) into l_cnt from AWRDUMPS where proj_id=p_proj_id and status='LOADED';
    select count(*)+l_cnt into l_cnt from awrcomp_reports 
     where db1_dump_id in (select dump_id from AWRDUMPS where proj_id=p_proj_id) or 
           db2_dump_id in (select dump_id from AWRDUMPS where proj_id=p_proj_id);
    
    return case when getprojstatus(p_proj_id) in ('ACTIVE','ARCHIVED','COMPRESSED') and l_cnt>0 then true else false end;
  exception
    when no_data_found then return false;
  end lcc_project_report;

  function lcc_project_archive(p_proj_id awrtoolproject.proj_id%type) return boolean as
    l_cnt number;
  begin
    select count(*) into l_cnt from AWRDUMPS where proj_id=p_proj_id and status='LOADED';
    return case when getprojstatus(p_proj_id) in ('ACTIVE','ARCHIVED') and l_cnt>0 then true else false end;
  exception
    when no_data_found then return false;
  end lcc_project_archive;

  function lcc_project_compress(p_proj_id awrtoolproject.proj_id%type) return boolean as
    l_cnt number;
  begin
    select count(*) into l_cnt from AWRDUMPS where proj_id=p_proj_id and status!='COMPRESSED';
    return case when getprojstatus(p_proj_id) not in ('COMPRESSED') and l_cnt>0 then true else false end;
  exception
    when no_data_found then return false;
  end lcc_project_compress;

  function lcc_dump_loadawr(p_dump_id awrdumps.dump_id%type) return boolean as
  begin
    return false;
  end lcc_dump_loadawr;

  function lcc_dump_unloadawr(p_dump_id awrdumps.dump_id%type) return boolean as
  begin
    return false;
  end lcc_dump_unloadawr;

  function lcc_dump_delfile(p_dump_id awrdumps.dump_id%type) return boolean as
  begin
    return false;
  end lcc_dump_delfile;

end awrtools_contr;
/