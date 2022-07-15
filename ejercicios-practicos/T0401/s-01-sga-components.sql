connect sys/system2 as sysdba

create table angel0401.t01_sga_components(
  memory_target_param number(10,2),
  fixed_size number(10,2),
  variable_size number(10,2),
  database_buffers number(10,2),
  redo_buffers number(10,2),
  total_sga number(10,2)
);

insert into angel0401.t01_sga_components(memory_target_param,fixed_size,variable_size,database_buffers,
  redo_buffers,total_sga) values(
    (select round((value/1048576),2) from v$system_parameter  where name='memory_target'),
    (select round((value/1048576),2) from v$SGA where name='Fixed Size'),
    (select round((value/1048576),2) from v$SGA where name='Variable Size'),
    (select round((value/1048576),2) from v$SGA where name='Database Buffers'),
    (select round((value/1048576),2) from v$SGA where name='Redo Buffers'),
    (select round((sum(value/1048576)),2) from v$SGA));


create table angel0401.t02_sga_dynamic_components(
  component_name varchar2(64),
  current_size_mb number(10,2),
  operation_count number(10,0),
  last_operation_type varchar2(13),
  last_operation_time date
);

insert into angel0401.t02_sga_dynamic_components(component_name,current_size_mb,operation_count,
  last_operation_type,last_operation_time)
  select COMPONENT,round((CURRENT_SIZE/1048576),2),OPER_COUNT,LAST_OPER_TYPE,
  to_char(LAST_OPER_TIME, 'dd/mm/yyyy hh:mm:ss') from v$sga_dynamic_components
  ORDER BY CURRENT_SIZE DESC;


create table angel0401.t03_sga_max_dynamic_component(
  component_name varchar2(64),
  current_size_mb number(10,2)
  );

insert into angel0401.t03_sga_max_dynamic_component(component_name,current_size_mb)
  select COMPONENT,round((CURRENT_SIZE/1048576),2) from v$sga_dynamic_components
  where CURRENT_SIZE = (select MAX(CURRENT_SIZE) from v$sga_dynamic_components);


create table angel0401.t04_sga_min_dynamic_component(
  component_name varchar2(64),
  current_size_mb number(10,2)
);

insert into angel0401.t04_sga_min_dynamic_component(component_name,current_size_mb)
  select COMPONENT,round((CURRENT_SIZE/1048576),2) from v$sga_dynamic_components  
  where CURRENT_SIZE = (select MIN(CURRENT_SIZE) from v$sga_dynamic_components where current_size>0);


create table angel0401.t05_sga_memory_info(
  name varchar2(64),
  current_size_mb number(10,2)
);

insert into angel0401.t05_sga_memory_info(name,current_size_mb)
  select name, round((bytes/1048576),2) from v$sgainfo
  where name = 'Maximum SGA Size';

insert into angel0401.t05_sga_memory_info(name,current_size_mb)
  select name, round((bytes/1048576),2) from v$sgainfo
  where name = 'Free SGA Memory Available';


create table angel0401.t06_sga_resizeable_components(
  name varchar2(64)
);

insert into angel0401.t06_sga_resizeable_components(name)
  select name from v$sgainfo
  where RESIZEABLE = 'Yes';

commit;


create table angel0401.t07_sga_resize_ops(
  component varchar2(64),
  oper_type varchar2(13),
  parameter varchar2(30),
  initial_size_mb number(10,2),
  target_size_mb number(10,2),
  final_size_mb number(10,2),
  increment_mb number(10,2),
  status varchar2(15),
  start_time date,
  end_time date
);

insert into angel0401.t07_sga_resize_ops(component,oper_type,parameter,initial_size_mb,
  target_size_mb,final_size_mb,increment_mb,status,start_time,end_time)
  select COMPONENT,OPER_TYPE,PARAMETER,round((INITIAL_SIZE/1048576),2),round((TARGET_SIZE/1048576),2),
  round((FINAL_SIZE/1048576),2),round(((FINAL_SIZE-TARGET_SIZE)/1048576),2),STATUS,TO_DATE(START_TIME, 'dd/mm/yyyy  hh24:mi:ss'),
  TO_DATE(END_TIME, 'dd/mm/yyyy  hh24:mi:ss') from v$sga_resize_ops
  where COMPONENT IN ('DEFAULT buffer cache', 'Shared IO Pool', 'java pool', 'large pool', 'shared pool')
  ORDER BY component ASC, end_time ASC;

