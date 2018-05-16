begin
  for t in (select table_name from user_tables where table_name='AWRTOOL_STAT_BACKUP') loop
    execute immediate 'drop table '||t.table_name;
  end loop;
  dbms_stats.create_stat_table(user, 'AWRTOOL_STAT_BACKUP');
end;
/
alter session set cursor_sharing=force;
@cube_stats.sql
commit;
alter session set cursor_sharing=exact;

begin
  dbms_stats.import_schema_stats(ownname=>user, stattab => 'AWRTOOL_STAT_BACKUP', statid => 'EXPORT_CUBE_STAT');
end;
/

@lock_cube_stats