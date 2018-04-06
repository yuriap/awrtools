create or replace PACKAGE AWRTOOLS_REMOTE_ANALYTICS AS

  type t_output_lines is table of varchar2(32767) index by pls_integer;

  procedure load_data_cube(p_sess_id out number, 
                           p_source varchar2, 
                           p_dblink varchar2, 
                           p_agg varchar2, 
                           p_inst_id number, 
                           p_start_dt date, 
                           p_end_dt date, 
                           p_filter varchar2, 
                           p_dump_id number default null,
                           p_metric_id number default null,
                           p_metricgroup_id number default null,
                           p_aggr_func varchar2 default null);
  procedure AWRTOOL_CLEANUP_ASHSESS;
  procedure AWRTOOL_CLEANUP_RPT;

  --creating report content
  procedure getplanh(p_sql_id varchar2, p_dblink varchar2, p_id in number);
  procedure getplanawrh(p_sql_id varchar2, p_dblink varchar2, p_id in number);

  --getting already created report content
  procedure getreport(p_id in number, p_report out t_output_lines);


END AWRTOOLS_REMOTE_ANALYTICS;
/

create or replace PACKAGE BODY AWRTOOLS_REMOTE_ANALYTICS AS

  g_min number;
  g_max number;

  procedure AWRTOOL_CLEANUP_ASHSESS
  is
  begin
    delete from remote_ash_sess where sess_created < (systimestamp - 1/24);
    dbms_output.put_line('Deleted '||sql%rowcount||' session(s).');
    commit;
  exception
    when others then rollback;dbms_output.put_line(sqlerrm);
  end;

  procedure AWRTOOL_CLEANUP_RPT
  is
  begin
    delete from AWRTOOLS_ONLINE_RPT where ts < (systimestamp - 1/24);
    dbms_output.put_line('Deleted '||sql%rowcount||' report(s).');
    commit;
  exception
    when others then rollback;dbms_output.put_line(sqlerrm);
  end;

  procedure load_data_cube(p_sess_id out number,
                           p_source varchar2,
                           p_dblink varchar2,
                           p_agg varchar2,
                           p_inst_id number,
                           p_start_dt date,
                           p_end_dt date,
                           p_filter varchar2,
                           p_dump_id number default null,
                           p_metric_id number default null,
                           p_metricgroup_id number default null,
                           p_aggr_func varchar2 default null)
  is
    l_dbid number;
    l_min_snap number;
    l_max_snap number;
    l_int_size number;
    
    l_sql_template varchar2(32765):=
q'[INSERT INTO REMOTE_ASH (sess_id, sample_time, wait_class, sql_id, event, module, action, sql_plan_hash_value, event_id, sec)
   SELECT   :P_SESS_ID, <GROUPBY_COL>, NVL(WAIT_CLASS,'CPU'),SQL_ID,EVENT,MODULE,ACTION,SQL_PLAN_HASH_VALUE,nvl(EVENT_ID,-1), COUNT(1)
     FROM   <SOURCE_TABLE>
    WHERE   <DBID>
      AND   <INSTANCE_NUMBER> = :P_INST_ID
      AND   <SNAP_FILTER>
      AND   SAMPLE_TIME BETWEEN :P_START_DT AND :P_END_DT
      AND   <FILTER>
    GROUP BY  <GROUPBY_COL>, NVL(WAIT_CLASS,'CPU'), SQL_ID, EVENT, MODULE, ACTION, SQL_PLAN_HASH_VALUE, EVENT_ID]';
    l_sql varchar2(32765);

    l_sql_template_metrics varchar2(32765):=
q'[insert into remote_metrics (sess_id, metric_id, end_time, value)
   select   :P_SESS_ID, metric_id, <GROUPBY_COL>, <AGGFNC>(value)
     from   <SOURCE_TABLE>
    where   <DBID>
      AND   <INSTANCE_NUMBER> = :P_INST_ID
      AND   <SNAP_FILTER>
      AND   end_time BETWEEN :P_START_DT AND :P_END_DT
      and   metric_id = :P_METRIC_ID
      and   group_id=:p_metricgroup_id
    group by <GROUPBY_COL>, metric_id]';
  begin
    insert into remote_ash_sess values (default, default) returning sess_id into p_sess_id;

    if p_dblink <> '$LOCAL$' then
      if p_source = 'AWR' then
        execute immediate 'select dbid from v$database@'||p_dblink into l_dbid;
        execute immediate 'select min(snap_id)
            from dba_hist_snapshot@'||p_dblink||'
           where end_interval_time>=:P_START_DT
             and dbid=:P_DBID
             and instance_number=:P_INST_ID' into l_min_snap using p_start_dt, l_dbid, p_inst_id;
        execute immediate 'select min(snap_id)
            from dba_hist_snapshot@'||p_dblink||'
           where end_interval_time>=:P_END_DT
             and dbid=:P_DBID
             and instance_number=:P_INST_ID' into l_max_snap using p_end_dt, l_dbid, p_inst_id;
        if l_max_snap is null then
          execute immediate 'select max(snap_id)
              from dba_hist_snapshot@'||p_dblink||'
             where dbid=:P_DBID
               and instance_number=:P_INST_ID' into l_max_snap using l_dbid, p_inst_id;
        end if;
      end if;
    else
      SELECT
             dbid,
             min_snap_id,
             max_snap_id
        into l_dbid, l_min_snap, l_max_snap
        FROM awrdumps d, AWRTOOLPROJECT p
       where dump_id=p_dump_id and d.proj_id=p.proj_id;
    end if;

    l_sql := replace(replace(replace(replace(replace(l_sql_template,
                                                          '<SOURCE_TABLE>',case
                                                                             when p_source = 'V$VIEW' then case when p_dblink = '$LOCAL$' then 'gv$active_session_history'
                                                                                                          else 'gv$active_session_history@'||p_dblink
                                                                                                          end
                                                                             when p_source = 'AWR' then case when p_dblink = '$LOCAL$' then 'dba_hist_active_sess_history'
                                                                                                        else 'dba_hist_active_sess_history@'||p_dblink
                                                                                                        end
                                                                           end),
                                                  '<DBID>',case when p_source = 'V$VIEW' then ':P_DBID is null' else 'DBID = :P_DBID' end),
                                          '<INSTANCE_NUMBER>',case when p_source = 'V$VIEW' then 'INST_ID' else 'INSTANCE_NUMBER' end),
                                  '<SNAP_FILTER>',case when p_source = 'AWR' then 'SNAP_ID BETWEEN :P_MIN_SNAP AND :P_MAX_SNAP' else ':P_MIN_SNAP is null and :P_MAX_SNAP is null' end),
                          '<FILTER>',nvl(p_filter,'1=1'));
    case
      when p_agg = 'no_agg'  then
        l_sql := replace(l_sql,'<GROUPBY_COL>','sample_time');
      when p_agg = 'by_mi'   then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(sample_time,'mi')]');
      when p_agg = 'by_hour' then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(sample_time,'hh')]');
      when p_agg = 'by_day'  then
        l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(sample_time,'dd')]');
      else
        null;
    end case;
