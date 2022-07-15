connect sys/system2 as sysdba

create user angel0501 identified by angel
default tablespace users
quota unlimited on users;

grant connect, create table, create sequence, create procedure to angel0501;