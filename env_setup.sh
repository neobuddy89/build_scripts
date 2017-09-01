#!/bin/bash

# Colorize and add text parameters
export red=$(tput setaf 1)             #  red
export grn=$(tput setaf 2)             #  green
export blu=$(tput setaf 4)             #  blue
export cya=$(tput setaf 6)             #  cyan
export txtbld=$(tput bold)             #  Bold
export bldred=${txtbld}$(tput setaf 1) #  red
export bldgrn=${txtbld}$(tput setaf 2) #  green
export bldblu=${txtbld}$(tput setaf 4) #  blue
export bldcya=${txtbld}$(tput setaf 6) #  cyan
export txtrst=$(tput sgr0)             #  Reset

# Set Target
TARGET="shamu"

# Set Kernel Name
KNAME="sigmaKernel"

export KERNELDIR=`readlink -f .`;
export PARENT_DIR=`readlink -f ${KERNELDIR}/..`;
export INITRAMFS_SOURCE=`readlink -f $PARENT_DIR/../ramdisks/shamu-n`;
export INITRAMFS_TMP=${KERNELDIR}/tmp/initramfs_source;

# Kernel
export ARCH=arm;
export SUB_ARCH=arm;
export KERNEL_CONFIG_SHAMU="shamu_defconfig";

# Check if parallel installed, if not install
if [ ! -e /usr/bin/parallel ]; then
	echo "You must install 'parallel' to continue.";
	sudo apt-get install parallel
fi

# Check if ccache installed, if not install
if [ ! -e /usr/bin/ccache ]; then
	echo "You must install 'ccache' to continue.";
	sudo apt-get install ccache
fi

# check if adb installed, if not install
if [ ! -e /usr/bin/adb ]; then
	echo "You must install 'adb' to continue.";
	sudo apt-get install android-tools-adb
fi

# Build script
export USER=`whoami`;
export KBUILD_BUILD_USER="NeoBuddy89";
export KBUILD_BUILD_HOST="DragonCore";

# Compiler
export CROSS_COMPILE=$PARENT_DIR/../toolchains/arm-eabi-4.9-google/bin/arm-eabi-;
#export CROSS_COMPILE=$PARENT_DIR/../toolchains/arm-eabi-6.x/bin/arm-eabi-;
#export CROSS_COMPILE=$PARENT_DIR/../toolchains/arm-linux-gnueabi-6.3.1-linaro/bin/arm-linux-gnueabi-;
#export CROSS_COMPILE=$PARENT_DIR/../toolchains/arm-linaro-linux-gnueabi-linaro-7.x/bin/arm-linaro-linux-gnueabi-;

# Add extra libs for the compilers to use
export LD_LIBRARY_PATH=$TARGET_ARCH_LIB_PATH:$LD_LIBRARY_PATH
export LIBRARY_PATH=$TARGET_ARCH_LIB_PATH:$LIBRARY_PATH

if [ ! -f ${CROSS_COMPILE}gcc ]; then
	echo "${bldred}Cannot find GCC compiler ${CROSS_COMPILE}gcc${txtrst}";
	echo "${bldcya}Please ensure you have GCC Compiler at path mentioned in env_setup.sh and then you can continue.${txtrst}";
	exit 1;
fi

if [ ! ${TARGET} == '' ] && 
	[ ! -f ${INITRAMFS_SOURCE}/init ]; then
	echo "${bldred}Cannot find proper ramdisk at ${INITRAMFS_SOURCE}. ${txtrst}";
	echo "${bldcya}Please ensure you have RAMDISK at path mentioned in env_setup.sh and then you can continue.${txtrst}";
	exit 1;
fi

export NUMBEROFCPUS=`grep 'processor' /proc/cpuinfo | wc -l`;
