create or replace package body awrtools_api as

  procedure archive_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type);
  procedure compress_project(p_proj_id awrtoolproject.proj_id%type);

  procedure add_project(p_proj_name awrtoolproject.proj_name%type,
                        p_proj_descr awrtoolproject.proj_description%type,
                        p_proj_id out AWRTOOLPROJECT.PROJ_ID%type) as
  begin
    INSERT INTO awrtoolproject (
      proj_name,
      proj_date,
      proj_description)
    VALUES
     (p_proj_name,default,p_proj_descr)
    returning proj_id into p_proj_id;
    awrtools_contr.lcc_project_exec_action(p_proj_id,awrtools_contr.c_project_create);
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
    archive_project(p_proj_id);
    delete from awrtoolproject where proj_id=p_proj_id;
  end del_project;

  procedure lock_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type)is
  begin
    awrtools_contr.lcc_project_exec_action(p_proj_id,awrtools_contr.c_project_lock);
  end;

  procedure unlock_project(p_proj_id AWRTOOLPROJECT.PROJ_ID%type)is
  begin
    awrtools_contr.lcc_project_exec_action(p_proj_id,awrtools_contr.c_project_unlock);
  end;

  procedure archive_project(p_proj_id awrtoolproject.proj_id%type) as
  begin
    for i in (select * from AWRDUMPS where proj_id=p_proj_id and status in (awrtools_contr.c_dumpstate_awrloaded,awrtools_contr.c_dumpstate_compressed)) loop
      unload_dump(i.dump_id);
    end loop;
  end archive_project;

  procedure compress_project(p_proj_id awrtoolproject.proj_id%type) as
  begin
    for i in (select * from AWRDUMPS where proj_id=p_proj_id) loop
      del_file(i.dump_id);
    end loop;
  end;

  procedure del_report(p_report_id awrcomp_reports.report_id%type)
  is
  begin
    delete from awrcomp_reports where report_id=p_report_id;
  end;

  function getconf(p_key varchar2) return varchar2 RESULT_CACHE
  is
    l_res awrconfig.cvalue%type;
  begin
    select cvalue into l_res from awrconfig where ckey=p_key;
    return l_res;
  end;

  function getscript(p_script_id varchar2) return clob
  is
    l_res clob;
  begin
    select script_content into l_res from AWRCOMP_SCRIPTS where script_id=p_script_id;
    return l_res;
  exception
    when no_data_found then raise_application_error(-20000,'Script "'||p_script_id||'" not found.');
  end;

  procedure create_new_dump_i(p_proj_id AWRDUMPS.proj_id%type,
                              p_filename AWRDUMPS.filename%type,
                              p_dump_description AWRDUMPS.dump_description%type,
                              p_filebody AWRDUMPS_FILES.filebody%type,
                              p_dump_id out AWRDUMPS.dump_id%type)
  is
  begin
    INSERT INTO awrdumps (proj_id, filename, dump_description) VALUES (p_proj_id, p_filename, p_dump_description)
    returning dump_id into p_dump_id;
    awrtools_contr.lcc_dump_exec_action(p_dump_id,awrtools_contr.c_dump_create);
    INSERT INTO awrdumps_files (dump_id, filebody) VALUES (p_dump_id, p_filebody);
    awrtools_contr.lcc_dump_exec_action(p_dump_id,awrtools_contr.c_dump_loadfile);
  end;

  procedure create_new_dump(p_proj_id AWRDUMPS.proj_id%type,
                            p_filename AWRDUMPS.filename%type,
                            p_dump_description AWRDUMPS.dump_description%type,
                            p_filebody AWRDUMPS_FILES.filebody%type)
  is
    l_dump_id number;
  begin
    create_new_dump_i(p_proj_id,p_filename,p_dump_description,p_filebody,l_dump_id);
  end;

   procedure load_dump_from_file(p_proj_id AWRDUMPS.proj_id%type,
                                 p_filename AWRDUMPS.filename%type,
                                 p_dump_description AWRDUMPS.dump_description%type,
                                 p_loading_date AWRDUMPS.loading_date%type default null,
                                 p_dbid AWRDUMPS.dbid%type default null,
                                 p_min_snap_id AWRDUMPS.min_snap_id%type default null,
                                 p_max_snap_id AWRDUMPS.max_snap_id%type default null,
                                 p_min_snap_dt AWRDUMPS.min_snap_dt%type default null,
                                 p_max_snap_dt AWRDUMPS.max_snap_dt%type default null,
                                 p_db_description AWRDUMPS.db_description%type default null)
   is
     l_filebody AWRDUMPS_FILES.filebody%type;
     l_d_off number := 1;
     l_s_off number := 1;
     l_bfile bfile := BFILENAME(awrtools_api.getconf('WORKDIR'), p_filename);
     l_dump_id number;
   begin
     DBMS_LOB.CREATETEMPORARY(l_filebody, false);
     DBMS_LOB.fileopen(l_bfile, DBMS_LOB.file_readonly);
     DBMS_LOB.LOADBLOBFROMFILE (
       dest_lob    => l_filebody,
       src_bfile   => l_bfile,
       amount      => DBMS_LOB.LOBMAXSIZE,
       dest_offset => l_d_off,
       src_offset  => l_s_off);

     create_new_dump_i(p_proj_id,p_filename,p_dump_description,l_filebody,l_dump_id);
     DBMS_LOB.FILECLOSE (l_bfile);
     
     UPDATE awrdumps SET
       loading_date = p_loading_date,
       dbid = p_dbid,
       min_snap_id = p_min_snap_id,
       max_snap_id = p_max_snap_id,
       min_snap_dt = p_min_snap_dt,
       max_snap_dt = p_max_snap_dt,
       db_description = p_db_description
     WHERE dump_id =l_dump_id;
   end;

  procedure load_dump_into_repo(p_dump_id awrdumps.dump_id%type, p_dest varchar2) is
    l_dbid number;
    l_min_snap_id number;
    l_max_snap_id number;
    l_min_snap_dt timestamp(3);
    l_max_snap_dt timestamp(3);
    l_db_description awrdumps.db_description%type;
  begin
    for i in (select proj_id,filebody,filename
                from awrdumps a,awrdumps_files b
               where a.dump_id=b.dump_id and a.dump_id=p_dump_id)
    loop
      awrtools_loc_utils.save_dump(i.filebody,i.filename,awrtools_api.getconf('WORKDIR'));
      if p_dest='REM' then
        awrtools_loc_utils.remote_awr_load(p_stg_user => awrtools_api.getconf('AWRSTGUSER'),
          p_stg_tablespace => awrtools_api.getconf('AWRSTGTBLSPS'),
          p_stg_temp => awrtools_api.getconf('AWRSTGTMP'),
          p_dir => awrtools_api.getconf('WORKDIR'),
          p_dmpfile => substr(i.filename,1,instr(i.filename,'.',-1)-1),
          p_dbid=>l_dbid,
          p_min_snap_id=>l_min_snap_id,
          p_max_snap_id=>l_max_snap_id,
          p_min_snap_dt=>l_min_snap_dt,
          p_max_snap_dt=>l_max_snap_dt,
          p_db_description=>l_db_description);
      else
        awrtools_loc_utils.awr_load(p_stg_user => awrtools_api.getconf('AWRSTGUSER'),
          p_stg_tablespace => awrtools_api.getconf('AWRSTGTBLSPS'),
          p_stg_temp => awrtools_api.getconf('AWRSTGTMP'),
          p_dir => awrtools_api.getconf('WORKDIR'),
          p_dmpfile => substr(i.filename,1,instr(i.filename,'.',-1)-1),
          p_dbid=>l_dbid,
          p_min_snap_id=>l_min_snap_id,
          p_max_snap_id=>l_max_snap_id,
          p_min_snap_dt=>l_min_snap_dt,
          p_max_snap_dt=>l_max_snap_dt,
          p_db_description=>l_db_description);
      end if;
      update awrdumps set
        dbid=l_dbid,
        min_snap_id=l_min_snap_id,
        max_snap_id=l_max_snap_id,
        min_snap_dt=l_min_snap_dt,
        max_snap_dt=l_max_snap_dt,
        db_description=l_db_description,
        is_remote=decode(p_dest,'REM','YES','NO')
       where dump_id=p_dump_id;
      awrtools_contr.lcc_dump_exec_action(p_dump_id,awrtools_contr.c_dump_load2awr);
      awrtools_contr.lcc_project_exec_action(i.proj_id,awrtools_contr.c_project_analyze);
      awrtools_loc_utils.remove_dump(i.filename,awrtools_api.getconf('WORKDIR'));
    end loop;
  end;

  procedure unload_dump(p_dump_id awrdumps.dump_id%type)
  is
  begin
    for i in (select * from awrdumps where dump_id=p_dump_id)
    loop
      awrtools_loc_utils.unload_dump(i.is_remote,i.MIN_SNAP_ID,i.MAX_SNAP_ID,i.DBID);
      awrtools_contr.lcc_dump_exec_action(p_dump_id,awrtools_contr.c_dump_unloadawr);
    end loop;
  end;

  procedure del_file(p_dump_id awrdumps.dump_id%type)
  is
  begin
    update AWRDUMPS_FILES set filebody=null where dump_id=p_dump_id;
    awrtools_contr.lcc_dump_exec_action(p_dump_id,awrtools_contr.c_dump_removefile);
  end;

end awrtools_api;
/