connect sys/system2 as sysdba

create table angel0402.t01_db_buffer_cache(
  block_size number(5),
  current_size number(10,2),
  buffers number(5),
  target_buffers number(5),
  prev_size number(5),
  prev_buffers number(5),
  default_pool_size number(10,2)
);

insert into angel0402.t01_db_buffer_cache(block_size,current_size,buffers,target_buffers,prev_size,
prev_buffers,default_pool_size) values(
    (select BLOCK_SIZE from v$buffer_pool),
    (select CURRENT_SIZE from v$buffer_pool),
    (select BUFFERS from v$buffer_pool),
    (select TARGET_BUFFERS from v$buffer_pool),
    (select PREV_SIZE from v$buffer_pool),
    (select PREV_BUFFERS from v$buffer_pool),
    (select value from v$parameter where name = 'db_cache_size'));


create table angel0402.t02_db_buffer_sysstats(
  db_blocks_gets_from_cache number(10),
  consistent_gets_from_cache number(10),
  physical_reads_cache number(10),
  cache_hit_radio number(15,6)
  );


insert into angel0402.t02_db_buffer_sysstats(db_blocks_gets_from_cache,consistent_gets_from_cache,
physical_reads_cache) values(
    (select value from v$sysstat 
      where name ='db block gets from cache'),
    (select value from v$sysstat 
      where name ='consistent gets from cache'),
    (select value from v$sysstat 
      where name ='physical reads cache'));
    --(select round(1-((select value from v$sysstat 
    --where name ='physical reads cache')/((select value from v$sysstat 
     -- where name ='db block gets from cache')+(select value from v$sysstat 
     -- where name ='consistent gets from cache'))),6) 
   -- from v$sysstat));


--ALTER TABLE angel0402.t02_db_buffer_sysstats
--ADD  cache_hit_radio number(15,6);

update angel0402.t02_db_buffer_sysstats
set cache_hit_radio = (select round(1-(physical_reads_cache/(db_blocks_gets_from_cache+consistent_gets_from_cache)),6)
from angel0402.t02_db_buffer_sysstats);
--where DB_BLOCKS_GETS_FROM_CACHE = (select value from v$sysstat 
  --    where name ='db block gets from cache'));

select * from angel0402.t02_db_buffer_sysstats;