/*
    awrtools_logging.log(l_sql);
    awrtools_logging.log('p_sess_id:'||p_sess_id);
    awrtools_logging.log('l_dbid:'||l_dbid);
    awrtools_logging.log('p_inst_id:'||p_inst_id);
    awrtools_logging.log('l_min_snap:'||l_min_snap);
    awrtools_logging.log('l_max_snap:'||l_max_snap);
    awrtools_logging.log('p_start_dt:'||p_start_dt);
    awrtools_logging.log('p_end_dt:'||p_end_dt);
*/
    begin
      execute immediate l_sql using p_sess_id, l_dbid, p_inst_id, l_min_snap, l_max_snap, p_start_dt, p_end_dt;
    exception
      when others then
        raise_application_error(-20000,sqlerrm);
    end;
    --commit;
    --dbms_stats.gather_table_stats(ownname=> sys_context('USERENV','CURRENT_USER'), tabname=>'remote_ash', cascade=>true);
    
    if p_agg = 'no_agg' then
      insert /* append */ into remote_ash_timeline select unique p_sess_id, sample_time from remote_ash where sess_id = p_sess_id;
    else
      if p_agg = 'by_mi' then
        insert /* append */ into remote_ash_timeline 
          select p_sess_id,
                 trunc(p_start_dt,'mi')+(level-1)/24/60 from dual connect by level <=round((p_end_dt-trunc(p_start_dt,'mi'))*24*60)+1;
      end if;
      if p_agg = 'by_hour' then
        insert /* append */ into remote_ash_timeline 
          select p_sess_id,
                 trunc(p_start_dt,'hh')+(level-1)/24 from dual connect by level <=round((p_end_dt-trunc(p_start_dt,'hh'))*24)+1;
      end if;
      if p_agg = 'by_day' then
        insert /* append */ into remote_ash_timeline 
          select p_sess_id,
                 trunc(p_start_dt)+(level-1) from dual connect by level <=round(p_end_dt-trunc(p_start_dt))+1;
      end if;      
    end if;

    if p_metric_id is not null then
      l_sql := replace(replace(replace(replace(replace(l_sql_template_metrics,
                                                            '<SOURCE_TABLE>',case
                                                                               when p_source = 'V$VIEW' then case when p_dblink = '$LOCAL$' then 'gv$sysmetric_history'
                                                                                                            else 'gv$sysmetric_history@'||p_dblink
                                                                                                            end
                                                                               when p_source = 'AWR' then case when p_dblink = '$LOCAL$' then 'dba_hist_sysmetric_history'
                                                                                                          else 'dba_hist_sysmetric_history@'||p_dblink
                                                                                                          end
                                                                             end),
                                                    '<DBID>',case when p_source = 'V$VIEW' then ':P_DBID is null' else 'DBID = :P_DBID' end),
                                            '<INSTANCE_NUMBER>',case when p_source = 'V$VIEW' then 'INST_ID' else 'INSTANCE_NUMBER' end),
                                    '<SNAP_FILTER>',case when p_source = 'AWR' then 'SNAP_ID BETWEEN :P_MIN_SNAP AND :P_MAX_SNAP' else ':P_MIN_SNAP is null and :P_MAX_SNAP is null' end),
                            '<AGGFNC>',p_aggr_func);
      select interval_size into l_int_size from V$METRICGROUP where group_id = p_metricgroup_id;
      case
        when p_agg = 'no_agg'  then
          l_sql := replace(l_sql,'<GROUPBY_COL>','end_time');
        when p_agg = 'by_mi'   then
          if l_int_size<6000 then
            l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(end_time,'mi')]');
          else
            l_sql := replace(l_sql,'<GROUPBY_COL>','end_time');
          end if;
        when p_agg = 'by_hour' then
          if l_int_size<360000 then
            l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(end_time,'hh')]');
          else
            l_sql := replace(l_sql,'<GROUPBY_COL>','end_time');
          end if;
        when p_agg = 'by_day'  then
          l_sql := replace(l_sql,'<GROUPBY_COL>',q'[trunc(end_time,'dd')]');
        else
          null;
      end case;
/*
    awrtools_logging.log(l_sql);
    awrtools_logging.log('p_sess_id:'||p_sess_id);
    awrtools_logging.log('l_dbid:'||l_dbid);
    awrtools_logging.log('p_inst_id:'||p_inst_id);
    awrtools_logging.log('l_min_snap:'||l_min_snap);
    awrtools_logging.log('l_max_snap:'||l_max_snap);
    awrtools_logging.log('p_start_dt:'||p_start_dt);
    awrtools_logging.log('p_end_dt:'||p_end_dt);
    awrtools_logging.log('p_metric_id:'||p_metric_id);
    awrtools_logging.log('p_aggr_func:'||p_aggr_func);
*/
      begin
        execute immediate l_sql using p_sess_id, l_dbid, p_inst_id, l_min_snap, l_max_snap, p_start_dt, p_end_dt, p_metric_id, p_metricgroup_id;
      exception
        when others then
          raise_application_error(-20000,sqlerrm);
      end;
    end if;

    commit;
    --dbms_stats.gather_table_stats(ownname=> sys_context('USERENV','CURRENT_USER'), tabname=>'remote_ash_timeline', cascade=>true);
  end;

  procedure execute_plsql_remotelly(p_sql varchar2, p_dblink varchar2, p_output out clob, p_is_output boolean default true)
  is
    l_theCursor     integer;
    l_status        integer;
    l_line          varchar2(32767);
    l_output        varchar2(32767);
    l_open          boolean;
    l_sql2exec      varchar2(32767);
    l_sql clob:=
q'[declare
l_out clob; l_len number;
l_chunk varchar2(32767);
l_status integer;
l_pos number;
l_chunk_length number := 32767;
l_r raw(32767);
l_rc raw(32767);
begin
DBMS_OUTPUT.ENABLE(NULL);
<PLSQL_BLOCK>
]'||
case when p_is_output then
q'[loop
  DBMS_OUTPUT.GET_LINE(l_chunk,l_status);
  exit when l_status=1;
  l_out:=l_out||l_chunk||chr(10);
end loop;
if l_out is null then l_out:='No data found.';end if;
l_pos:=1;l_len:=length(l_out);
loop
  l_chunk:=substr(l_out,l_pos,l_chunk_length);
  l_pos:=l_pos+l_chunk_length;
  l_r:=utl_raw.cast_to_raw(l_chunk);
  l_rc:=UTL_COMPRESS.LZ_COMPRESS(l_r);
  dbms_output.put(l_rc);
  DBMS_OUTPUT.NEW_LINE;
  exit when l_len<l_pos;
end loop;
end;]'
else q'[end;]' end;
  begin
    l_sql:=replace(l_sql,'<PLSQL_BLOCK>',p_sql);
    if length(l_sql) > 32767 then raise_application_error(-20000,'SQL <'||substr(l_sql,1,100)||'...> too long for remote table printing.');end if;
    l_sql2exec:=l_sql;
--dbms_output.put_line(l_sql2exec);
    execute immediate 'begin :p_theCursor:=dbms_sql.open_cursor@'||p_dblink||'; end;' using out l_theCursor;
    execute immediate 'begin dbms_sql.parse@'||p_dblink||'(:p_theCursor, :p_stmt , :p_flg ); end;' using l_theCursor, l_sql2exec, dbms_sql.native;
    execute immediate 'begin :a:=dbms_sql.execute@'||p_dblink||'(:p_theCursor); end;' using out l_status, in l_theCursor;
    execute immediate 'begin dbms_sql.close_cursor@'||p_dblink||'(:p_theCursor); end;' using in out l_theCursor;
    loop
      execute immediate 'begin DBMS_OUTPUT.GET_LINE@'||p_dblink||'(line => :p_line, status => :p_status); end;' using out l_line, out l_status;
      exit when l_status=1;
      --p_output:=p_output||l_line||chr(10);
      p_output:=p_output||utl_raw.cast_to_varchar2(UTL_COMPRESS.LZ_UNCOMPRESS(l_line));
    end loop;
  exception
    when others then
       execute immediate 'begin :p_open:=dbms_sql.IS_OPEN@'||p_dblink||'(:p_theCursor); end;' using out l_open, in l_theCursor;
	  if l_open then
        execute immediate 'begin dbms_sql.close_cursor@'||p_dblink||'(:p_theCursor); end;' using in out l_theCursor;
      end if;
      awrtools_logging.log(sqlerrm);
      awrtools_logging.log(l_sql2exec);
      raise_application_error(-20000, sqlerrm||chr(10)||l_sql2exec);
  end;

  procedure execute_plsql_remotelly(p_sql varchar2, p_dblink varchar2, p_output out t_output_lines)
  is
    l_output        clob;
    l_line varchar2(32767);
    l_eof  number;
    l_iter number := 1;
    l_off  number:=1;
  begin
    execute_plsql_remotelly(p_sql, p_dblink, l_output);
    loop
      l_eof:=instr(l_output,chr(10),l_off);
      if l_eof=0 then
        p_output(l_iter):=rtrim(rtrim(substr(l_output,l_off),chr(13)),chr(10));
      else
        p_output(l_iter):=rtrim(rtrim(substr(l_output,l_off,l_eof-l_off+1),chr(13)),chr(10));
      end if;
      l_off:=1+l_eof;
      l_iter:=l_iter+1;
      exit when l_eof=0;
    end loop;
  end;

  procedure print_table_html_remotelly(p_query in varchar2,
                                       p_width number,
                                       p_summary varchar2,
                                       p_search varchar2 default null,
                                       p_replacement varchar2 default null,
                                       p_style1 varchar2 default 'awrc1',
                                       p_style2  varchar2 default 'awrnc1',
                                       p_header number default 0,
                                       p_break_col varchar2 default null,
                                       p_dblink varchar2,
                                       p_output out t_output_lines)
  is
    l_sql clob:=  q'[declare
  l_sql varchar2(32767) := q'^<SQL_QUERY>^';
  <PRN_HTML_TBL_PROC>
