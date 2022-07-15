connect sys/system2 as sysdba

set linesize window

create table angel0404.t01_memory_areas(
  id number(3),
  sample_date date,
  redo_buffer_mb number(10,2),
  buffer_cache_mb number(10,2),
  shared_pool_mb number(10,2),
  large_pool_mb number(10,2),
  java_pool_mb number(10,2),
  total_sga_mb1 number(10,2),
  total_sga_mb2 number(10,2),
  total_sga_mb3 number(10,2),
  total_pga_mb1 number(10,2),
  total_pga_mb2 number(10,2),
  max_pga number(10,2)
);

insert into angel0404.t01_memory_areas (id,sample_date,redo_buffer_mb,buffer_cache_mb,
  shared_pool_mb,large_pool_mb,java_pool_mb,total_sga_mb1,total_sga_mb2,total_sga_mb3,
  total_pga_mb1,total_pga_mb2,max_pga) values (
    1,
    (select sysdate from dual),
    (select bytes/1048576 from v$sgainfo where name='Redo Buffers'),
    (select bytes/1048576 from v$sgainfo where name='Buffer Cache Size'),
    (select bytes/1048576 from v$sgainfo where name='Shared Pool Size'),
    (select bytes/1048576 from v$sgainfo where name='Large Pool Size'),
    (select bytes/1048576 from v$sgainfo where name='Java Pool Size'),
    (select
      trunc(
        (
          (select sum(value) from v$sga)-
          (select current_size from v$sga_dynamic_free_memory)
        )/1024/1024,2
      ) as memoria_sga_1 from dual),
    (select
      trunc(
        (
          (select sum(current_size) from v$sga_dynamic_components)+
          (select value from v$sga where name='Fixed Size')+
          (select value from v$sga where name='Redo Buffers')
        )/1024/1024,2
      ) as memoria_sga_2 from dual),
    (select
      trunc(
        (
          select sum(bytes) from v$sgainfo where name not in (
          'Granule Size','Maximum SGA Size','Startup overhead in Shared Pool',
          'Free SGA Memory Available','Shared IO Pool Size'
          )
        ) /1024/1024,2
      ) as memoria_sga_3 from dual),
    (select trunc(value/1024/1024,2) memoria_pga_1
      from v$pgastat where name ='aggregate PGA target parameter'),
    (select trunc(current_size/1024/1024,2) memoria_pga_2
      from v$sga_dynamic_free_memory),
    (select value/1048576 from v$pgastat where name='maximum PGA allocated'));

  select * from angel0404.t01_memory_areas;

  create table angel0404.t02_memory_param_values(
  id number(3),
  sample_date date,
  memory_target number(10,2),
  sga_target number(10,2),
  pga_aggregate_target number(10,2),
  shared_pool_size number(10,2),
  large_pool_size number(10,2),
  java_pool_size number(10,2),
  db_cache_size number(10,2)
);

insert into angel0404.t02_memory_param_values (id,sample_date,memory_target,sga_target,
  pga_aggregate_target,shared_pool_size,large_pool_size,java_pool_size,db_cache_size) values (
    1,
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

commit;

select * from  angel0404.t02_memory_param_values;