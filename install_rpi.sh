#!/bin/bash

PI_DIR=/home/pi
INSTALL_DIR=$PI_DIR/install/
MODULES_DIR=$PI_DIR/lib

echo "Wait until finishing installing..."
cp $INSTALL_DIR/boot/*.dtb           /boot/
cp $INSTALL_DIR/boot/overlays/*.dtb* /boot/overlays/
cp $INSTALL_DIR/boot/zImage          /boot/kernel7.img
cp -r $MODULES_DIR /
