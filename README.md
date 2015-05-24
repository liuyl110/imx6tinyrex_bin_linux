# imx6tinyrex_bin_linux
imx6q/dl/s tinyrex linux binaries 


# Download repository
    git clone https://github.com/voipac/imx6tinyrex_bin_linux
    cd imx6tinyrex_bin_linux/
    
# Install linux for imx6s into mmcblk0 card
    sudo ./fsl-sdcard-partition.sh -s /dev/mmcblk0

# Install linux for imx6dl into mmcblk0 card
    sudo ./fsl-sdcard-partition.sh -dl /dev/mmcblk0

# Install linux for imx6q into mmcblk0 card
    sudo ./fsl-sdcard-partition.sh -q /dev/mmcblk0
    
# Setup u-boot (HDMI)

# Log
    marek@jessie:~/workdir/imx6tinyrex_bin_linux$ sudo ./fsl-sdcard-partition.sh -s /dev/mmcblk0
    Selected files:
    UBOOT:  u-boot-imx6s-tinyrex.imx
    KERNEL: zImage-imx6s-tinyrex
    Creating partitions...
    Partition table destroyed [OK]
    Formating partitions...
    mkfs.fat 3.0.27 (2014-11-12)
    mke2fs 1.42.12 (29-Aug-2014)
    /dev/mmcblk0p2 contains a ext4 file system labelled 'system'
        last mounted on /media/tmp on Sun May 24 17:11:09 2015
    Proceed anyway? (y,n) y
    Discarding device blocks: done
    Creating filesystem with 1930240 4k blocks and 483328 inodes
    Filesystem UUID: e19186c3-400a-4fc8-86fa-758096e5d8f1
    Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

    Allocating group tables: done
    Writing inode tables: done
    Creating journal (32768 blocks): done
    Writing superblocks and filesystem accounting information: done 
    
    Flashing images...