begin
  print_table_html(
   p_query => l_sql
   ,p_width => ]'||p_width||q'[
   ,p_summary => q'^]'||p_summary||q'[^' <p_search> <p_replacement> <p_style1> <p_style2> <p_header> <p_break_col>);
end;]';
    l_sql_to_exec varchar2(32767);
  BEGIN
    if p_dblink is null then raise_application_error(-20000, 'Parameter p_dblink must be specified'); end if;

    l_sql:=replace(replace(l_sql,'<PRN_HTML_TBL_PROC>',awrtools_api.getscript('PROC_PRNHTMLTBL')),'<SQL_QUERY>',p_query);

    if p_search is not null then l_sql:=replace(l_sql,'<p_search>',q'[,p_search => q'^]'||p_search||q'[^']'||chr(10)); else l_sql:=replace(l_sql,'<p_search>'); end if;
    if p_replacement is not null then l_sql:=replace(l_sql,'<p_replacement>',q'[,p_replacement => q'^]'||p_replacement||q'[^']'||chr(10)); else l_sql:=replace(l_sql,'<p_replacement>'); end if;
    if p_style1 is not null then l_sql:=replace(l_sql,'<p_style1>',q'[,p_style1 => q'^]'||p_style1||q'[^']'||chr(10)); else l_sql:=replace(l_sql,'<p_style1>'); end if;
    if p_style2 is not null then l_sql:=replace(l_sql,'<p_style2>',q'[,p_style2 => q'^]'||p_style2||q'[^']'||chr(10)); else l_sql:=replace(l_sql,'<p_style2>'); end if;
    if p_header is not null then l_sql:=replace(l_sql,'<p_header>',q'[,p_header => ]'||p_header||chr(10)); else l_sql:=replace(l_sql,'<p_header>'); end if;
    if p_break_col is not null then l_sql:=replace(l_sql,'<p_break_col>',q'[,p_break_col => q'^]'||p_break_col||q'[^']'||chr(10)); else l_sql:=replace(l_sql,'<p_break_col>'); end if;

    if length(L_SQL) > 32767 then raise_application_error(-20000,'SQL <'||substr(p_query,1,100)||'...> too long for remote table printing.');end if;
    --dbms_output.put_line('length(P_SQL): '||length(L_SQL));
    l_sql_to_exec:=l_sql;
    --dbms_output.put_line(l_sql_to_exec);
    AWRTOOLS_REMOTE_ANALYTICS.execute_plsql_remotelly
       (  P_SQL => l_sql_to_exec,
          P_DBLINK => P_DBLINK,
          P_OUTPUT => P_OUTPUT) ;
  END;

  procedure print_text_as_table(p_text clob, p_t_header varchar2, p_width number, p_search varchar2 default null, p_replacement varchar2 default null, p_comparison boolean default false, p_output out t_output_lines) is
    l_line varchar2(32765);  l_eof number;  l_iter number; l_length number;
    l_text clob;
    l_style1 varchar2(10) := 'awrc1';
    l_style2 varchar2(10) := 'awrnc1';

    l_style_comp1 varchar2(10) := 'awrcc1';
    l_style_comp2 varchar2(10) := 'awrncc1';

    l_pref varchar2(10) := 'z';

    l_indx   number := 1;
    procedure p(p_line varchar2) is
    begin
      p_output(l_indx):=p_line;
      l_indx := l_indx + 1;
    end;
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

  procedure prepare_script(p_script in out clob, p_sqlid varchar2, p_plsql boolean default false, p_dbid varchar2 default null, p_inst_id varchar2 default null,
                           p_start_snap number default null, p_end_snap number default null) is
    l_scr clob := p_script;
    l_line varchar2(32765);
    l_eof number;
    l_iter number := 1;
  begin
    if instr(l_scr,chr(10))=0 then
      l_scr:=l_scr||chr(10);
      --raise_application_error(-20000,'Put at least one EOL into script.');
    end if;
    --set variable
    p_script:=replace(replace(replace(replace(replace(p_script,'&SQLID.',p_sqlid),'&SQLID',p_sqlid),'&1.',p_sqlid),'&1',p_sqlid),'&VSQL.','gv$sql');
    p_script:=replace(replace(replace(replace(p_script,'&INST_ID.',p_inst_id),'&INST_ID',p_inst_id),'&DBID.',p_dbid),'&DBID',p_dbid);
    --remove sqlplus settings
    l_scr := p_script;
    p_script:=null;
    loop
      l_eof:=instr(l_scr,chr(10));
      l_line:=substr(l_scr,1,l_eof);

      if upper(l_line) like 'SET%' or
         upper(l_line) like 'COL%' or
         upper(l_line) like 'BREAK%' or
         upper(l_line) like 'ALTER SESSION%' or
         upper(l_line) like 'SERVEROUTPUT%' or
         upper(l_line) like 'REM%' or
         upper(l_line) like '--%'
      then
        null;
      else
        p_script:=p_script||l_line||chr(10);
      end if;

--      if p_dbid is not null then
--        if g_min is null or g_max is null then
--          select nvl(min(snap_id),1) , nvl(max(snap_id),1e6)  into g_min, g_max from dba_hist_sqlstat where sql_id=p_sqlid and dbid=p_dbid;
--        end if;
        p_script:=replace(replace(p_script,'&start_sn.',p_start_snap),'&end_sn.',p_end_snap);
