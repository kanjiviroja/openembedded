FILESEXTRAPATHS_prepend := "${THISDIR}/connman:"

SRC_URI += " \
    file://dont_start_connman_on_nfsboot.patch \
    file://main.conf \
"

do_install_append() {
	install -d ${D}${sysconfdir}/connman/
	install -m 0644 ${WORKDIR}/main.conf ${D}${sysconfdir}/connman/
}
