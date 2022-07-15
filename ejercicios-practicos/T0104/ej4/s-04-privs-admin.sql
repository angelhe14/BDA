connect sys/Hola1234# as sysdba

grant sysdba to angel0104;

create user angel0105 identified by angel;
grant connect to angel0105;
grant sysoper to angel0105;

create user angel0106 identified by angel;
grant connect to angel0106;
grant sysbackup to angel0106;
