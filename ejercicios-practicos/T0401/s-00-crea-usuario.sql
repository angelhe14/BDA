connect sys/system2 as sysdba

create user angel0401 identified by angel
default tablespace users
quota unlimited on users;

grant connect, create table to angel0204;