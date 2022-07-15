connect sys/system2 as sysdba

set linesize window

create table angel0403.t04_pga_stats(
  max_pga_mb number(10,2),
  pga_target_param_calc_mb number(10,2),
  pga_target_param_actual_mb number(10,2),
  pga_total_actual_mb number(10,2),
  pga_in_use_actual_mb number(10,2),
  pga_free_memory_mb number(10,2),
  pga_process_count number(5),
  pga_cache_hit_percentage number(4)
);


insert into angel0403.t04_pga_stats(max_pga_mb,pga_target_param_calc_mb,pga_target_param_actual_mb,
  pga_total_actual_mb,pga_in_use_actual_mb,pga_free_memory_mb,pga_process_count,pga_cache_hit_percentage) values (
  (select round((value/1048576),2) from v$pgastat where name='aggregate PGA auto target'),
  (select round((value/1048576),2) from v$pgastat where name='aggregate PGA target parameter'),
  (select round((value/1048576),2) from v$parameter where name='pga_aggregate_target'),
  (select round((value/1048576),2) from v$pgastat where name='total PGA allocated'),
  (select round((value/1048576),2) from v$pgastat where name='total PGA inuse'),
  (select round((value/1048576),2) from v$pgastat where name='total freeable PGA memory'),
  (select value from v$pgastat where name='process count'),
  (select value from v$pgastat where name='cache hit percentage'));


select * from angel0403.t04_pga_stats;