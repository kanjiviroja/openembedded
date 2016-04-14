FILESEXTRAPATHS_prepend := "${THISDIR}/lxdm:"

SRC_URI += " \
    file://logout-fixes.patch \
    file://root-autologin.patch \
    ${@base_contains("DISTRO_TYPE", "debug", "", "file://0001-lxdm.conf.in-blacklist-root-for-release-images.patch",d)} \
"