--      end if;

      l_scr:=substr(l_scr,l_eof+1);
      l_iter:=l_iter+1;
      exit when l_iter>1000 or dbms_lob.getlength(l_scr)=0;
    end loop;
    if not p_plsql then p_script:=replace(p_script,';'); end if;
  end;

  procedure save_report_for_download(p_filename varchar2, p_report t_output_lines, p_id in number, p_parent_id number default null)
  is
    PRAGMA AUTONOMOUS_TRANSACTION;
    l_rpt clob;
    l_pref clob;
    l_brpt blob;
    l_doff number := 1;
    l_soff number := 1;
    l_cont integer := DBMS_LOB.DEFAULT_LANG_CTX;
    l_warn integer;
  begin

    l_pref:=l_pref||HTF.HTMLOPEN||chr(10);
    l_pref:=l_pref||HTF.HEADOPEN||chr(10);
    l_pref:=l_pref||HTF.TITLE('SQL runtime statistics report')||chr(10);

    l_pref:=l_pref||'<style type="text/css">'||chr(10);
    l_pref:=l_pref||awrtools_api.getscript('PROC_AWRCSS')||chr(10);
    l_pref:=l_pref||'</style>'||chr(10);
    l_pref:=l_pref||HTF.HEADCLOSE||chr(10);
    l_pref:=l_pref||HTF.BODYOPEN(cattributes=>'class="awr"')||chr(10);

    for i in 1..p_report.count loop
      l_rpt:=l_rpt||p_report(i)||chr(10);
    end loop;

    INSERT INTO awrtools_online_rpt (id,ts,file_mimetype,file_name,report, reportc, parent_id)
         VALUES (p_id,default,default,p_filename,empty_blob(),l_rpt, p_parent_id) return report into l_brpt;

    l_rpt:=l_pref||chr(10)||l_rpt;
    l_rpt:=l_rpt||(HTF.BODYCLOSE)||chr(10);
    l_rpt:=l_rpt||(HTF.HTMLCLOSE);

    DBMS_LOB.CONVERTTOBLOB(
      dest_lob       => l_brpt,
      src_clob       => l_rpt,
      amount         => DBMS_LOB.LOBMAXSIZE,
      dest_offset    => l_doff,
      src_offset     => l_soff,
      blob_csid      => DBMS_LOB.DEFAULT_CSID,
      lang_context   => l_cont,
      warning        => l_warn);
    commit;
  end;

  procedure getplanh_i(p_sql_id varchar2, p_dblink varchar2, p_id in number, p_parent_id number default null)
  is
    l_timing boolean := true;
    l_time number; l_tot_tim number:=0;
    l_cpu_tim number; l_tot_cpu_tim number:=0;
    l_script varchar2(32767);
    l_report t_output_lines;

    l_output t_output_lines;
    l_plsql_output clob;
    l_indx   number := 1;
    procedure p(p_line varchar2) is
    begin
      l_report(l_indx):=p_line;
      l_indx := l_indx + 1;
    end;
    procedure p1(p_output t_output_lines) is
    begin
      for i in 1..p_output.count loop
        p(p_output(i));
      end loop;
    end;
    procedure stim is
    begin
      if l_timing then
        l_time:=DBMS_UTILITY.GET_TIME;
        l_cpu_tim:=DBMS_UTILITY.GET_CPU_TIME;
      end if;
    end;
    procedure etim(p_last boolean default false) is
      l_delta_t number;
      l_delta_c number;
    begin
      if l_timing then
        l_delta_t:=DBMS_UTILITY.GET_TIME-l_time;
        l_delta_c:=DBMS_UTILITY.GET_CPU_TIME-l_cpu_tim;
        l_tot_tim:=l_tot_tim+l_delta_t;
        l_tot_cpu_tim:=l_tot_cpu_tim+l_delta_c;

        if not p_last then
          p(HTF.header (6,cheader=>'Elapsed (sec): '||to_char(round((l_delta_t)/100,2))||'; CPU (sec): '||to_char(round((l_delta_c)/100,2)),cattributes=>'class="awr"'));
        else
          p(HTF.header (6,cheader=>'Totals: Elapsed (sec): '||to_char(round((l_tot_tim)/100,2))||'; CPU (sec): '||to_char(round((l_tot_cpu_tim)/100,2)),cattributes=>'class="awr"'));
        end if;
      end if;
    end;
  begin
    --p('SQL_ID='||p_sql_id||'; DB LINK='||p_dblink);

    p(HTF.header (1,'SQL Report for SQL_ID='||p_sql_id,cattributes=>'class="awr"'));
    p(HTF.BR);
    p(HTF.BR);
    p(HTF.header (2,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Table of contents',cname=>'tblofcont',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#sql_text',ctext=>'SQL text',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#non_shared',ctext=>'Non shared reason',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#v_sql_stat',ctext=>'V$SQL statistics',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#exadata',ctext=>'Exadata statistics',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#sql_mon',ctext=>'SQL Monitor report',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#sql_workarea',ctext=>'SQL Workarea',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#cbo_env',ctext=>'CBO environment',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_last',ctext=>'Display cursor (last)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_rac',ctext=>'Display cursor (RAC)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_last_adv',ctext=>'Display cursor (LAST ADVANCED)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_all',ctext=>'Display cursor (ALL)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_adaptive',ctext=>'Display cursor (ADAPTIVE)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#sql_mon_hist',ctext=>'SQL Monitor report history',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_p3',ctext=>'ASH Summary',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --SQL TEXT
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'SQL TEXT');
    stim();
    l_script:=awrtools_api.getscript('PROC_GETGTXT');
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'SQL text',cname=>'sql_text',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>500,p_summary=>'SQL text', p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --Non shared
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'Non shared');
    stim();
    l_script:=awrtools_api.getscript('PROC_NON_SHARED');
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Non shared reason',cname=>'non_shared',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>1000,p_summary=>'Non shared reason', p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --V$SQL statistics
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'V$SQL statistics');
    stim();
    l_script:=awrtools_api.getscript('PROC_VSQL_STAT');
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'V$SQL statistics',cname=>'v_sql_stat',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    prepare_script(l_script,p_sql_id, p_plsql=>true);
    --l_script:=replace(l_script,'procedure p(msg varchar2) is begin dbms_output.put_line(msg);end;','procedure p(msg varchar2) is begin :l_res:=:l_res||msg||chr(10);end;');

    l_plsql_output:=null;
    execute_plsql_remotelly(p_sql => l_script, p_dblink => p_dblink, p_output => l_plsql_output);

    declare
      l_user varchar2(512); l_host varchar2(512);
    begin
      select username, host into l_user, l_host from user_db_links where db_link=upper(p_dblink);
      l_plsql_output:=replace(replace(l_plsql_output,'&_USER.',l_user),'&_CONNECT_IDENTIFIER.',l_host);
    exception
      when no_data_found then
        l_user:='<UNKNOWN>'; l_host:='<UNKNOWN>';
        l_plsql_output:=replace(replace(l_plsql_output,'&_USER.',l_user),'&_CONNECT_IDENTIFIER.',l_host);
    end;

    print_text_as_table(p_text=>l_plsql_output,p_t_header=>'V$SQL',p_width=>600, p_search=>'CHILD_NUMBER=([[:digit:]]*)',p_replacement=>HTF.ANCHOR (curl=>'#child_last_\1',ctext=>'CHILD_NUMBER=\1',cattributes=>'class="awr"'), p_output=> l_output);
    p1(l_output);

    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --Exadata statistics
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'Exadata statistics');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Exadata statistics',cname=>'exadata',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);

    l_script:=awrtools_api.getscript('PROC_OFFLOAD_PCT1');
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>1000,p_summary=>'Exadata statistics #1', p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);

    p(HTF.BR);

    l_script:=awrtools_api.getscript('PROC_OFFLOAD_PCT2');
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>1000,p_summary=>'Exadata statistics #2', p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);

    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --SQL Monitor report
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'SQL Monitor report');
    stim();
    l_script:=awrtools_api.getscript('PROC_SQLMON');
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'SQL Monitor report (11g+)',cname=>'sql_mon',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    prepare_script(l_script,p_sql_id, p_plsql=>true);
    --l_sqlmon1:=replace(l_sqlmon1,'procedure p(msg varchar2) is begin dbms_output.put_line(msg);end;','procedure p(msg varchar2) is begin :l_res:=:l_res||msg||chr(10);end;');

    l_plsql_output:=null;
    execute_plsql_remotelly(p_sql => l_script, p_dblink => p_dblink, p_output => l_plsql_output);
    print_text_as_table(p_text=>l_plsql_output||chr(10),p_t_header=>'SQL Monitor report',p_width=>600, p_output=> l_output);
    p1(l_output);

    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --SQL Workarea
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'SQL Workarea');
    stim();
    l_script:=awrtools_api.getscript('PROC_SQLWORKAREA');
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'SQL Workarea',cname=>'sql_workarea',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>1000,p_summary=>'SQL Workarea', p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);

    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --CBO environment
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'CBO environment');
    stim();
    l_script:=awrtools_api.getscript('PROC_OPTENV');
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'CBO environment',cname=>'cbo_env',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>1000,p_summary=>'CBO environment', p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();

