FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SUMMARY = "Linux kernel for Toradex Colibri VFxx Computer on Modules"

SRC_URI_append = "file://defconfig"

