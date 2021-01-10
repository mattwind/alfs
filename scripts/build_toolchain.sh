#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        echo "su lfs -"
        exit 255
fi

if [ -z ${LFS} ]
  then echo "LFS is not defined. example; export LFS=/mnt/lfs"
  exit
fi

if mount | grep /mnt/lfs > /dev/null; then
  echo
  echo "LFS mount found."
  echo
else
  echo
  echo "No LFS partition found at /mnt/lfs."
  echo
  echo "Check out README.md"
  echo
  exit
fi

# 5.2. Binutils-2.35 - Pass 1
$ALFS/toolchain/binutils-pass-1.sh

# 5.3. GCC-10.2.0 - Pass 1
$ALFS/toolchain/gcc-pass-1.sh

# 5.4. Linux-5.8.3 API Headers
$ALFS/toolchain/linux-api-headers.sh

# 5.5. Glibc-2.32
$ALFS/toolchain/glbic.sh

# 5.6. Libstdc++ from GCC-10.2.0, Pass 1
$ALFS/toolchain/libstd-pass-1.sh

echo
echo "Done"
echo

