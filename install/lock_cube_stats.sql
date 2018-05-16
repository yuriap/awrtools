declare
procedure lock_stats(p_table_name varchar2) is
begin
  DBMS_STATS.LOCK_TABLE_STATS(OWNNAME=> user, TABNAME=> p_table_name);
end;
begin
  lock_stats('CUBE_ASH');
  lock_stats('CUBE_ASH_SEG');
  lock_stats('CUBE_ASH_SESS');
  lock_stats('CUBE_ASH_TIMELINE');
  lock_stats('CUBE_ASH_UNKNOWN');
  lock_stats('CUBE_BLOCK_ASH');
  lock_stats('CUBE_METRICS');
end;
/