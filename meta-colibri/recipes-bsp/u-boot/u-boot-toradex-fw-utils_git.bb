SUMMARY = "U-boot bootloader fw_printenv/setenv utils"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM_tegra = "file://Licenses/README;md5=c7383a594871c03da76b3707929d2919"
SECTION = "bootloader"
PROVIDES = "u-boot-fw-utils"
DEPENDS = "mtd-utils"

COMPATIBLE_MACHINE = "(apalis-t30|colibri-t20|colibri-t30)"

DEFAULT_PREFERENCE_apalis-t30 = "1"
DEFAULT_PREFERENCE_colibri-t20 = "1"
DEFAULT_PREFERENCE_colibri-t30 = "1"

FILESPATHPKG =. "git:"
S="${WORKDIR}/git"
# This revision is based on upstream "v2015.04"
SRCREV = "b66337d357cca761bf8627acbb1ec991f425f0b4"
SRCBRANCH = "2015.04-toradex"
SRC_URI = "git://git.toradex.com/u-boot-toradex.git;protocol=git;branch=${SRCBRANCH} \
           file://fw_env.config \
"
SRC_URI_append_tegra3 = " file://fw_unlock_mmc.sh \
"

PV_apalis-t30 = "${PR}+gitr${SRCREV}"
PV_colibri-t20 = "${PR}+gitr${SRCREV}"
PV_colibri-t30 = "${PR}+gitr${SRCREV}"

S = "${WORKDIR}/git"

#actually this depend on the upstream U-Boot version and not on the machine
CC_remove = "-mfpu=neon"
EXTRA_OEMAKE = 'CC="${CC}"'

INSANE_SKIP_${PN} = "already-stripped"

inherit uboot-config

do_compile () {
    oe_runmake ${UBOOT_MACHINE}
    oe_runmake env
}

do_install () {
    install -d ${D}${base_sbindir} ${D}${sysconfdir}
    install -m 755 ${S}/tools/env/fw_printenv ${D}${base_sbindir}/fw_printenv
    ln -s fw_printenv ${D}${base_sbindir}/fw_setenv
    install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/
}

do_install_append_tegra3() {
    install -d ${D}${sysconfdir}/profile.d/
    install -m 0644 ${WORKDIR}/fw_unlock_mmc.sh ${D}${sysconfdir}/profile.d/fw_unlock_mmc.sh
}

pkg_postinst_${PN}_colibri-t20 () {
    # can't do this offline
    if [ "x$D" != "x" ]; then
        exit 1
    fi
    grep u-boot-env /proc/mtd | awk '{print "/dev/" substr($1,0,4) " 0x00000000 0x00010000 0x" $3 " 1" >> "/etc/fw_env.config" }'
}

pkg_postinst_${PN}_tegra3 () {
    # can't do this offline
    if [ "x$D" != "x" ]; then
        exit 1
    fi
    # Environment in eMMC, before the configblock at the end of 1st "boot sector"
    DISK="mmcblk0boot0"
    DISK_SIZE=`cat /sys/block/$DISK/size`
    CONFIG_ENV_SIZE=8192 # 0x2000
    CONFIG_ENV_OFFSET=`expr $DISK_SIZE \* 512 - $CONFIG_ENV_SIZE - 512`
    printf "/dev/%s\t0x%X\t0x%X\n" $DISK $CONFIG_ENV_OFFSET $CONFIG_ENV_SIZE >> "/etc/fw_env.config"
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
