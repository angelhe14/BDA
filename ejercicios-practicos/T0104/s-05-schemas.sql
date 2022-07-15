connect angel0104/angel

create table t04_my_schema (
  username varchar2(128),
  schema_name varchar2(128)
);

grant insert on t04_my_schema to sys;
grant insert on t04_my_schema to public;
grant insert on t04_my_schema to sysbackup;


Prompt insertando datos con  angel0104 as sysdba
connect angel0104/angel as sysdba
insert into angel0104.t04_my_schema (username,schema_name)
values (
sys_context('USERENV','CURRENT_USER'),
sys_context('USERENV','CURRENT_SCHEMA')
);
commit;
Prompt insertando datos con angel0105 as sysdba
connect angel0105/angel as sysdba
insert into angel0105.t04_my_schema (username,schema_name)
values (
sys_context('USERENV','CURRENT_USER'),
sys_context('USERENV','CURRENT_SCHEMA')
);
commit;
Prompt insertando datos con angel0106 as sysdba
connect angel0106/angel as sysdba
insert into angel0106.t04_my_schema (username,schema_name)
values (
sys_context('USERENV','CURRENT_USER'),
sys_context('USERENV','CURRENT_SCHEMA')
);
commit;

connect sys/systen1 as sysdba

select USERNAME, SYSDBA, SYSOPER, SYSBACKUP, LAST_LOGIN
  from V$PWFILE_USERS;

alter user sys identified by system1;