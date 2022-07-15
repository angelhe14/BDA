connect sys/system2 as sysdba

--Modificacion nls_date_format (a)
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
--Moificacion db_writer_processes (b)
alter system set db_writer_processes=2 scope=spfile;
--Modifiacion log_buffer (c)
alter system set log_buffer=10485760 scope=spfile;
--Modificacion db_files (d)
alter system set db_files=250 scope=spfile;
--Modificacion dml_locks (e)
alter system set dml_locks=2500 scope=spfile;
-- Modificacion transactions (f)
alter system set transactions=600 scope=spfile;
--
alter system set hash_area_size= 2097152 scope=both;
--Modificacion sort_area_size (h)
alter session set sort_area_size= 1048576;
--Modificacion sql_trace (i)
alter system set sql_trace=true scope=memory;
--Modificacion optimizer_mode (j)
alter system set optimizer_mode=FIRST_ROWS_100 scope=both;

alter session set cursor_invalidation= DEFERRED;


--parámetros modificados en la sesión del usuario
create table angel0204.t03_update_param_session as
select name,value
from v$parameter
where name in (
'cursor_invalidation','optimizer_mode',
'sql_trace','sort_area_size','hash_area_size','nls_date_format',
'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
)
and value is not null;

--parámetros modificados a nivel instancia 
create table angel0204.t04_update_param_instance as
select name,value
from v$system_parameter
where name in (
'cursor_invalidation','optimizer_mode',
'sql_trace','sort_area_size','hash_area_size','nls_date_format',
'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
)
and value is not null;

--parámetros modificados en spfile 
create table angel0204.t05_update_param_spfile as
select name,value
from v$spparameter
where name in (
'cursor_invalidation','optimizer_mode',
'sql_trace','sort_area_size','hash_area_size','nls_date_format',
'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
)
and value is not null;

create pfile='/tmp/e-03-spparameter-pfile.txt' from spfile;
