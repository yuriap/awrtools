create or replace package body awrtools_loc_utils as

    procedure save_dump(p_blob blob, p_filename varchar2, p_dir varchar2)
    is
      l_file      UTL_FILE.FILE_TYPE;
      l_buffer    RAW(32767);
      l_amount    BINARY_INTEGER := 32767;
      l_pos       INTEGER := 1;
      l_blob_len  INTEGER;
    BEGIN
      l_blob_len := DBMS_LOB.getlength(p_blob);

      -- Open the destination file.
      --l_file := UTL_FILE.fopen('BLOBS','MyImage.gif','w', 32767);
      l_file := UTL_FILE.fopen(p_dir,p_filename,'wb', 32767);

      -- Read chunks of the BLOB and write them to the file
      -- until complete.
      WHILE l_pos < l_blob_len LOOP
        DBMS_LOB.read(p_blob, l_amount, l_pos, l_buffer);
        UTL_FILE.put_raw(l_file, l_buffer, TRUE);
        l_pos := l_pos + l_amount;
      END LOOP;

      -- Close the file.
      UTL_FILE.fclose(l_file);

    EXCEPTION
      WHEN OTHERS THEN
        -- Close the file if something goes wrong.
        IF UTL_FILE.is_open(l_file) THEN
          UTL_FILE.fclose(l_file);
        END IF;
        RAISE;
    END;

    procedure remove_dump(p_filename varchar2, p_dir varchar2)
    is
    begin
      UTL_FILE.FREMOVE (
       location => p_dir,
       filename => p_filename);
    end;

    procedure remote_awr_load(p_stg_user varchar2,
                              p_stg_tablespace varchar2,
                              p_stg_temp varchar2,
                              p_dir varchar2,
                              p_dmpfile varchar2,
                              p_dbid out number,
                              p_min_snap_id out number,
                              p_max_snap_id out number,
                              p_min_snap_dt out timestamp,
                              p_max_snap_dt out timestamp,
                              p_db_description out varchar2)
    is
    begin
      delete from awrdumps_rem;
      commit;
      awrtools_rem_utils_rem.awr_load (
          P_STG_USER => P_STG_USER,
          P_STG_TABLESPACE => P_STG_TABLESPACE,
          P_STG_TEMP => P_STG_TEMP,
          P_DIR => P_DIR,
          P_DMPFILE => P_DMPFILE) ;
      select
          DBID,MIN_SNAP_ID,MAX_SNAP_ID,MIN_SNAP_DT,MAX_SNAP_DT,DB_DESCRIPTION
          into p_dbid,p_min_snap_id,p_max_snap_id,p_min_snap_dt,p_max_snap_dt,p_db_description
        from awrdumps_rem;
      delete from awrdumps_rem;
    end;

    procedure awr_load(p_stg_user varchar2,
                       p_stg_tablespace varchar2,
                       p_stg_temp varchar2,
                       p_dir varchar2,
                       p_dmpfile varchar2,
                       p_dbid out number,
                       p_min_snap_id out number,
                       p_max_snap_id out number,
                       p_min_snap_dt out timestamp,
                       p_max_snap_dt out timestamp,
                       p_db_description out varchar2)
    is
    --awr staging
      l_user number;
      l_cnt number;
    begin
      select count(1) into l_user from dba_users where username=upper(p_stg_user);
      if l_user=1 then execute immediate 'drop user '||p_stg_user||' cascade'; end if;

      execute immediate
        'create user '||p_stg_user||'
          identified by '||p_stg_user||'
          default tablespace '||p_stg_tablespace||'
          temporary tablespace '||p_stg_temp;

      execute immediate 'alter user '||p_stg_user||' quota unlimited on '||p_stg_tablespace;
      /* call PL/SQL routine to load the data into the staging schema */
      sys.dbms_swrf_internal.awr_load(schname  => upper(p_stg_user),
                                  dmpfile  => p_dmpfile,
                                  dmpdir   => p_dir);

      execute immediate 'SELECT
        min(snap_id),max(snap_id),
        min(end_interval_time),max(end_interval_time),
        min(dbid)
        FROM '||p_stg_user||'.wrm$_snapshot'
        into
        p_min_snap_id,p_max_snap_id,
        p_min_snap_dt,p_max_snap_dt,p_dbid;

      --check already loaded snapshots
      with rng as (select p_min_snap_id+level-1 snaps from dual connect by level <=p_max_snap_id-p_min_snap_id+1)
      select count(1) into l_cnt from DBA_HIST_SNAPSHOT where dbid=p_dbid and snap_id in (select snaps from rng);

      if l_cnt=0 then

        execute immediate q'[
        select unique version || ', ' || host_name || ', ' || platform_name
          from ]'||p_stg_user||q'[.WRM$_DATABASE_INSTANCE i,
               ]'||p_stg_user||q'[.wrm$_snapshot sn
         where i.dbid = sn.dbid]'
         into p_db_description;

        sys.dbms_swrf_internal.move_to_awr(schname => upper(p_stg_user));
        sys.dbms_swrf_internal.clear_awr_dbid;

      end if;

      execute immediate 'drop user '||p_stg_user||' cascade';

      if l_cnt>0 then
        raise_application_error(-20000,'Some snapshots are already loaded for DBID: '||p_dbid||' and snapshot range: '||p_min_snap_id||'-'||p_max_snap_id);
      end if;
    end;

    procedure unload_dump(p_is_remote varchar2, p_snap_min number, p_snap_max number, p_dbid number)
    is
    begin
      if p_is_remote='YES' then
        awrtools_rem_utils_rem.drop_snapshot_range(low_snap_id => p_snap_min,high_snap_id => p_snap_max,dbid => p_dbid);
      else
        dbms_workload_repository.drop_snapshot_range(low_snap_id => p_snap_min,high_snap_id => p_snap_max,dbid => p_dbid);
      end if;
    end;
    
    procedure p(p_msg varchar2) is begin htp.p(p_msg); end;    
    procedure print_text_as_table(p_text clob, p_t_header varchar2, p_width number, p_search varchar2 default null, p_replacement varchar2 default null, p_comparison boolean default false) is
      l_line varchar2(32765);  l_eof number;  l_iter number; l_length number;
      l_text clob;
      l_style1 varchar2(10) := 'awrc1';
      l_style2 varchar2(10) := 'awrnc1';
      
      l_style_comp1 varchar2(10) := 'awrcc1';
      l_style_comp2 varchar2(10) := 'awrncc1';  
  
      l_pref varchar2(10) := 'z';
    begin
             
      p(HTF.TABLEOPEN(cborder=>0,cattributes=>'width="'||p_width||'" class="tdiff" summary="'||p_t_header||'"'));
      if p_t_header<>'#FIRST_LINE#' then
        p(HTF.TABLEROWOPEN);
        p(HTF.TABLEHEADER(cvalue=>replace(p_t_header,' ','&nbsp;'),calign=>'left',cattributes=>'class="awrbg" scope="col"'));
        p(HTF.TABLEROWCLOSE);
      end if;
  
      if instr(p_text,chr(10))=0 then
        l_iter := 1;
        l_length:=dbms_lob.getlength(p_text);
        loop
          l_text := l_text||substr(p_text,l_iter,200)||chr(10);
          l_iter:=l_iter+200;
          exit when l_iter>=l_length;
        end loop;
      else
        l_text := p_text||chr(10);
      end if;
  
      l_iter := 1; 
      loop
        l_eof:=instr(l_text,chr(10));
        l_line:=substr(l_text,1,l_eof);
    
        if p_t_header='#FIRST_LINE#' and l_iter = 1 then
          p(HTF.TABLEROWOPEN);
          p(HTF.TABLEHEADER(cvalue=>replace(l_line,' ','&nbsp;'),calign=>'left',cattributes=>'class="awrbg" scope="col"'));
          p(HTF.TABLEROWCLOSE);
        else
          p(HTF.TABLEROWOPEN);
      
          if p_comparison and substr(l_line,1,3)='~~*' then
            l_pref:=substr(l_line,1,7); 
            l_line:=substr(l_line,8);
            l_pref:=substr(l_pref,4,1);
          end if;
      
          if p_search is not null and regexp_instr(l_line,p_search)>0 then
            l_line:=REGEXP_REPLACE(l_line,p_search,p_replacement);
          else
            l_line:=replace(l_line,' ','&nbsp;');
          end if;
	      l_line:=replace(l_line,'`',' ');
          if p_comparison and l_pref in ('-') then
            p(HTF.TABLEDATA(cvalue=>l_line,calign=>'left',cattributes=>'class="'|| case when mod(l_iter,2)=0 then l_style_comp1 else l_style_comp2 end ||'"'));
          else
            p(HTF.TABLEDATA(cvalue=>l_line,calign=>'left',cattributes=>'class="'|| case when mod(l_iter,2)=0 then l_style1 else l_style2 end ||'"'));
          end if;
      
          p(HTF.TABLEROWCLOSE);
        end if;
        l_text:=substr(l_text,l_eof+1);  l_iter:=l_iter+1;
        exit when l_iter>10000 or dbms_lob.getlength(l_text)=0;
      end loop;

      p(HTF.TABLECLOSE);
    end;    
    
    function get_search_query_local(p_startsearch varchar2, p_search_type varchar2, p_search_condition varchar2) return varchar2
    is
      l_sql varchar2(32767):=q'[select dbid,sql_id,sql_text,proj_id,proj_name, min(dump_id)dump_id 
