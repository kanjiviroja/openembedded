#additional packages to include in our Toradex images

# Copy Licenses to image /usr/share/common-licenses, on vybrid for flash size reasons only the manifest
COPY_LIC_MANIFEST = "1"
COPY_LIC_DIRS = "1"
COPY_LIC_DIRS_colibri-vf = "0"

#build some ipk which are needed together with CAN, but do not yet install them
#DEPENDS += "canutils libsocketcan iproute2"

#the following builds cross gdb and gdbserver
#DEPENDS += "gdb-cross-${TARGET_ARCH}"

#create the file /etc/timestamp
IMAGE_PREPROCESS_COMMAND = "rootfs_update_timestamp"

IMAGE_INSTALL_append_colibri-vf = " \
    u-boot-toradex-fsl-fw-utils \
    libusbg \
    mtd-utils-ubifs \
    mqxboot \
    libmcc \
    kernel-modules \
"

IMAGE_INSTALL += " \
    max9526-i2c \
    crda \
    linux-firmware-ralink \
    linux-firmware-rtl8192cu \
    \
    curl \
    nfs-utils-client \
    openssh-scp \
    openssh-sftp \
    \
    bzip2 \
    grep \
    ldd \
    lsof \
    mtd-utils \
    dosfstools \
    util-linux-fstrim \
    \
    devmem2 \
    evtest \
    hdparm \
    iperf \
    memtester \
"
