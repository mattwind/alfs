#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=iana-etc-20200821.tar.gz
SRC_FOLDER=iana-etc-20200821

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

cp services protocols /etc

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE

