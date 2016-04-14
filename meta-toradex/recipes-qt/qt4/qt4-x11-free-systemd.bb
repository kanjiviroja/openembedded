SECTION = "x11/libs"
SUMMARY = "systemd qtdemo autostart"
RDEPENDS_${PN} = ""
# The license is meant for this recipe and the files it installs.
# RNDIS is part of the kernel, udhcpd is part of busybox
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

PR = "r1"

inherit allarch systemd

SRC_URI = "file://qt4-x11-demo.service \
           file://qt4-x11-demo-init "

do_install () {
    install -d ${D}/${bindir}
    install -m 0755 ${WORKDIR}/qt4-x11-demo-init ${D}/${bindir}

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/qt4-x11-demo.service ${D}${systemd_unitdir}/system
}

NATIVE_SYSTEMD_SUPPORT = "1"
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "qt4-x11-demo.service"
