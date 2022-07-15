connect sys/system2 as sysdba

create user angel0402 identified by angel
default tablespace users
quota unlimited on users;

grant connect, create table, create sequence to angel0402;
