#!/bin/bash

# sudo ./fsl-sdcard-partition.sh -f /dev/mmcblk0

# partition size in MB
ROM_SIZE_BOOT=8
ROM_SIZE_KERNEL=32
#ROM_SIZE_SYSTEM=512

help() {

bn=`basename $0`
cat << EOF
usage $bn <option> device_node

options:
  -h				displays this help message
  -s				imx6 solo
  -dl 				imx6 dual lite
  -q 				imx6 quad
EOF

}

function root_test
{
    userid=`id -u`
    if [ $userid -ne "0" ]; then
        echo "This script must be run as root"
        exit
    fi
}

# parse command line
moreoptions=1
node="na"
imx6s=0
imx6dl=0
imx6q=0
while [ "$moreoptions" = 1 -a $# -gt 0 ]; do
	case $1 in
	    -h) help; exit ;;
	    -s)  imx6s=1 ;;
	    -dl) imx6dl=1 ;;
	    -q)  imx6q=1 ;;
	    *)  moreoptions=0; node=$1 ;;
	esac
	[ "$moreoptions" = 0 ] && [ $# -gt 1 ] && help && exit
	[ "$moreoptions" = 1 ] && shift
done

if [ ! -e ${node} ]; then
	help
	exit
fi

part=""
echo ${node} | grep mmcblk > /dev/null
if [ "$?" -eq "0" ]; then
	part="p"
fi

FILE_UBOOT="u-boot.imx"
FILE_KERNEL="zImage"
function file_finux
{
    if [ "${imx6s}" -eq "1" ]; then
        FILE_UBOOT="u-boot-imx6s-tinyrex.imx"
        FILE_KERNEL="zImage-imx6s-tinyrex"
    fi
    if [ "${imx6dl}" -eq "1" ]; then
        FILE_UBOOT="u-boot-imx6dl-tinyrex.imx"
        FILE_KERNEL="zImage-imx6dl-tinyrex"
    fi
    if [ "${imx6q}" -eq "1" ]; then
        FILE_UBOOT="u-boot-imx6q-tinyrex.imx"
        FILE_KERNEL="zImage-imx6q-tinyrex"
    fi
}

function partition_linux
{
    echo "Creating partitions..."   
    # umount the partition table
    STATUS=$(umount ${node}* 2>/dev/null)

    STATUS=$(dd if=/dev/zero of=${node} bs=1024 count=1 2>/dev/null)
    if [[ ${STATUS} -eq 0 ]] ; then
        echo "Partition table destroyed [OK]"
    else
        echo "Partition table destroyed [FAIL]"
        exit 1
    fi

    PARTITION_OFFSET_FIRST=$(expr ${ROM_SIZE_BOOT} + 0)
    PARTITION_OFFSET_SECOND=$(expr ${PARTITION_OFFSET_FIRST} + ${ROM_SIZE_KERNEL})

sfdisk --force -uM ${node} << EOF
${PARTITION_OFFSET_FIRST},${ROM_SIZE_KERNEL},c
${PARTITION_OFFSET_SECOND},${ROM_SIZE_SYSTEM},83
EOF
}

function format_linux
{
    echo "Formating partitions..."   
    mkfs.vfat ${node}${part}1 -nKERNEL
    mkfs.ext4 ${node}${part}2 -Lsystem
}

function flash_linux
{
    echo "Flashing images..."
    dd if=${FILE_UBOOT} of=${node} bs=1k seek=1   skip=0  oflag=dsync
    dd if=/dev/zero of=${node}  bs=4k seek=128 count=2 oflag=dsync

    mkdir /media/tmp
    mount ${node}${part}1 /media/tmp
    cp ${FILE_KERNE} imx6s-tinyrex.dtb imx6dl-tinyrex.dtb imx6q-tinyrex.dtb /media/tmp
    umount /media/tmp

    mount ${node}${part}2 /media/tmp
    tar xvjf core-image-minimal-imx6.rootfs.tar.bz2 -C  /media/tmp
    umount /media/tmp
}

root_test
file_finux
partition_linux
format_linux
flash_linux
