#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=bash-5.0.tar.gz
SRC_FOLDER=bash-5.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

patch -Np1 -i ../bash-5.0-upstream_fixes-1.patch

./configure --prefix=/usr                    \
            --docdir=/usr/share/doc/bash-5.0 \
            --without-bash-malloc            \
            --with-installed-readline

make

# TEST
# chown -Rv tester .
#su tester << EOF
#PATH=$PATH make tests < $(tty)
#EOF

make install
mv -vf /usr/bin/bash /bin

# Run new bash will break current alfs-script
#exec /bin/bash --login +h

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
