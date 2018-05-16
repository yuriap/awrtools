declare
procedure gather_stats(p_table_name varchar2) is
begin
  DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=> user, TABNAME=> p_table_name, CASCADE=> true, FORCE=> true);
  DBMS_STATS.LOCK_TABLE_STATS(OWNNAME=> user, TABNAME=> p_table_name);
end;
begin
  gather_stats('CUBE_ASH');
  gather_stats('CUBE_ASH_SEG');
  gather_stats('CUBE_ASH_SESS');
  gather_stats('CUBE_ASH_TIMELINE');
  gather_stats('CUBE_ASH_UNKNOWN');
  gather_stats('CUBE_BLOCK_ASH');
  gather_stats('CUBE_METRICS');
  gather_stats('CUBE_DIC');
end;
/

select * from USER_TAB_STATISTICS where table_name like 'CUBE%';

declare
procedure exp_stats(p_table_name varchar2) is
begin
  dbms_stats.export_table_stats(ownname=>user, TABNAME=> p_table_name, stattab => 'AWRTOOL_STAT_BACKUP', statid => 'EXPORT_CUBE_STAT');
end;
begin
  for t in (select table_name from user_tables where table_name='AWRTOOL_STAT_BACKUP') loop
    execute immediate 'drop table '||t.table_name;
  end loop;
  dbms_stats.create_stat_table(user, 'AWRTOOL_STAT_BACKUP');
  exp_stats('CUBE_ASH');
  exp_stats('CUBE_ASH_SEG');
  exp_stats('CUBE_ASH_SESS');
  exp_stats('CUBE_ASH_TIMELINE');
  exp_stats('CUBE_ASH_UNKNOWN');
  exp_stats('CUBE_BLOCK_ASH');
  exp_stats('CUBE_METRICS');
  exp_stats('CUBE_DIC');
end;
/

select * from CUBE_STAT_BACKUP;