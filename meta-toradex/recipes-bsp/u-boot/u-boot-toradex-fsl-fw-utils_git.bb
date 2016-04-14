SUMMARY = "U-boot bootloader fw_printenv/setenv utils"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=c7383a594871c03da76b3707929d2919"
SECTION = "bootloader"
PROVIDES = "u-boot-fw-utils"
DEPENDS = "mtd-utils"

COMPATIBLE_MACHINE = "(colibri-vf|colibri-imx6|apalis-imx6)"
DEFAULT_PREFERENCE_colibri-vf = "1"
DEFAULT_PREFERENCE_apalis-imx6 = "1"
DEFAULT_PREFERENCE_colibri-imx6 = "1"

FILESPATHPKG =. "git:"
S="${WORKDIR}/git"
SRCREV_colibri-vf = "b66337d357cca761bf8627acbb1ec991f425f0b4"
SRCREV_mx6 = "b66337d357cca761bf8627acbb1ec991f425f0b4"
SRCBRANCH_colibri-vf = "2015.04-toradex"
SRCBRANCH_mx6 = "2015.04-toradex"
SRC_URI = "git://git.toradex.com/u-boot-toradex.git;protocol=git;branch=${SRCBRANCH} \
           file://fw_env.config \
"
SRC_URI_append_mx6 = " file://fw_unlock_mmc.sh \
"

PV = "${PR}+gitr${SRCREV}"
PR = "r0"

S = "${WORKDIR}/git"

EXTRA_OEMAKE = 'CC="${CC}" STRIP="${STRIP}"'

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

do_install_append_mx6() {
    install -d ${D}${sysconfdir}/profile.d/
    install -m 0644 ${WORKDIR}/fw_unlock_mmc.sh ${D}${sysconfdir}/profile.d/fw_unlock_mmc.sh
}

pkg_postinst_${PN}_mx6 () {
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