--  =============================================================================================================================================
    --Execution plans
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Execution plans',cname=>'tblofcont_plans',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_last',ctext=>'Display cursor (last)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_rac',ctext=>'Display cursor (RAC)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_last_adv',ctext=>'Display cursor (LAST ADVANCED)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_all',ctext=>'Display cursor (ALL)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#dp_adaptive',ctext=>'Display cursor (ADAPTIVE)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
--  =============================================================================================================================================
    --Display cursor (last)
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'Display cursor (last)');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Display cursor (last)',cname=>'dp_last',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    l_script:=q'[select * from table(dbms_xplan.display_cursor('&SQLID', null, 'LAST ALLSTATS +peeked_binds'))]'||chr(10);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,
                               p_width=>1500,
                               p_summary=>'Display cursor (last)',
                               p_search => 'child number ([[:digit:]]*)',
                               p_replacement => HTF.ANCHOR(curl=>'#child_all_\1',ctext=>'child number \1',cname=>'child_last_\1',cattributes=>'class="awr"'),
                               p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont_plans',ctext=>'Back to Execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --Display cursor (RAC)
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'Display cursor (RAC)');
    stim();
    l_script:=awrtools_api.getscript('PROC_RACPLAN');
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Display cursor (RAC)',cname=>'dp_rac',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>1500,p_summary=>'Display cursor (RAC)', p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont_plans',ctext=>'Back to Execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --Display cursor (LAST ADVANCED)
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'Display cursor (LAST ADVANCED)');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Display cursor (LAST ADVANCED)',cname=>'dp_last_adv',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    l_script:=q'[select * from table(dbms_xplan.display_cursor('&SQLID', null, 'LAST ADVANCED'))]'||chr(10);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,
                               p_width=>1500,
                               p_summary=>'Display cursor (LAST ADVANCED)',
                               p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont_plans',ctext=>'Back to Execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --Display cursor (ALL)
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'Display cursor (ALL)');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Display cursor (ALL)',cname=>'dp_all',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    l_script:=q'[select * from table(dbms_xplan.display_cursor('&SQLID', null, 'ALL ALLSTATS +peeked_binds'))]'||chr(10);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,
                               p_width=>2000,
                               p_summary=>'Display cursor (ALL)',
                               p_search => 'child number ([[:digit:]]*)',
                               p_replacement => HTF.ANCHOR(curl=>'',ctext=>'child number \1',cname=>'child_all_\1',cattributes=>'class="awr"'),
                               p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont_plans',ctext=>'Back to Execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --Display cursor (ADAPTIVE)
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'Display cursor (ADAPTIVE)');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Display cursor (ADAPTIVE)',cname=>'dp_adaptive',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    l_script:=q'[SELECT * FROM TABLE(DBMS_XPLAN.display_cursor('&SQLID', null, format => 'adaptive LAST ALLSTATS +peeked_binds'))]'||chr(10);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,
                               p_width=>1500,
                               p_summary=>'Display cursor (ADAPTIVE)',
                               p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont_plans',ctext=>'Back to Execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    etim();
    stim();
    p(HTF.BR);
    p(HTF.BR);
    l_script:=q'[SELECT * FROM TABLE(DBMS_XPLAN.display_cursor('&SQLID', null, format => 'adaptive ALL ALLSTATS +peeked_binds'))]'||chr(10);
    prepare_script(l_script,p_sql_id);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,
                               p_width=>2000,
                               p_summary=>'Display cursor (ADAPTIVE)',
                               p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont_plans',ctext=>'Back to Execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    etim();
--  =============================================================================================================================================
    --SQL Monitor report history
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'SQL Monitor report history');
    stim();
    l_script:=awrtools_api.getscript('PROC_SQLMON_HIST');
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'SQL Monitor report history (12c+)',cname=>'sql_mon_hist',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    prepare_script(l_script,p_sql_id,true);
    l_plsql_output:=null;
    execute_plsql_remotelly(p_sql => l_script, p_dblink => p_dblink, p_output => l_plsql_output);
    print_text_as_table(p_text=>l_plsql_output,p_t_header=>'SQL Monitor report history',p_width=>600, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));

    p(HTF.BR);
    p(HTF.BR);
    etim();

--  =============================================================================================================================================
    --AWR ASH (SQL Monitor) P3
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlan', action_name => 'ASH Summary');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'ASH Summary',cname=>'ash_p3',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);

    l_script:=awrtools_api.getscript('PROC_AWRASHP3');
    prepare_script(l_script,p_sql_id);

    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,
                               p_width=>1000,
                               p_summary=>'ASH summary',
                               p_style1 =>'awrncbbt',
                               p_style2 =>'awrcbbt',
                               --p_search => 'PLAN_HASH',
                               --p_replacement => HTF.ANCHOR (curl=>'#awrplan_\1',ctext=>'\1',cattributes=>'class="awr"'),
                               p_header=>25,
                               p_break_col=>'SQL_EXEC_START',
                               p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    etim();

    p(HTF.BR);
    p(HTF.BR);
    p(HTF.BR);
    p('End of report.');
    etim(true);
