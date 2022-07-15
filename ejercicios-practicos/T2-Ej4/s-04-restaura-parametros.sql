connect sys/system2 as sysdba

shutdown 

create spfile='/u01/oracle/dbs/test_spfile.ora'
  from pfile='/unam-bda///e-02-spparameter-pfile.txt';

startup


