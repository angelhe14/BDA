connect sys/system2 as sysdba

exec dbms_connection_pool.stop_pool();
exec dbms_connection_pool.restore_defaults();