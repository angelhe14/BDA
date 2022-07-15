connect sys/system2 as sysdba

create table angel0204.t02_other_parameters(
  num number(5), 
  name varchar2(80),
  value varchar2(4000), 
  default_value varchar2(255),
  is_session_modifiable varchar2(5),
  is_system_modifiable varchar2(9));

insert into angel0204.t02_other_parameters(num,name,value,default_value,
  is_session_modifiable,is_system_modifiable)
  select num,name,value,default_value,
  is_session_modifiable,is_system_modifiable from v$system_parameter);