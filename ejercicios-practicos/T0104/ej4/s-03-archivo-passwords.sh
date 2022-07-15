#!/bin/bash
#@
#
#

cp "${ORACLE_HOME}/dbs/orapwsahlbda1" "/home/${USER}/backups/orapwsahlbda1.bak"
echo "Copiado exitoso"

#rm -rf ${ORACLE_HOME}/dbs/orapwsahlbda1
#echo Archivo de passwords borrado


echo "generando archivo de passwords"
orapwd FILE='${ORACLE_HOME}/dbs/orapwsahlbda1' FORCE=Y FORMAT=12.2 \
  SYS=password \
  SYSBACKUP=password

echo "Revisando el nuevo archivo"
ls -l $ORACLE_HOME/dbs/orapwsahlbda1
