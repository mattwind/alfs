#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=sed-4.8.tar.xz
SRC_FOLDER=sed-4.8

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

./configure --prefix=/usr --bindir=/bin
make
make html

# TEST
#chown -Rv tester .
#su tester -c "PATH=$PATH make check"

make install
install -d -m755           /usr/share/doc/sed-4.8
install -m644 doc/sed.html /usr/share/doc/sed-4.8

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
