#!/bin/bash

CURRENT_PATH=$(pwd)
KERNEL_TOP_PATH=$CURRENT_PATH/..
KERNEL_PATH=$KERNEL_TOP_PATH/linux
OUTPUT=$KERNEL_TOP_PATH/out
BUILD_LOG=$KERNEL_TOP_PATH/rpi_build_log.txt
KERNEL=kernel7
INSTALL_PATH=$KERNEL_TOP_PATH/install
MODULES=$KERNEL_TOP_PATH/modules

# 4.9.3
TOOLPATH=$CURRENT_PATH/../bin/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin

echo "move to out directory"
echo $OUTPUT

mkdir -p $MODULES
mkdir -p $INSTALL_PATH/boot
mkdir -p $INSTALL_PATH/boot/overlays

# Mount /home/pi/ of target board to $MODULES.
sshfs pi@169.254.43.140:/home/pi/ $MODULES

# Install modules to mounted $MODULES.
cd $OUTPUT
make O=$OUTPUT modules_install INSTALL_MOD_PATH=$MODULES \
	ARCH=arm CROSS_COMPILE=$TOOLPATH/arm-linux-gnueabihf-

# Unmount $MODULES
sudo umount $MODULES

# Install build output (zImage, dtbs) to $INSTALL_PATH.
cp $OUTPUT/arch/arm/boot/dts/*.dtb           $INSTALL_PATH/boot/
cp $OUTPUT/arch/arm/boot/dts/overlays/*.dtb* $INSTALL_PATH/boot/overlays/
cp $OUTPUT/arch/arm/boot/zImage              $INSTALL_PATH/boot/zImage

# Send $INSTALL_PATH along with install_rpi.sh to raspberry pi, which is 
# then be used to install zImage, modules, and dtbs locally in raspberry pi.
scp -r $INSTALL_PATH $CURRENT_PATH/install_rpi.sh pi@169.254.43.140:~/

cd $CURRENT_PATH
