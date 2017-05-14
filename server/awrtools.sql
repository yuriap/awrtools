create table awrdumps (
dump_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
loading_date date default sysdate,
filename varchar2(512),
status varchar2(10) default 'NEW',
dbid number,
min_snap_id number,
max_snap_id number,
min_snap_dt timestamp,
max_snap_dt timestamp,
db_description varchar2(1000)
);
alter table awrdumps modify min_snap_dt timestamp(3);
alter table awrdumps modify max_snap_dt timestamp(3);

create table awrdumps_files (
dump_id number references awrdumps(dump_id) on delete cascade,
filebody blob
);

create table awrcomp_d_sortordrs (
dic_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
dic_value varchar2(100),
dic_display_value varchar2(100)
);

create table awrcomp_reports(
report_id NUMBER GENERATED ALWAYS AS IDENTITY primary key,
db1_dump_id number references awrdumps(dump_id) on delete cascade,
db2_dump_id number references awrdumps(dump_id) on delete cascade,
db1_snap_list varchar2(1000),
db2_snap_list varchar2(1000),
report_sort_ordr number references awrcomp_d_sortordrs(dic_id) on delete set null,
report_content clob
);

insert into awrcomp_d_sortordrs(dic_value,dic_display_value) values('sum(ELAPSED_TIME_DELTA)','Sort by Elapsed Time');
insert into awrcomp_d_sortordrs(dic_value,dic_display_value) values('sum(disk_reads_delta)','Sort by Disk Reads');
commit;


create or replace package awrtool_pkg as

  function getconf(p_key varchar2) return varchar2;
  procedure save_dump(p_blob blob, p_filename varchar2, p_dir varchar2);
  
end;
/
create or replace package body awrtool_pkg as

  function getconf(p_key varchar2) return varchar2
  is
    l_res config.cvalue%type;
  begin
    select cvalue into l_res from config where ckey=p_key;
    return l_res;
  end;
  
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

end;
/
