#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=flex-2.6.4.tar.gz
SRC_FOLDER=flex-2.6.4

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.6.4

make
#make check
make install

ln -sv flex /usr/bin/lex

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
