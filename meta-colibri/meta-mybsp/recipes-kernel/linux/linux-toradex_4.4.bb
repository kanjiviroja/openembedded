require recipes-kernel/linux/linux-imx.inc
require recipes-kernel/linux/linux-dtb.inc

SUMMARY = "Linux kernel for Toradex Colibri VFxx Computer on Modules"

SRC_URI = "git://git.toradex.com/linux-toradex.git;protocol=git;branch=${SRCBRANCH} \
           file://defconfig"

LOCALVERSION = "-v2.5b1.1"
SRCBRANCH = "toradex_vf_4.4-next"
SRCREV = "88c66ffd8ed6cd50e436ce0d5830cd27f93259a2"
DEPENDS += "lzop-native bc-native"
COMPATIBLE_MACHINE = "(vf)"
