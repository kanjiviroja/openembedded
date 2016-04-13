require recipes-bsp/u-boot/u-boot.inc

PROVIDES = "u-boot virtual/bootloader"
DEPENDS += "dtc-native"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=c7383a594871c03da76b3707929d2919"

COMPATIBLE_MACHINE = "(apalis-t30|colibri-t20|colibri-t30)"

DEFAULT_PREFERENCE_apalis-t30 = "1"
DEFAULT_PREFERENCE_colibri-t20 = "1"
DEFAULT_PREFERENCE_colibri-t30 = "1"

FILESPATHPKG =. "git:"
S="${WORKDIR}/git"
# This revision is based on upstream "v2015.04"
SRCREV = "b66337d357cca761bf8627acbb1ec991f425f0b4"
SRCBRANCH = "2015.04-toradex"
SRC_URI = "git://git.toradex.com/u-boot-toradex.git;protocol=git;branch=${SRCBRANCH}"

PV = "${PR}+gitr${SRCREV}"

# apalis/colibri-t30: require u-boot-dtb-tegra.bin to be used
UBOOT_IMAGE_tegra3 = "u-boot-dtb-tegra-${MACHINE}-${PV}-${PR}.${UBOOT_SUFFIX}"
UBOOT_BINARY_tegra3 = "u-boot-dtb-tegra.${UBOOT_SUFFIX}"
UBOOT_SYMLINK_tegra3 = "u-boot-dtb-tegra-${MACHINE}.${UBOOT_SUFFIX}"

# require u-boot-dtb-tegra.bin to be used
UBOOT_IMAGE = "u-boot-dtb-tegra-${MACHINE}-${PV}-${PR}.${UBOOT_SUFFIX}"
UBOOT_BINARY = "u-boot-dtb-tegra.${UBOOT_SUFFIX}"
UBOOT_SYMLINK = "u-boot-dtb-tegra-${MACHINE}.${UBOOT_SUFFIX}"

PACKAGE_ARCH = "${MACHINE_ARCH}"
