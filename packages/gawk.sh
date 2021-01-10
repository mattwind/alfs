#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=gawk-5.1.0.tar.xz
SRC_FOLDER=gawk-5.1.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr
make
#make check
make install

mkdir -v /usr/share/doc/gawk-5.1.0
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.1.0

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