--  =============================================================================================================================================
    save_report_for_download('sql_'||p_sql_id||'.html', l_report, p_id, p_parent_id);
  exception
    when others then
      awrtools_logging.log(sqlerrm);
      awrtools_logging.log(DBMS_UTILITY.FORMAT_ERROR_STACK);
      awrtools_logging.log(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      raise_application_error(-20000, sqlerrm);
  end;

  procedure getplanawrh_i(p_sql_id varchar2, p_dblink varchar2, p_id in number, p_parent_id number default null)
  is
    l_timing boolean := true;
    l_time number; l_tot_tim number:=0;
    l_cpu_tim number; l_tot_cpu_tim number:=0;
    l_script varchar2(32767);
    l_report t_output_lines;

    l_output t_output_lines;
    l_plsql_output clob;
    l_indx   number := 1;

    l_crsr sys_refcursor;
    l_dbidn number;
    l_inst_id number;

    l_start_snap number;
    l_end_snap number;

    type t_num_array is table of number;
    l_dbid t_num_array;

    procedure p(p_line varchar2) is
    begin
      l_report(l_indx):=p_line;
      l_indx := l_indx + 1;
    end;
    procedure p1(p_output t_output_lines) is
    begin
      for i in 1..p_output.count loop
        p(p_output(i));
      end loop;
    end;
    procedure stim is
    begin
      if l_timing then
        l_time:=DBMS_UTILITY.GET_TIME;
        l_cpu_tim:=DBMS_UTILITY.GET_CPU_TIME;
      end if;
    end;
    procedure etim(p_last boolean default false) is
      l_delta_t number;
      l_delta_c number;
    begin
      if l_timing then
        l_delta_t:=DBMS_UTILITY.GET_TIME-l_time;
        l_delta_c:=DBMS_UTILITY.GET_CPU_TIME-l_cpu_tim;
        l_tot_tim:=l_tot_tim+l_delta_t;
        l_tot_cpu_tim:=l_tot_cpu_tim+l_delta_c;

        if not p_last then
          p(HTF.header (6,cheader=>'Elapsed (sec): '||to_char(round((l_delta_t)/100,2))||'; CPU (sec): '||to_char(round((l_delta_c)/100,2)),cattributes=>'class="awr"'));
        else
          p(HTF.header (6,cheader=>'Totals: Elapsed (sec): '||to_char(round((l_tot_tim)/100,2))||'; CPU (sec): '||to_char(round((l_tot_cpu_tim)/100,2)),cattributes=>'class="awr"'));
        end if;
      end if;
    end;
  begin
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'Preparation');

    execute immediate q'[select nvl(min(snap_id),1) , nvl(max(snap_id),1e6) from dba_hist_sqlstat@]'||p_dblink||q'[ where sql_id=']'||p_sql_id||q'[' and dbid in (select dbid from dba_hist_sqltext@]'||p_dblink||q'[ where sql_id=']'||p_sql_id||q'[')]'
      into l_start_snap, l_end_snap;

    execute immediate 'select unique dbid from dba_hist_sqltext@'||p_dblink||q'[ where sql_id=']'||p_sql_id||q'[' order by 1]'
      bulk collect into l_dbid;

    p(HTF.header (1,'AWR SQL Report for SQL_ID='||p_sql_id,cattributes=>'class="awr"'));
    p(HTF.BR);
    p(HTF.BR);
    p(HTF.header (2,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Table of contents',cname=>'tblofcont',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);

    p(HTF.header (4,cheader=>'Statistics',cattributes=>'class="awr"'));

    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#sql_text',ctext=>'SQL text',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#db_desc',ctext=>'DB description',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#sql_stat',ctext=>'SQL statistics',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#binds',ctext=>'Bind values',cattributes=>'class="awr"')));

    p(HTF.header (4,cheader=>'Explain plan',cattributes=>'class="awr"'));

    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#awrplans',ctext=>'AWR SQL execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#awrplanscomp',ctext=>'AWR SQL plans comparison',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#epplan',ctext=>'Explain plan',cattributes=>'class="awr"')));

    p(HTF.header (4,cheader=>'ASH',cattributes=>'class="awr"'));

    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash',ctext=>'ASH',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_plsql',ctext=>'PL/SQL',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_summ',ctext=>'ASH summary',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_p1',ctext=>'AWR ASH (SQL Monitor) P1',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_p1.1',ctext=>'AWR ASH (SQL Monitor) P1.1',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_p2',ctext=>'AWR ASH (SQL Monitor) P2',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_p3',ctext=>'AWR ASH (SQL Monitor) P3',cattributes=>'class="awr"')));

    p(HTF.header (4,cheader=>'SQL Monitor',cattributes=>'class="awr"'));

    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#sql_mon_hist',ctext=>'SQL Monitor report history',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --SQL TEXT
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'SQL TEXT');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'SQL text',cname=>'sql_text',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);

    l_script:=q'[select x.sql_text text from dba_hist_sqltext x where sql_id=']'||p_sql_id||q'[' and rownum=1]'||chr(10);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>500,p_summary=>'SQL text', p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);

    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --DB description
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'DB description');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'DB description',cname=>'db_desc',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);

    l_script:=q'[select unique INSTANCE_NUMBER INST_ID, DB_NAME,dbid,version,host_name,platform_name from dba_hist_database_instance where dbid in (select dbid from dba_hist_sqltext where sql_id=']'||p_sql_id||q'[')]'||chr(10);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>1000,p_summary=>'DB description', p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);

    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --SQL statistics
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'SQL statistics');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'SQL statistics',cname=>'sql_stat',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    p('POE - per one exec, time in milliseconds (1/1000 of second)');
    p(HTF.BR);
    open l_crsr for 'select unique dbid,INSTANCE_NUMBER from dba_hist_database_instance@'||p_dblink||' where dbid in (select dbid from dba_hist_sqltext@'||p_dblink||q'[ where sql_id=']'||p_sql_id||q'[') order by 1,2]';
    --for i in (select unique dbid,INSTANCE_NUMBER from dba_hist_database_instance where dbid in (select dbid from dba_hist_sqltext where sql_id=l_sql_id) order by 1,2)
    loop
      fetch l_crsr into l_dbidn, l_inst_id;
      exit when l_crsr%notfound;
      p('DBID: '||l_dbidn||'; INST_ID: '||l_inst_id);
      --l_sql:=l_sqlstat;
      l_script:=awrtools_api.getscript('PROC_AWRSQLSTAT');
      prepare_script(l_script,p_sql_id,p_dbid=>l_dbidn,p_inst_id=>l_inst_id, p_start_snap => l_start_snap, p_end_snap => l_end_snap);
      l_output.delete;
      print_table_html_remotelly(p_query=>l_script,
                                 p_width=>1000,
                                 p_summary=>'SQL statistics',
                                 p_style1 =>'awrncbbt',
                                 p_style2 =>'awrcbbt',
                                 p_search => 'PLAN_HASH',
                                 p_replacement => HTF.ANCHOR (curl=>'#awrplan_\1',ctext=>'\1',cattributes=>'class="awr"'),
                                 p_header=>25,
                                 p_dblink => p_dblink, p_output=> l_output);
      p1(l_output);
      p(HTF.BR);
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
      p(HTF.BR);
    end loop;
    close l_crsr;
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --Bind values
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'Bind values');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Bind values',cname=>'binds',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);

    l_script:=q'[select snap_id snap, name, datatype_string,to_char(last_captured,'yyyy/mm/dd hh24:mi:ss') last_captured, value_string from dba_hist_sqlbind where sql_id=']'||p_sql_id||q'[' order by snap_id,position]'||chr(10);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,p_width=>1000,p_summary=>'Bind values',p_header=>25, p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);

    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --AWR SQL execution plans
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'AWR SQL execution plans');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'AWR SQL execution plans',cname=>'awrplans',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#awrplanscomp',ctext=>'AWR SQL plans comparison',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#epplan',ctext=>'Explain plan',cattributes=>'class="awr"')));
    p(HTF.BR);   p(HTF.BR);
    -- for i in (select unique dbid from dba_hist_database_instance where dbid in (select dbid from dba_hist_sqltext where sql_id=l_sql_id) order by 1)
    for i in 1..l_dbid.count
    loop
      p('DBID: '||l_dbid(i));

      l_script:=q'[select * from table(dbms_xplan.display_awr(']'||p_sql_id||q'[', null, ]'||l_dbid(i)||q'[, 'ADVANCED'))]'||chr(10);
      l_output.delete;
      print_table_html_remotelly(p_query=>l_script,
                                 p_width=>1000,
                                 p_summary=>'AWR SQL execution plans',
                                 p_search => 'Plan hash value: ([[:digit:]]*)',
                                 p_replacement => HTF.ANCHOR(curl=>'#epplan_\1',ctext=>'Plan hash value: \1',cname=>'awrplan_\1',cattributes=>'class="awr"'),
                                 p_dblink => p_dblink, p_output=> l_output);
      p1(l_output);

      p(HTF.BR);
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#awrplans',ctext=>'Back to AWR SQL execution plans',cattributes=>'class="awr"')));
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
      p(HTF.BR);
    end loop;
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --Comparsion
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'Comparsion');
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'AWR SQL plans comparison',cname=>'awrplanscomp',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    p('Not implemented for remote database.');
/*    stim();


    for c in (select dbid, sql_id, min(snap_id) mi, max(snap_id) ma, count(unique plan_hash_value) cnt
                from dba_hist_sqlstat
               where plan_hash_value<>0
                 and CPU_TIME_DELTA+ELAPSED_TIME_DELTA+BUFFER_GETS_DELTA+EXECUTIONS_DELTA>0
                 and sql_id=l_sql_id
               group by dbid, sql_id
              having count(unique plan_hash_value)>1)
    loop
      l_script:=awrtools_api.getscript('GETCOMPREPORT');
      execute immediate
         replace(
         replace(
         replace(
         replace(
         replace(
         replace(
         replace(
         replace(
         replace(
         replace(
         replace(l_script
                          ,'!dblnk.','')
                          ,'!dbid1.',to_char(c.dbid))
                          ,'!start_snap1.',to_char(c.mi-1))
                          ,'!end_snap1.',to_char(c.ma))
                          ,'!dbid2.',to_char(c.dbid))
                          ,'!start_snap2.',to_char(c.mi-1))
                          ,'!end_snap2.',to_char(c.ma))
                          ,'!filter.',q'[sql_id=']'||l_sql_id||q'[']')
                          ,'!sortcol.','ELAPSED_TIME_DELTA')
                          ,'!sortlimit.','1')
                          ,'!embeded.','TRUE');
    end loop;
*/
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#awrplans',ctext=>'Back to AWR SQL execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
--    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --Explain plan
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'Explain plan');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Explain plan',cname=>'epplan',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ep_simple',ctext=>'Explain plan (simple)',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ep_adv',ctext=>'Explain plan (advanced)',cattributes=>'class="awr"')));

    p(HTF.BR);p(HTF.BR);

    declare
      l_out clob;
    begin
      execute immediate 'select x.sql_text from dba_hist_sqltext@'||p_dblink||q'[ x where sql_id=']'||p_sql_id||q'[' and rownum=1]' into l_script;
      execute immediate 'delete from plan_table@'||p_dblink;
      --execute immediate 'explain plan for '||chr(10)||l_script;
      execute_plsql_remotelly(p_sql => q'(execute immediate q'[explain plan for )'||chr(10)||l_script||q'(]';)', p_dblink => p_dblink, p_output => l_out, p_is_output => false);
    exception
      when others then p(sqlerrm);
    end;

    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Explain plan (simple)',cname=>'ep_simple',cattributes=>'class="awr"'),cattributes=>'class="awr"'));

    l_script:=q'[select * from table(dbms_xplan.display())]'||chr(10);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,
                               p_width=>1000,
                               p_summary=>'Explain plan',
                               p_search => 'Plan hash value: ([[:digit:]]*)',
                               p_replacement => HTF.ANCHOR(curl=>'#epplanadv_\1',ctext=>'Plan hash value: \1',cname=>'epplan_\1',cattributes=>'class="awr"'),
                               p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);

    p(HTF.BR);p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#epplan',ctext=>'Back to Explain plan',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#awrplans',ctext=>'Back to AWR SQL execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);p(HTF.BR);
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'Explain plan (advanced)',cname=>'ep_adv',cattributes=>'class="awr"'),cattributes=>'class="awr"'));

    l_script:=q'[select * from table(dbms_xplan.display(null,null,'ADVANCED',null))]'||chr(10);
    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,
                               p_width=>1000,
                               p_summary=>'Explain plan (advanced)',
                               p_search => 'Plan hash value: ([[:digit:]]*)',
                               p_replacement => HTF.ANCHOR(curl=>'',ctext=>'Plan hash value: \1',cname=>'epplanadv_\1',cattributes=>'class="awr"'),
                               p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);

    etim();
    p(HTF.BR);p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#epplan',ctext=>'Back to Explain plan',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#awrplans',ctext=>'Back to AWR SQL execution plans',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);
    p(HTF.BR);
    rollback;

