create or replace package body awrtools_api as

  procedure add_project(p_proj_name awrtoolproject.proj_name%type,
                         p_proj_descr awrtoolproject.proj_description%type) as
    l_proj_id AWRTOOLPROJECT.PROJ_ID%type;
  begin
    INSERT INTO awrtoolproject (
      proj_name,
      proj_date,
      proj_description,
      proj_status) VALUES (p_proj_name,default,p_proj_descr,'ACTIVE') returning proj_id into l_proj_id;
  end add_project;

  procedure edit_project(p_proj_id awrtoolproject.proj_id%type,
                          p_proj_name awrtoolproject.proj_name%type,
                          p_proj_date awrtoolproject.proj_date%type,
                          p_proj_descr awrtoolproject.proj_description%type) as
  begin
    UPDATE awrtoolproject set
        proj_name = p_proj_name,
        proj_date = p_proj_date,
        proj_description = p_proj_descr
    where proj_id = p_proj_id;
  end edit_project;

  procedure del_project(p_proj_id awrtoolproject.proj_id%type) as
  begin
   delete from awrtoolproject where proj_id=p_proj_id;
  end del_project;

  procedure archive_project(p_proj_id awrtoolproject.proj_id%type) as
  begin
    --1) remove data from awr repo
    --2) set status UNLOADED for dump
    for i in (select * from AWRDUMPS where proj_id=p_proj_id and status='LOADED') loop
      if i.is_remote='YES' then
        awrtool_pkg.drop_snapshot_range@DBAWR1(low_snap_id => i.min_snap_id,high_snap_id => i.max_snap_id,dbid => i.dbid);
	  else
        dbms_workload_repository.drop_snapshot_range(low_snap_id => i.min_snap_id,high_snap_id => i.max_snap_id,dbid => i.dbid);
      end if;
      update AWRDUMPS set status='UNLOADED' where dump_id=i.dump_id;
    end loop;

    --3) set status ARCHIVED for project
    update awrtoolproject set proj_status='ARCHIVED' where proj_id=p_proj_id;

  end archive_project;
  
  procedure compress_project(p_proj_id awrtoolproject.proj_id%type) as
  begin
    archive_project(p_proj_id);
	update AWRDUMPS_FILES set filebody=null where dump_id in (select dump_id from AWRDUMPS where proj_id=p_proj_id);
	update AWRDUMPS set status='COMPRESSED' where dump_id in (select dump_id from AWRDUMPS where proj_id=p_proj_id);
	update awrtoolproject set proj_status='COMPRESSED' where proj_id=p_proj_id;
  end;
  
  procedure del_report(p_report_id awrcomp_reports.report_id%type)
  is
  begin
    delete from awrcomp_reports where report_id=p_report_id;
  end;
end awrtools_api;
/