from (
SELECT 
    t.dbid,
    t.sql_id,
    cast(substr(t.sql_text,1,4000) as varchar2(4000)) sql_text,
    p.proj_id,
    p.proj_name,
    d.dump_id
FROM
    dba_hist_sqltext t,
    dba_hist_sqlstat s,
    awrdumps d,
    awrtoolproject p
  where 1=2 ) group by dbid,sql_id,sql_text,proj_id,proj_name]'; --default query
    begin
      if p_startsearch='YES' then
        case 
          when p_search_type='SQLTEXT' then
            l_sql := q'[select dbid,sql_id,sql_text,proj_id,proj_name, min(dump_id)dump_id 
from (
SELECT 
    t.dbid,
    t.sql_id,
    cast(substr(t.sql_text,1,4000) as varchar2(4000)) sql_text,
    p.proj_id,
    p.proj_name,
    d.dump_id
FROM
    (select * from dba_hist_sqltext
     where ]'|| case when p_search_condition is null then '1=2' else p_search_condition end ||
     q'[) t,
    dba_hist_sqlstat s,
    awrdumps d,
    awrtoolproject p
WHERE
    t.dbid = s.dbid (+)
    AND   t.sql_id = s.sql_id (+)
    AND   s.snap_id BETWEEN d.min_snap_id (+) AND d.max_snap_id (+)
    AND   s.dbid= d.dbid(+)
    AND   d.is_remote(+)='NO'
    AND   d.proj_id = p.proj_id (+) 
    AND   d.STATUS(+) in ('AWRLOADED','COMPRESSED')
) group by dbid,sql_id,sql_text,proj_id,proj_name]';

          when p_search_type='SQLSTAT' then
            l_sql := q'[select dbid,sql_id,sql_text,proj_id,proj_name, min(dump_id)dump_id 
