connect sys@SAHLBDA2_SHARED/system2 as sysdba

set linesize window

create table angel0501.t02_dispatcher_config(
  id number(2),
  dispatchers number(3),
  connections number(10),
  sessions number(10),
  service VARCHAR2(512)
);

insert into angel0501.t02_dispatcher_config(id,dispatchers,connections,
  sessions,service)
  select 1 id, dispatchers,connections,sessions,service from v$dispatcher_config;

create table angel0501.t03_dispatcher(
  name VARCHAR2(4),
  network VARCHAR2(1024),
  status VARCHAR2(16),
  messages number(10),
  messages_mb number(10,2),
  circuits_created number(5),
  idle_min number(10,2),
  id number(3)
);

insert into angel0501.t03_dispatcher(name,network,status,messages,messages_mb,
  circuits_created,idle_min,id)
  select name,network,status,messages,round((bytes/1048576),2),created,
    round((idle/60),2), 1 id from v$dispatcher;

create table angel0501.t04_shared_server(
  id number(2),
  name VARCHAR2(4),
  status VARCHAR2(16),
  messages number(10),
  messages_mb number(10,2),
  requests number(5),
  idle_min number(10,2),
  busy_min number(10,2)
);

insert into angel0501.t04_shared_server(id,name,status,messages,messages_mb,
  requests,idle_min,busy_min)
  select 1 id,name,status,messages,round((bytes/1048576),2),requests,
    round((idle/60),2),round((busy/60),2) from v$shared_server;

create table angel0501.t05_queue(
  id number(2),
  queued number(5),
  wait number(5),
  totalq number(5)
);

insert into angel0501.t05_queue(id,queued,wait,totalq)
  select 1 id,queued,wait,totalq from v$queue;

create table angel0501.t06_virtual_circuit(
  id number(2),
  circuit VARCHAR2(50),
  name VARCHAR2(4),
  server VARCHAR2(50),
  status VARCHAR2(16),
  queue VARCHAR2(16)
);

--create table angel0501.t06_virtual_circuit as
insert into angel0501.t06_virtual_circuit(id,circuit,name,server,status,queue) 
  select 1 id, c.circuit, d.name, c.server, c.status, c.queue 
    from v$circuit c join v$dispatcher d on c.dispatcher=d.PADDR;

