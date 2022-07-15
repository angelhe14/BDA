connect sys/system2 as sysdba

set linesize window

create table angel0403.t02_shared_pool(
  shared_pool_param_mb number(10,5),
  shared_pool_sga_info_mb number(10,2),
  resizeable VARCHAR2(3),
  shared_pool_component_total number(10),
  shared_pool_free_memory number(13,10)
);

insert into angel0403.t02_shared_pool(shared_pool_param_mb,shared_pool_sga_info_mb,
  resizeable,shared_pool_component_total,shared_pool_free_memory) values (
  (select value/1048576 from v$parameter where name='shared_pool_size'),
  (select bytes/1048576 from v$sgainfo where name='Shared Pool Size'),
  (select resizeable from v$sgainfo where name='Shared Pool Size'),
  (select count(pool) from v$sgastat where pool='shared pool'),
  (select bytes/1048576 from v$sgastat 
  where name='free memory' and pool='shared pool'));

select * from angel0403.t02_shared_pool;

create table angel0403.t03_library_cache_hist(
  id number(3),
  RELOADS number(10),
  INVALIDATIONS number(10),
  PINS number(10),
  PINHITS number(10),
  PINHITRATIO number(10)
);


insert into angel0403.t03_library_cache_hist(id,reloads,invalidations,pins,
pinhits,pinhitratio)
select 1 id, reloads,invalidations,pins,pinhits,pinhitratio
from v$librarycache
where namespace='SQL AREA';

--insert into angel0403.t03_library_cache_hist(id,RELOADS,INVALIDATIONS,
  --PINS,PINHITS,PINHITRATIO) values(
  --1,
  --(select RELOADS from v$librarycache where NAMESPACE='SQL AREA'),
  --(select INVALIDATIONS from v$librarycache where NAMESPACE='SQL AREA'),
  --(select PINS from v$librarycache where NAMESPACE='SQL AREA'),
  --(select PINHITS from v$librarycache where NAMESPACE='SQL AREA'),
  --(select PINHITRATIO from v$librarycache where NAMESPACE='SQL AREA'));


select * from angel0403.t03_library_cache_hist;

create table angel0403.test_orden_compra(id number);

Prompt ejecutando consultas con sentencias sql estáticas
set timing on
declare
  orden_compra angel0403.test_orden_compra%rowtype;
begin
    for i in 1 .. 50000 loop
      begin
        execute immediate
          'select * from angel0403.test_orden_compra where id = ' || i
          into orden_compra;
      exception
        when no_data_found then
          null;
      end;
    end loop;
end;
/
set timing off

Prompt capturando nuevamente estadísticas del library cache
insert into angel0403.t03_library_cache_hist(id,reloads,invalidations,pins,
pinhits,pinhitratio)
select 2 id, reloads,invalidations,pins,pinhits,pinhitratio
from v$librarycache
where namespace='SQL AREA';
commit;

shutdown 
startup

insert into angel0403.t03_library_cache_hist(id,reloads,invalidations,pins,
pinhits,pinhitratio)
select 3 id, reloads,invalidations,pins,pinhits,pinhitratio
from v$librarycache
where namespace='SQL AREA';
commit;

set timing on
declare
  orden_compra angel0403.test_orden_compra%rowtype;
begin
    for i in 1 .. 50000 loop
      begin
        execute immediate
          'select * from angel0403.test_orden_compra where id = :ph1 '
          into orden_compra
          using i;
      exception
        when no_data_found then
          null;
      end;
    end loop;
end;
/
set timing off

insert into angel0403.t03_library_cache_hist(id,reloads,invalidations,pins,
pinhits,pinhitratio)
select 4 id, reloads,invalidations,pins,pinhits,pinhitratio
from v$librarycache
where namespace='SQL AREA';
commit;

select * from angel0403.t03_library_cache_hist;