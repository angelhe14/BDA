connect sys/system1 as sysdba

drop user angel0201 cascade;

create user angel0201 identified by angel
default tablespace system
quota 100M on system;

grant connect to angel0201;

create table angel0201.database_info(
instance_name varchar2(16),
db_domain varchar2(20),
db_charset varchar2(15),
sys_timestamp varchar2(40),
timezone_offset varchar2(10),
db_block_size_bytes number(5,0),
os_block_size_bytes number(5,0),
redo_block_size_bytes number(5,0),
total_components number(5,0),
total_components_mb number(10,2),
max_component_name varchar2(30),
max_component_desc varchar2(64),
max_component_mb number(10,0)
);


insert into angel0201.database_info(instance_name,db_domain,db_charset,sys_timestamp,
  timezone_offset,db_block_size_bytes,os_block_size_bytes,redo_block_size_bytes,
  total_components,total_components_mb,max_component_name,max_component_desc,max_component_mb) values (
    --instance_name
    (select instance_name from v$instance),
    --db_domain
    (select value from v$parameter where name='db_domain'),
    --db_charset
    (select value from nls_database_parameters where parameter = 'NLS_CHARACTERSET'),
    --sys_timestamp
    (select systimestamp from dual),
    --timezome_offset
    (select tz_offset((select sessiontimezone from dual)) from dual),
    --db_block_size_bytes
    (select value from v$parameter where name = 'db_block_size'),
    --os_block_size_bytes
    '4096',
    --redo_block_size_bytes
    (select sum(blocksize) from v$log),
    --total_components
    (select count(occupant_name) from v$sysaux_occupants),
    --total_components_mb
    (select round((sum(SPACE_USAGE_KBYTES/1024)),2) from v$sysaux_occupants),
    --max_component_name
    (select occupant_name from v$sysaux_occupants
      where SPACE_USAGE_KBYTES = (select MAX(SPACE_USAGE_KBYTES) from v$sysaux_occupants)),
    --max_component_desc
    (select occupant_desc from v$sysaux_occupants
      where SPACE_USAGE_KBYTES = (select MAX(SPACE_USAGE_KBYTES) from v$sysaux_occupants)),
    --max_component_mb
    (select round((MAX(SPACE_USAGE_KBYTES)/1024),2) from v$sysaux_occupants));
commit;

Prompt mostrando datos parte 1
set linesize window
select instance_name,db_domain,db_charset,sys_timestamp,timezone_offset
  from angel0201.database_info;

Prompt mostrando datos parte 2
select db_block_size_bytes,os_block_size_bytes,redo_block_size_bytes,
total_components,total_components_mb
  from angel0201.database_info;

Prompt mostrando datos parte 3;
select max_component_name,max_component_desc,max_component_mb
  from angel0201.database_info;
