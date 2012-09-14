#!/bin/bash

export ARCH=arm
# Edit the following line to set the path to arm-eabi-4.4.3
export CROSS_COMPILE=/opt/toolchains/arm-eabi-4.4.3/bin/arm-eabi-

# Edit next line to reflect desired host name
export CONFIG_DEFAULT_HOSTNAME=

# Determines the number of available logical processors and sets the work thread accordingly
export JOBS=`grep 'processor' /proc/cpuinfo | wc -l`

# Edit this to change the kernel name
export KBUILD_BUILD_VERSION=

# Check for a log directory in ~/ and create if its not there
[ -d ~/logs ] || mkdir -p ~/logs

# Build entire kernel and create build log
make cyanogen_d2spr_defconfig
make headers_install
make -$jobs zImage 2>&1 | tee ~/logs/cyanogen_d2spr.txt

# Creates boot.img assuming ramdisk is available in $pwd/mkboot
cp arch/arm/boot/zImage mkboot
cd mkboot
. img.sh

# Uncomment next line to open build log once kernel has finished.
# gedit ~/logs/cyanogen_d2spr.txt
