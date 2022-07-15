connect sys/system2 as sysdba

set linesize window

create table angel0403.t01_redo_log_buffer(
  redo_buffer_size_param_mb number(10,5),
  redo_buffer_sga_info_mb number(10,7),
  resizeable VARCHAR2(3)
);

insert into angel0403.t01_redo_log_buffer(redo_buffer_size_param_mb,
  redo_buffer_sga_info_mb,resizeable) values (
  (select value/1048576 from v$parameter where name='log_buffer'),
  (select (bytes/1048576) from v$sgainfo where name='Redo Buffers'),
  (select resizeable from v$sgainfo where name='Redo Buffers'));

select * from angel0403.t01_redo_log_buffer;

