#!/bin/bash

CURRENT_PATH=$(pwd)
KERNEL_TOP_PATH=$CURRENT_PATH/..
KERNEL_PATH=$KERNEL_TOP_PATH/linux
OUTPUT=$KERNEL_TOP_PATH/out
BUILD_LOG=$KERNEL_TOP_PATH/rpi_build_log.txt
KERNEL=kernel7
IS_DISTCLEAN=$1

# 4.9.3
TOOLPATH=$CURRENT_PATH/../bin/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin

echo "move to out directory"
cd $OUTPUT

if [ $IS_DISTCLEAN == "d" ]; then
	echo "kernel distclean"
	make distclean \
		ARCH=arm CROSS_COMPILE=$TOOLPATH/arm-linux-gnueabihf-
else
	echo "kernel clean"
	make clean \
		ARCH=arm CROSS_COMPILE=$TOOLPATH/arm-linux-gnueabihf-
fi

cd $CURRENT_PATH
