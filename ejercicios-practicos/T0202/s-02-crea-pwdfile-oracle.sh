export ORACLE_SID=sahlbda2


echo "generando archivo de passwords"
orapwd FILE='${ORACLE_HOME}/dbs/orapwsahlbda2' FORCE=Y FORMAT=12.2 \
  SYS=password 

echo "Revisando el nuevo archivo"
ls -l $ORACLE_HOME/dbs/orapwsahlbda2