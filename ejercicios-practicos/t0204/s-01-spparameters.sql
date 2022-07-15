--@Autor Sergio Ángel Hernández Luis
--@Fecha 17/03/2022
--@Descripcion: Este script permite obtener los parámetros de la 
--BD a partir de la instrucción create pfile, además, crea una 
--tabla con los parámetros de v$spparameter.

connect sys/system2 as sysdba

create pfile='/tmp/e-02-spparameter-pfile.txt.' from spfile;

create user angel0204 identified by angel
default tablespace users
quota unlimited on users;

grant connect, create table, create procedure, create sequence to angel0204;

create table angel0204.t01_spparameters(
  name varchar2(80) not null,
  value varchar2(255) not null);

insert into angel0204.t01_spparameters(name,value)
select name,value from v$spparameter
where name is not null and value is not null;