--  =============================================================================================================================================
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'ASH',cname=>'ash',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_plsql',ctext=>'PL/SQL',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_summ',ctext=>'ASH summary',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_p1',ctext=>'AWR ASH (SQL Monitor) P1',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_p1.1',ctext=>'AWR ASH (SQL Monitor) P1.1',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_p2',ctext=>'AWR ASH (SQL Monitor) P2',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash_p3',ctext=>'AWR ASH (SQL Monitor) P3',cattributes=>'class="awr"')));
    p(HTF.BR);p(HTF.BR);

--  =============================================================================================================================================
    --ASH PL/SQL
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'ASH PL/SQL');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'ASH PL/SQL',cname=>'ash_plsql',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    for i in 1..l_dbid.count
    loop
      p('DBID: '||l_dbid(i));
      if sys_context('USERENV','CON_ID')=0 then --in multitenant it runs forever
        l_script:=q'[select * from dba_procedures where (object_id,subprogram_id) in (select unique plsql_entry_object_id,plsql_entry_subprogram_id from dba_hist_active_sess_history where instance_number between 1 and 255 and snap_id between ]'||l_start_snap||q'[ and ]'||l_end_snap||q'[ and sql_id = ']'||p_sql_id||q'[' and dbid= ]'||l_dbid(i)||q'[)]'||chr(10);
        l_output.delete;
        print_table_html_remotelly(p_query=>l_script,p_width=>1500,p_summary=>'ASH PL/SQL',p_style1 =>'awrc1',p_style2 =>'awrnc1', p_dblink => p_dblink, p_output=> l_output);
        p1(l_output);
      else
        p('No PL/SQL source data for multitenant DB.');
      end if;

      p(HTF.BR);
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash',ctext=>'Back to ASH',cattributes=>'class="awr"')));
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
      p(HTF.BR);
    end loop;
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --ASH summary
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'ASH summary');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'ASH summary',cname=>'ash_summ',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    for i in 1..l_dbid.count
    loop
      p('DBID: '||l_dbid(i));
      l_script:=awrtools_api.getscript('PROC_AWRASHSUMM');
      prepare_script(l_script,p_sql_id,p_dbid=>l_dbid(i), p_start_snap => l_start_snap, p_end_snap => l_end_snap);

      l_output.delete;
      print_table_html_remotelly(p_query=>l_script,
                                 p_width=>1500,
                                 p_summary=>'ASH summary',
                                 p_style1 =>'awrncbbt',
                                 p_style2 =>'awrcbbt',
                                 p_search => 'PLAN_HASH',
                                 p_replacement => HTF.ANCHOR (curl=>'#awrplan_\1',ctext=>'\1',cattributes=>'class="awr"'),
                                 p_header=>25,
                                 p_dblink => p_dblink, p_output=> l_output);
      p1(l_output);

      p(HTF.BR);
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash',ctext=>'Back to ASH',cattributes=>'class="awr"')));
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
      p(HTF.BR);
    end loop;
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --AWR ASH (SQL Monitor) P1
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'AWR ASH (SQL Monitor) P1');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'AWR ASH (SQL Monitor) P1',cname=>'ash_p1',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);

    for i in 1..l_dbid.count
    loop
      p('DBID: '||l_dbid(i));
      l_script:=awrtools_api.getscript('PROC_AWRASHP1');
      prepare_script(l_script,p_sql_id,p_dbid=>l_dbid(i), p_start_snap => l_start_snap, p_end_snap => l_end_snap);

      l_output.delete;
      print_table_html_remotelly(p_query=>l_script,
                                 p_width=>1000,
                                 p_summary=>'AWR ASH (SQL Monitor) P1',
                                 p_style1 =>'awrncbbt',
                                 p_style2 =>'awrcbbt',
                                 p_search => 'PLAN_HASH',
                                 p_replacement => HTF.ANCHOR (curl=>'#awrplan_\1',ctext=>'\1',cattributes=>'class="awr"'),
                                 p_header=>50,
                                 p_break_col=>'SQL_EXEC_START',
                                 p_dblink => p_dblink, p_output=> l_output);
      p1(l_output);
      p(HTF.BR);
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash',ctext=>'Back to ASH',cattributes=>'class="awr"')));
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
      p(HTF.BR);
    end loop;
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --AWR ASH (SQL Monitor) P1.1
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'AWR ASH (SQL Monitor) P1.1');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'AWR ASH (SQL Monitor) P1.1',cname=>'ash_p1.1',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    for i in 1..l_dbid.count
    loop
      p('DBID: '||l_dbid(i));
      l_script:=awrtools_api.getscript('PROC_AWRASHP1_1');
      prepare_script(l_script,p_sql_id,p_dbid=>l_dbid(i), p_start_snap => l_start_snap, p_end_snap => l_end_snap);

      l_output.delete;
      print_table_html_remotelly(p_query=>l_script,
                                 p_width=>1000,
                                 p_summary=>'AWR ASH (SQL Monitor) P1.1',
                                 p_style1 =>'awrncbbt',
                                 p_style2 =>'awrcbbt',
                                 p_search => 'PLAN_HASH',
                                 p_replacement => HTF.ANCHOR (curl=>'#awrplan_\1',ctext=>'\1',cattributes=>'class="awr"'),
                                 p_header=>25,
                                 p_break_col=>'ID',
                                 p_dblink => p_dblink, p_output=> l_output);
      p1(l_output);
      p(HTF.BR);
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash',ctext=>'Back to ASH',cattributes=>'class="awr"')));
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
      p(HTF.BR);
    end loop;
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --AWR ASH (SQL Monitor) P2
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'AWR ASH (SQL Monitor) P2');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'AWR ASH (SQL Monitor) P2',cname=>'ash_p2',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    for i in 1..l_dbid.count
    loop
      p('DBID: '||l_dbid(i));
      l_script:=awrtools_api.getscript('PROC_AWRASHP2');
      prepare_script(l_script,p_sql_id,p_dbid=>l_dbid(i), p_start_snap => l_start_snap, p_end_snap => l_end_snap);

      l_output.delete;
      print_table_html_remotelly(p_query=>l_script,
                                 p_width=>1000,
                                 p_summary=>'AWR ASH (SQL Monitor) P2',
                                 p_style1 =>'awrncbbt',
                                 p_style2 =>'awrcbbt',
                                 p_search => 'PLAN_HASH',
                                 p_replacement => HTF.ANCHOR (curl=>'#awrplan_\1',ctext=>'\1',cattributes=>'class="awr"'),
                                 p_header=>50,
                                 p_break_col=>'SQL_EXEC_START',
                                 p_dblink => p_dblink, p_output=> l_output);
      p1(l_output);
      p(HTF.BR);
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash',ctext=>'Back to ASH',cattributes=>'class="awr"')));
      p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
      p(HTF.BR);
    end loop;
    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --AWR ASH (SQL Monitor) P3
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'AWR ASH (SQL Monitor) P3');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'AWR ASH (SQL Monitor) P3',cname=>'ash_p3',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);

    l_script:=awrtools_api.getscript('PROC_AWRASHP3');
    prepare_script(l_script,p_sql_id, p_start_snap => l_start_snap, p_end_snap => l_end_snap);

    l_output.delete;
    print_table_html_remotelly(p_query=>l_script,
                               p_width=>1000,
                               p_summary=>'AWR ASH (SQL Monitor) P3',
                               p_style1 =>'awrncbbt',
                               p_style2 =>'awrcbbt',
                               p_search => 'PLAN_HASH',
                               p_replacement => HTF.ANCHOR (curl=>'#awrplan_\1',ctext=>'\1',cattributes=>'class="awr"'),
                               p_header=>25,
                               p_break_col=>'SQL_EXEC_START',
                               p_dblink => p_dblink, p_output=> l_output);
    p1(l_output);
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#ash',ctext=>'Back to ASH',cattributes=>'class="awr"')));
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    p(HTF.BR);

    etim();
    p(HTF.BR);
    p(HTF.BR);

