#additional packages to include in our Toradex images

# Copy Licenses to image /usr/share/common-licenses, on vybrid for flash size reasons only the manifest
COPY_LIC_MANIFEST = "1"
COPY_LIC_DIRS = "1"
COPY_LIC_DIRS_colibri-vf = "0"

#build some ipk which are needed together with CAN, but do not yet install them
DEPENDS += "canutils libsocketcan iproute2"

#the following builds cross gdb and gdbserver
DEPENDS += "gdb-cross-${TARGET_ARCH}"

#create the file /etc/timestamp
IMAGE_PREPROCESS_COMMAND = "rootfs_update_timestamp"

IMAGE_INSTALL_append_tegra = " \
    u-boot-toradex-fw-utils \
    tegrastats \
    trdx-nv-binaries \
    trdx-nv-binaries-nv-gstapps \
    trdx-nv-binaries-restricted-codecs \
    usb-rndis-systemd \
    hdmi-hotplug \
    \
    curl \
    file \
    aspell \
    kernel-modules \
"

IMAGE_INSTALL_append_tegra3 = " \
    fs-init \
    e2fsprogs \
    e2fsprogs-mke2fs \
    e2fsprogs-tune2fs \
    nv-conf-systemd \
"

IMAGE_INSTALL_append_apalis-t30 = " \
    pciutils \
    ptpd \
    iproute2 \
    canutils \
    lvds-ctrl \
"

IMAGE_INSTALL_append_colibri-t20 = " \
    mtd-utils-ubifs \
"

#note that the kernel-modules meta package gets installed from
#meta-fsl-arm/conf/machine/include/imx-base.inc
IMAGE_INSTALL_append_mx6 = " \
    u-boot-toradex-fsl-fw-utils \
    libusbg \
    gpio-export \
    curl \
    file \
    aspell \
    ptpd \
    iproute2 \
    canutils \
    fs-init \
    e2fsprogs \
    e2fsprogs-mke2fs \
    e2fsprogs-tune2fs \
    mimetypes \
"

#note that the kernel-modules meta package gets installed from
#meta-fsl-arm/conf/machine/include/imx-base.inc
IMAGE_INSTALL_append_apalis-imx6 = " \
    pciutils \
"

IMAGE_INSTALL_append_colibri-vf = " \
    u-boot-toradex-fsl-fw-utils \
    libusbg \
    ptpd \
    iproute2 \
    canutils \
    mtd-utils-ubifs \
    mqxboot \
    libmcc \
    mcc-pingpong \
    kernel-modules \
"

IMAGE_INSTALL += " \
    max9526-i2c \
    crda \
    linux-firmware-ralink \
    linux-firmware-rtl8192cu \
    \
    alsa-utils \
    alsa-utils-aplay \
    alsa-utils-amixer \
    \
    sqlite3 \
    \
    curl \
    nfs-utils-client \
    openssh-scp \
    openssh-sftp \
    \
    bzip2 \
    gdbserver \
    grep \
    joe \
    minicom \
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
    i2c-tools \
    memtester \
    stress \
    lmbench \
    nbench-byte \
    tinymembench \
    ethtool \
    \
    trdx-oak-sensors \
"
