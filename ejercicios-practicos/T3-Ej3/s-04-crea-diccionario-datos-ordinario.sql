--@Autor Sergio Ángel Hernández Luis
--@Fecha 05/03/2022
--@Descripcion Creación de un PFILE

connect sys/system2 as sysdba

@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

connect system/system2 
@?/sqlplus/admin/pupbld.sql

