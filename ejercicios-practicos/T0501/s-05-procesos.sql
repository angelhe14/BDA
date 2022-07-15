connect sys@SAHLBDA2_POOLED/system2 as sysdba

set linesize window

insert into angel0501.t01_session_data(id,SID,logon_time,username,
  status,server,osuser,machine,type,process,port)
  select 4 id, SID,LOGON_TIME,USERNAME,STATUS,SERVER,OSUSER,MACHINE,
    TYPE,PROCESS,PORT from v$session
    where username='SYS' and type ='USER';

create table angel0501.t07_foreground_process(
  sosid VARCHAR2(24),
  pname VARCHAR2(5),
  os_username VARCHAR2(128),
  bd_username VARCHAR2(128),
  server VARCHAR2(9),
  pga_max_mem_mb number(10,2),
  tracefile VARCHAR2(513)
);

insert into angel0501.t07_foreground_process(sosid,pname,os_username,bd_username,
  server,pga_max_mem_mb,tracefile) 
  (select p.sosid sosid, p.pname pname, s.osuser os_username, s.username bd_username, s.server server,
    round(p.pga_max_mem/(1024*1024),2) pga_max_mem_mb, p.tracefile
  from v$process p left outer join v$session s on p.addr=s.paddr where p.background is null);

create table angel0501.t08_f_process_actual(
  sosid VARCHAR2(24),
  pname VARCHAR2(5),
  os_username VARCHAR2(128),
  bd_username VARCHAR2(128),
  server VARCHAR2(9),
  pga_max_mem_mb number(10,2),
  tracefile VARCHAR2(513)
);

insert into angel0501.t08_f_process_actual(sosid,pname,os_username,bd_username,
  server,pga_max_mem_mb,tracefile) 
  (select p.sosid sosid, p.pname pname, s.osuser os_username, s.username bd_username, s.server server,
    round(p.pga_max_mem/(1024*1024),2) pga_max_mem_mb, P.tracefile
  from v$process p left outer join v$session s on p.addr=s.paddr where sys_context('USERENV','SID') = s.sid);

create table angel0501.t09_background_process(
  sosid VARCHAR2(24),
  pname VARCHAR2(5),
  os_username VARCHAR2(128),
  bd_username VARCHAR2(128),
  server VARCHAR2(9),
  pga_max_mem_mb number(10,2),
  tracefile VARCHAR2(513)
);

insert into angel0501.t09_background_process(sosid,pname,os_username,bd_username,
  server,pga_max_mem_mb,tracefile) 
  (select p.sosid sosid, p.pname pname, s.osuser os_username, s.username bd_username, s.server server,
    round(p.pga_max_mem/(1024*1024),2) pga_max_mem_mb, P.tracefile
  from v$process p left outer join v$session s on p.addr=s.paddr where p.background is not null);