#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=XML-Parser-2.46.tar.gz
SRC_FOLDER=XML-Parser-2.46

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

perl Makefile.PL
make
#make test
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
