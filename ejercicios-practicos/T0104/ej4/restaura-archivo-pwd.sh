#!/bin/bash
#@
#
#

echo "generando archivo de passwords"
orapwd FILE='${ORACLE_HOME}/dbs/orapwsahlbda1'
  SYS=password \
  SYSBACKUP=password

echo "Revisando el nuevo archivo"
ls -l $ORACLE_HOME/dbs/orapwsahlbda1
