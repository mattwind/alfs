#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=inetutils-1.9.4.tar.xz
SRC_FOLDER=inetutils-1.9.4

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

sed -i 's:\\\${:\\\$\\{:' intltool-update.in

./configure --prefix=/usr

make
#make check
make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
