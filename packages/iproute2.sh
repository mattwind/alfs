#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=iproute2-5.8.0.tar.xz
SRC_FOLDER=iproute2-5.8.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8
sed -i 's/.m_ipt.o//' tc/Makefile
make
make DOCDIR=/usr/share/doc/iproute2-5.8.0 install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
