create or replace package body awrtools_reports as


    procedure create_awrcomp_report(p_report_id AWRCOMP_REPORTS.REPORT_ID%type)
    is

      dbid1 AWRDUMPS.DBID%type;
      dbid2 AWRDUMPS.DBID%type;
      db1_start_snap AWRCOMP_REPORTS.db1_start_snap%type;
      db1_end_snap AWRCOMP_REPORTS.db1_end_snap%type;
      db2_start_snap AWRCOMP_REPORTS.db2_start_snap%type;
      db2_end_snap AWRCOMP_REPORTS.db2_end_snap%type;
      sortcol AWRCOMP_D_SORTORDRS.DIC_VALUE%type;
      sortlimit AWRCOMP_REPORTS.sortlimit%type;
      filter AWRCOMP_REPORTS.filter%type;
      dblink AWRCOMP_REPORTS.dblink%type;
      sql_id AWRCOMP_REPORTS.sql_id%type;
      report_type awrcomp_d_report_types.DIC_VALUE%type;

      l_awrcomp_scr      clob;
      l_awrsqlreport_scr clob;

      l_line varchar(32767);
      l_status number;
      l_awrcomp_rpt clob;
      l_trg_lob blob;
      l_toexec clob;


      function replace_subst(p_sql clob) return clob
      is
        l_sql clob;
      begin
        l_sql := replace(p_sql,'~dbid1.',to_char(dbid1));
        l_sql := replace(l_sql,'~dbid2.',to_char(dbid2));
        l_sql := replace(l_sql,'~start_snap1.',to_char(db1_start_snap));
        l_sql := replace(l_sql,'~start_snap2.',to_char(db2_start_snap));
        l_sql := replace(l_sql,'~end_snap1.',to_char(db1_end_snap));
        l_sql := replace(l_sql,'~end_snap2.',to_char(db2_end_snap));
        l_sql := replace(l_sql,'~dblnk.',dblink);
        l_sql := replace(l_sql,'~sortcol.',sortcol);
        l_sql := replace(l_sql,'~filter.',filter);
        l_sql := replace(l_sql,'~sortlimit.',to_char(sortlimit));
        l_sql := replace(l_sql,'~embeded.','FALSE');
        l_sql := replace(l_sql,'~SQLID',sql_id);
        return l_sql;
      end;

    begin

      execute immediate q'[alter session set nls_numeric_characters=', ']';

      select
          d1.dbid,d2.dbid,
          db1_start_snap,db1_end_snap,
          db2_start_snap,db2_end_snap,
          s.DIC_VALUE,sortlimit,filter,
          decode(d2.is_remote,'YES',dblink,null),tp.DIC_VALUE,r.sql_id
        into
          dbid1,dbid2,
          db1_start_snap,db1_end_snap,
          db2_start_snap,db2_end_snap,
          sortcol,sortlimit,filter,
          dblink,report_type,sql_id
        from AWRCOMP_REPORTS r, AWRDUMPS d1, AWRDUMPS d2, AWRCOMP_D_SORTORDRS s, awrcomp_d_report_types tp where report_id=p_report_id
          and DB1_DUMP_ID=d1.dump_id and DB2_DUMP_ID=d2.dump_id(+) and s.DIC_ID(+)=sortcol and tp.DIC_ID=report_type;

      dbms_output.enable(null);
      begin
        if report_type='AWRCOMP' then
          l_awrcomp_scr := awrtools_api.getscript('GETCOMPREPORT');
          l_awrcomp_scr := replace_subst(l_awrcomp_scr);
          execute immediate l_awrcomp_scr;

        elsif report_type='AWRSQLREPORT' then

          l_awrsqlreport_scr := awrtools_api.getscript('GETAWRSQLREPORT');
          l_awrsqlreport_scr := replace_subst(l_awrsqlreport_scr);
          execute immediate l_awrsqlreport_scr;

        else
            raise_application_error(-20000, 'Unknown report type: '||report_type);
        end if;
      exception
        when others then l_awrcomp_rpt:=sqlerrm||chr(10)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||chr(10)||sql_id||chr(10)||l_toexec;
      end;
      --dbms_output.put_line(length(l_awrcomp_rpt));
      --update AWRCOMP_REPORTS set REPORT_CONTENT=l_awrcomp_rpt where report_id=p_report_id;

      --save report
      --get report from buffer
      loop
        DBMS_OUTPUT.GET_LINE (
          line   => l_line,
          status => l_status);
        exit when l_status=1;
        l_awrcomp_rpt:=l_awrcomp_rpt||l_line||chr(10);
      end loop;

      if l_awrcomp_rpt is null then l_awrcomp_rpt:='No fata found for '||report_type; end if;

      select REPORT_CONTENT into l_trg_lob from AWRCOMP_REPORTS where report_id=p_report_id for update;
      declare
        ll_d_off integer := 1;
        ll_s_off integer := 1;
        ll_lang_context integer := dbms_lob.DEFAULT_LANG_CTX;
        ll_warn  integer;
      begin
      DBMS_LOB.CONVERTTOBLOB(
        dest_lob       => l_trg_lob,
        src_clob       => l_awrcomp_rpt,
        amount         => DBMS_LOB.LOBMAXSIZE,
        dest_offset    => ll_d_off,
        src_offset     => ll_s_off,
        blob_csid      => dbms_lob.DEFAULT_CSID,
        lang_context   => ll_lang_context,
        warning        => ll_warn);
      end;
      commit;
    exception
      when others then raise_application_error(-20000, sqlerrm||chr(10)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||chr(10)||substr(l_awrcomp_rpt,1,100));
    end;

end;
/