connect sys/system2 as sysdba

create pfile='/tmp/e-02-spparameter-pfile.txt.' from spfile;

create user angel0204 identified by angel
default tablespace users
quota users on system;

grant connect, create table, create procedure, create sequence to angel0204;

create table angel0204.t01_spparameters(
  name varchar2(80) not null,
  value varchar2(255) not null);

insert into angel0204.t01_spparameters(name, value)
values ( (select name from v$spparameter),
 (select value from v$spparameter));

