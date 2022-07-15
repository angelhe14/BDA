#!/bin/bash

# @Autor: Hernández Luis Sergio Ángel 
# @Fecha: 05/03/2022
# @Descripcion: Este script permite descargar N imágenes mediante un archivo 
#               de texto que contenga las URL's de las mismas. Asimismo, crea un archivo
#               comprimido en donde guardará los archivos descargados.  


sudo su

mkdir /unam-bda/disk-images
cd /unam-bda
chmod 755 disk-images
chown angel:angel disk-images
cd disk-images

dd if=/dev/zero of=disk1.img bs=100M count=10
dd if=/dev/zero of=disk2.img bs=100M count=10
dd if=/dev/zero of=disk3.img bs=100M count=10

du -sh disk*.img

losetup -fP disk1.img
losetup -fP disk2.img
losetup -fP disk3.img

losetup -a

mkfs.ext4 disk1.img
mkfs.ext4 disk2.img
mkfs.ext4 disk3.img

mkdir /unam-bda/d01
mkdir /unam-bda/d02
mkdir /unam-bda/d03

