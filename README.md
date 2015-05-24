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
