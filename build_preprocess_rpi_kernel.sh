#!/bin/bash

CURRENT_PATH=$(pwd)
KERNEL_TOP_PATH=$CURRENT_PATH/..
KERNEL_PATH=$KERNEL_TOP_PATH/linux
OUTPUT=$KERNEL_TOP_PATH/out
BUILD_LOG=$KERNEL_TOP_PATH/rpi_build_log.txt
KERNEL=kernel7
PREPROCESS_FILE=$1

# 4.9.3
TOOLPATH=$CURRENT_PATH/../bin/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin

echo "build preprocessed file: $PREPROCESS_FILE"

echo "move to out directory"
cd $OUTPUT

echo "kernel build"
make $PREPROCESS_FILE O=$OUTPUT zImage modules dtbs \
	ARCH=arm CROSS_COMPILE=$TOOLPATH/arm-linux-gnueabihf- \
	-j4 2>&1 | tee $BUILD_LOG

cd $CURRENT_PATH
