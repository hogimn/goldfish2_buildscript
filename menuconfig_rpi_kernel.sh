#!/bin/bash

CURRENT_PATH=$(pwd)
KERNEL_TOP_PATH=$CURRENT_PATH/..
KERNEL_PATH=$KERNEL_TOP_PATH/linux
OUTPUT=$KERNEL_TOP_PATH/out

# 4.9.3
TOOLPATH=$CURRENT_PATH/../bin/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin

echo "move to out directory"
cd $OUTPUT

echo "menuconfig"
make menuconfig \
	ARCH=arm CROSS_COMPILE=$TOOLPATH/arm-linux-gnueabihf-

cd $CURRENT_PATH
