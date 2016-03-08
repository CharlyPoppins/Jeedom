#!/bin/sh
# Original script has been written by Davy Leggieri (hey another French guy :-)
# Modified by Charles-Henri Hallard on April 2012 to fit with my configuration
#
# there is start stop var because at stop modules usbserial should be unloaded last
MODULES_DIR="/lib/modules"
MODULES_START="usbserial.ko ftdi_sio.ko cp210x.ko"
MODULES_STOP="ftdi_sio.ko cp210x.ko usbserial.ko"
 
start_modules(){
        echo "--- Load modules ---"
        for i in $MODULES_START; do
                echo "Loading $i"
                insmod $MODULES_DIR/$i
        done
 
        # Create the ttyUSB (7 should be enought for me)
        if [ -c /dev/ttyUSB0 ]; then
                mknod /dev/ttyUSB0 c 188 0
                mknod /dev/ttyUSB1 c 188 1
                mknod /dev/ttyUSB2 c 188 2
                mknod /dev/ttyUSB3 c 188 3
                mknod /dev/ttyUSB4 c 188 4
                mknod /dev/ttyUSB5 c 188 5
                mknod /dev/ttyUSB6 c 188 6
        fi
}
 
stop_modules(){
        echo "--- Unload modules ---"
        for i in $MODULES_STOP; do
                echo "Unloading $i"
                rmmod $MODULES_DIR/$i
        done
}
 
case "$1" in
start)
        start_modules
        ;;
stop)
        stop_modules
        ;;
*)
        echo "usage: $0 { start | stop }" >&2
        exit 1
        ;;
esac