--  =============================================================================================================================================
    --SQL Monitor report history
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'SQL Monitor report history');
    stim();
    p(HTF.header (3,cheader=>HTF.ANCHOR (curl=>'',ctext=>'SQL Monitor report history (12c+)',cname=>'sql_mon_hist',cattributes=>'class="awr"'),cattributes=>'class="awr"'));
    p(HTF.BR);
    l_script:=awrtools_api.getscript('PROC_SQLMON_HIST');
    prepare_script(l_script,p_sql_id,true,p_start_snap => l_start_snap, p_end_snap => l_end_snap);
    l_plsql_output:=null;
    execute_plsql_remotelly(p_sql => l_script, p_dblink => p_dblink, p_output => l_plsql_output);
    print_text_as_table(p_text=>l_plsql_output,
                        p_t_header=>'SQL Monitor report history',
                        p_width=>600,
                        p_search=>'Plan Hash Value=([[:digit:]]*)',
                        p_replacement=>HTF.ANCHOR (curl=>'#awrplan_\1',ctext=>'Plan Hash Value=\1',cattributes=>'class="awr"'),
                        p_output=> l_output);
    p1(l_output);

    etim();
    p(HTF.BR);
    p(HTF.LISTITEM(cattributes=>'class="awr"',ctext=>HTF.ANCHOR (curl=>'#tblofcont',ctext=>'Back to top',cattributes=>'class="awr"')));
    etim(true);
    p(HTF.BR);
    p(HTF.BR);
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GetPlanAWR', action_name => 'Finished');
--  =============================================================================================================================================
    save_report_for_download('sql_'||p_sql_id||'.html', l_report, p_id, p_parent_id);
  exception
    when others then
      awrtools_logging.log(sqlerrm);
      awrtools_logging.log(DBMS_UTILITY.FORMAT_ERROR_STACK);
      awrtools_logging.log(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      raise_application_error(-20000, sqlerrm);
  end;

  procedure getreport(p_id in number, p_report out t_output_lines)
  is
    l_iter number := 1;
    l_text clob;
    l_eof  number;
    l_chunk varchar2(32767);
    l_off  number:=1;
    l_chunk_size number := 32767;
  begin
    select reportc into l_text from AWRTOOLS_ONLINE_RPT where id=p_id;
    if nvl(dbms_lob.getlength(l_text),0)>0 then
      loop
        l_eof:=instr(l_text,chr(10),l_off);
        if l_eof=0 then
          p_report(l_iter):=rtrim(rtrim(substr(l_text,l_off),chr(13)),chr(10));
        else
          p_report(l_iter):=rtrim(rtrim(substr(l_text,l_off,l_eof-l_off+1),chr(13)),chr(10));
        end if;
        l_off:=1+l_eof;
        l_iter:=l_iter+1;
        exit when l_eof=0;
      end loop;
    else
      p_report(1):='Empty report';
    end if;
  end;

  procedure getplanawrh(p_sql_id varchar2, p_dblink varchar2, p_id in number)
  is
    l_crsr sys_refcursor;
    l_sql_id varchar2(100);
    l_id number;
  begin
    getplanawrh_i(p_sql_id,p_dblink,p_id);
    open l_crsr for 'select sql_id from dba_hist_active_sess_history@'||p_dblink||q'[ where sql_id is not null and top_level_sql_id=']'||p_sql_id||q'[' group by sql_id having count(1)>6]';
    loop
      fetch l_crsr into l_sql_id;
      exit when l_crsr%notfound;
      select sq_online_rpt.nextval into l_id from dual;
      getplanawrh_i(l_sql_id,p_dblink,l_id, p_id);
    end loop;
    close l_crsr;
  end;

  procedure getplanh(p_sql_id varchar2, p_dblink varchar2, p_id in number)
  is
    l_crsr sys_refcursor;
    l_sql_id varchar2(100);
    l_id number;
  begin
    getplanh_i(p_sql_id,p_dblink,p_id);
    open l_crsr for 'select sql_id from gv$active_session_history@'||p_dblink||q'[ where sql_id is not null and top_level_sql_id=']'||p_sql_id||q'[' group by sql_id having count(1)>60]';
    loop
      fetch l_crsr into l_sql_id;
      exit when l_crsr%notfound;
      select sq_online_rpt.nextval into l_id from dual;
      getplanh_i(l_sql_id,p_dblink,l_id, p_id);
    end loop;
    close l_crsr;
  end;

END AWRTOOLS_REMOTE_ANALYTICS;
/