from (
SELECT 
    t.dbid,
    t.sql_id,
    cast(substr(t.sql_text,1,4000) as varchar2(4000)) sql_text,
    p.proj_id,
    p.proj_name,
    d.dump_id
FROM
    dba_hist_sqltext t,
    (select * from dba_hist_sqlstat where ]' || case when p_search_condition is null then '1=2' else p_search_condition end ||
    q'[)s,
    awrdumps d,
    awrtoolproject p
WHERE
    t.dbid = s.dbid
    AND   t.sql_id = s.sql_id
    AND   s.snap_id BETWEEN d.min_snap_id AND d.max_snap_id
    AND   s.dbid= d.dbid
    AND   d.is_remote='NO'
    AND   d.proj_id = p.proj_id
    AND   d.STATUS in ('AWRLOADED','COMPRESSED') 
) group by dbid,sql_id,sql_text,proj_id,proj_name]';  

          when p_search_type='ASH' then    
            l_sql := q'[select dbid,sql_id,sql_text,proj_id,proj_name, min(dump_id)dump_id 
from (
SELECT 
    t.dbid,
    t.sql_id,
    cast(substr(t.sql_text,1,4000) as varchar2(4000)) sql_text,
    p.proj_id,
    p.proj_name,
    d.dump_id
FROM
    dba_hist_sqltext t,
    (select * from dba_hist_active_sess_history where ]' || case when p_search_condition is null then '1=2' else p_search_condition end ||
    q'[)s,
    awrdumps d,
    awrtoolproject p
WHERE
    t.dbid = s.dbid
    AND   t.sql_id = s.sql_id
    AND   s.snap_id BETWEEN d.min_snap_id AND d.max_snap_id
    AND   s.dbid= d.dbid
    AND   d.is_remote='NO'
    AND   d.proj_id = p.proj_id
    AND   d.STATUS in ('AWRLOADED','COMPRESSED') 
) group by dbid,sql_id,sql_text,proj_id,proj_name]';  
        else
          null;
        end case;
      end if;
      return l_sql;
    end;    
    function get_search_query_remote(p_startsearch varchar2, p_search_type varchar2, p_search_condition varchar2, p_sourcedb varchar2, p_sourcetab varchar2) return varchar2
    is
      l_sql varchar2(32767):=q'[SELECT unique
    sql_id,
    cast(substr(sql_text,1,4000) as varchar2(4000)) sql_text
