connect sys/system2 as sysdba

set linesize window
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

create table angel0501.t01_session_data(
  id number(2),
  SID number(5),
  logon_time date,
  username VARCHAR2(128),
  status VARCHAR2(8),
  server VARCHAR2(9),
  osuser VARCHAR2(128),
  machine VARCHAR2(64),
  type VARCHAR2(10),
  process VARCHAR2(24),
  port number(10)
);

insert into angel0501.t01_session_data(id,SID,logon_time,username,
  status,server,osuser,machine,type,process,port)
  select 1 id, SID,LOGON_TIME,USERNAME,STATUS,SERVER,OSUSER,MACHINE,
    TYPE,PROCESS,PORT from v$session
    where username='SYS' and type ='USER';
commit;

connect sys@SAHLBDA2_DEDICATED/system2 as sysdba

insert into angel0501.t01_session_data(id,SID,logon_time,username,
  status,server,osuser,machine,type,process,port)
  select 2 id, SID,LOGON_TIME,USERNAME,STATUS,SERVER,OSUSER,MACHINE,
    TYPE,PROCESS,PORT from v$session
    where username='SYS' and type ='USER';
commit;

connect sys@SAHLBDA2_SHARED/system2 as sysdba

insert into angel0501.t01_session_data(id,SID,logon_time,username,
  status,server,osuser,machine,type,process,port)
  select 3 id, SID,LOGON_TIME,USERNAME,STATUS,SERVER,OSUSER,MACHINE,
    TYPE,PROCESS,PORT from v$session
    where username='SYS' and type ='USER';
commit;