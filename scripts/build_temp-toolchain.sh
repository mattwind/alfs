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

# Chapter 6. Cross Compiling Temporary Tools

# 6.2. M4-1.4.18
$ALFS/toolchain/m4.sh

# 6.3. Ncurses-6.2
$ALFS/toolchain/ncurses.sh

# 6.4. Bash-5.0
$ALFS/toolchain/bash.sh

# 6.5. Coreutils-8.32
$ALFS/toolchain/coreutils.sh

# 6.6. Diffutils-3.7
$ALFS/toolchain/diffutils.sh

# 6.7. File-5.39
$ALFS/toolchain/file.sh

# 6.8. Findutils-4.7.0
$ALFS/toolchain/findutils.sh

# 6.9. Gawk-5.1.0
$ALFS/toolchain/gawk.sh

# 6.10. Grep-3.4
$ALFS/toolchain/grep.sh

# 6.11. Gzip-1.10
$ALFS/toolchain/gzip.sh

# 6.12. Make-4.3
$ALFS/toolchain/make.sh

# 6.13. Patch-2.7.6
$ALFS/toolchain/patch.sh

# 6.14. Sed-4.8
$ALFS/toolchain/sed.sh

# 6.15. Tar-1.32
$ALFS/toolchain/tar.sh

# 6.16. Xz-5.2.5
$ALFS/toolchain/xz.sh

# 6.17. Binutils-2.35 - Pass 2
$ALFS/toolchain/binutils-pass-2.sh

# 6.18. GCC-10.2.0 - Pass 2
$ALFS/toolchain/gcc-pass-2.sh

echo
echo "Temp Toolchain completed."
echo