FROM
    <SOURCE_TABLE>]'; --default query
    begin
      if p_startsearch='YES' then
        if p_sourcetab = 'AWR' then
          case 
            when p_search_type='SQLTEXT' then 
              l_sql:=replace(l_sql,'<SOURCE_TABLE>','(select sql_id, sql_text from dba_hist_sqltext@'||p_sourcedb||'  where '||nvl(p_search_condition,'1=2')||')');
            when p_search_type='SQLSTAT' then
              l_sql:=replace(l_sql,'<SOURCE_TABLE>',q'[(select s.sql_id, nvl(t.sql_text,'<UNAVAILABLE>') sql_text from dba_hist_sqltext@]'||p_sourcedb||' t, (select * from dba_hist_sqlstat@'||p_sourcedb||'  where '||nvl(p_search_condition,'1=2')||') s where t.dbid(+)=s.dbid and t.sql_id(+)=s.sql_id)');
            when p_search_type='ASH' then
              l_sql:=replace(l_sql,'<SOURCE_TABLE>',q'[(select s.sql_id, nvl(t.sql_text,'<UNAVAILABLE>') sql_text from dba_hist_sqltext@]'||p_sourcedb||' t, (select * from dba_hist_active_sess_history@'||p_sourcedb||'  where '||nvl(p_search_condition,'1=2')||') s where t.dbid(+)=s.dbid and t.sql_id(+)=s.sql_id)');            
          else
            null;
          end case;
        elsif p_sourcetab = 'V$VIEW' then
          case 
            when p_search_type='SQLTEXT' or p_search_type='SQLSTAT' then 
              l_sql:=replace(l_sql,'<SOURCE_TABLE>','(select sql_id, sql_text from gv$sql@'||p_sourcedb||'  where '||nvl(p_search_condition,'1=2')||')');
            when p_search_type='ASH' then
              l_sql:=replace(l_sql,'<SOURCE_TABLE>',q'[(select s.sql_id, nvl(t.sql_text,'<UNAVAILABLE>') sql_text from gv$sql@]'||p_sourcedb||' t, (select * from gv$active_session_history@'||p_sourcedb||'  where '||nvl(p_search_condition,'1=2')||') s where t.sql_id(+)=s.sql_id)');            
          else
            null;
          end case;
        end if;
      end if;
      return replace(l_sql,'<SOURCE_TABLE>','dba_hist_sqltext where 1=2 ');
    end;

end;
/