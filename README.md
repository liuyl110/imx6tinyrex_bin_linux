# imx6tinyrex_bin_linux
imx6q/dl/s tinyrex linux binaries 


# Download repository
    git clone https://github.com/voipac/imx6tinyrex_bin_linux
    cd imx6tinyrex_bin_linux/
    
# Install linux for imx6lite into mmcblk0 card
    sudo ./fsl-sdcard-partition.sh -lite /dev/mmcblk0

# Install linux for imx6basic into mmcblk0 card
    sudo ./fsl-sdcard-partition.sh -basic /dev/mmcblk0

# Install linux for imx6pro into mmcblk0 card
    sudo ./fsl-sdcard-partition.sh -pro /dev/mmcblk0

# Install linux for imx6max into mmcblk0 card
    sudo ./fsl-sdcard-partition.sh -max /dev/mmcblk0
    
# Setup u-boot (imx6lite)
Imx6 modules will try to reserve 320MB cma memory.
Because lite module have 256MB of RAM it will require special bootarg settings. 
    setenv mmcargs "setenv bootargs console=${console},${baudrate} root=${mmcroot} cma=96M"

# Log
    marek@jessie:~/workdir/imx6/rootfs/imx6tinyrex_bin_linux$ sudo ./fsl-sdcard-partition.sh -lite /dev/sdb
    Selected files:
    UBOOT  : u-boot-imx6-tinyrexlite.imx
    KERNEL : zImage-imx6-tinyrexlite.bin
    FDT    : zImage-imx6-tinyrexlite.dtb
    ROOT   : core-image-base-imx6-tinyrexlite.tar.bz2
    Creating partitions...
    Partition table destroyed [OK]
    Formating partitions...
    mkfs.fat 3.0.27 (2014-11-12)
    mke2fs 1.42.12 (29-Aug-2014)
    /dev/sdb2 contains a ext4 file system labelled 'system'
        last mounted on /media/marek/system on Sat Feb 27 18:50:45 2016
    Proceed anyway? (y,n) y
    Creating filesystem with 970610 4k blocks and 242880 inodes
    Filesystem UUID: 0acc13b5-321a-4ef8-b831-8e6a1090fa5c
    Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736

    Allocating group tables: done
    Writing inode tables: done
    Creating journal (16384 blocks): done
    Writing superblocks and filesystem accounting information: done 

	Flashing images...


