FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://distribution.ini"

do_install_append() {
    install -d ${D}${libdir}/firefox/distribution
    install -m 0644 ${WORKDIR}/distribution.ini ${D}${libdir}/firefox/distribution/
}
