#!/bin/bash
# default pwd is root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=shadow-4.8.1.tar.xz
SRC_FOLDER=shadow-4.8.1

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;

sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD SHA512:' \
    -e 's:/var/spool/mail:/var/mail:'                 \
    -i etc/login.defs

sed -i 's/1000/999/' etc/useradd

touch /usr/bin/passwd
./configure --sysconfdir=/etc \
            --with-group-name-max-length=32

make
make install

pwconv
grpconv

sed -i 's/yes/no/' /etc/default/useradd

echo 'root:root' | chpasswd

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
