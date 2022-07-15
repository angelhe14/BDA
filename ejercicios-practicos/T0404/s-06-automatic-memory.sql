connect sys/system2 as sysdba

set linesize window

alter system set memory_target =768M scope=memory;
alter system set sga_target =0 scope=memory;
alter system set pga_aggregate_target =0 scope=memory;
alter system set db_cache_size=0 scope=memory;
alter system set shared_pool_size=0 scope=memory;
alter system set large_pool_size=0 scope=memory;
alter system set java_pool_size =0 scope=memory;

exec dbms_session.sleep(5)

insert into angel0404.t02_memory_param_values (id,sample_date,memory_target,sga_target,
  pga_aggregate_target,shared_pool_size,large_pool_size,java_pool_size,db_cache_size) values (
    4,
    (select sysdate from dual),
    (select round((value/1048576),2) from v$parameter
      where name='memory_target'),
    (select round((value/1048576),2) from v$parameter
      where name='sga_target'),
    (select round((value/1048576),2) from v$parameter
      where name='pga_aggregate_target'),
    (select round((value/1048576),2) from v$parameter
      where name='shared_pool_size'),
    (select round((value/1048576),2) from v$parameter
      where name='large_pool_size'),
    (select round((value/1048576),2) from v$parameter
      where name='java_pool_size'),
    (select round((value/1048576),2) from v$parameter
      where name='db_cache_size'));

select * from angel0404.t02_memory_param_values; 