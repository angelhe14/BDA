connect sys/system2 as sysdba

alter system set dispatchers='(dispatchers=2)(protocol=tcp)' scope=memory;
alter system set shared_servers=4 scope=memory;

show parameter dispatchers
show parameter shared_servers

alter system register; 
lsnrctl services


