#!/bin/bash
#@Autor: Hernández Luis Sergio Ángel
#@Fecha: 05/03/2022
#@Descripcion: Este script permite crear un nuevo archivo de
# passwords, en donde se ingresará la contraseña hola1234* para
# SYS


export ORACLE_SID=sahlbda2
cd /u01/app/oracle/oradata
mkdir ${ORACLE_SID^^}
chown oracle:oinstall ${ORACLE_SID^^}
chmod 750 ${ORACLE_SID^^}

cd /unam-bda/d01
mkdir -p app/oracle/oradata/SAHLBDA2
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda/d02
mkdir -p app/oracle/oradata/SAHLBDA2
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda/d03
mkdir -p app/oracle/oradata/SAHLBDA2
chown -R oracle:oinstall app
chmod -R 750 app

echo "Mostrando directorio de data files"
ls -l /u01/app/oracle/oradata
echo "Mostrando directorios para control files y Redo Logs"
ls -l /unam-bda/d0*/app/oracle/oradata

