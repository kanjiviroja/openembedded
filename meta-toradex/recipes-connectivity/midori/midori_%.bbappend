FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://config \
            file://bookmarks_v2.db \
"

do_install_append() {
    install -d ${D}/home/root/.config/midori
    install -m 0644 ${WORKDIR}/config ${WORKDIR}/bookmarks_v2.db ${D}/home/root/.config/midori/
}

FILES_${PN} += "/home/root/.config/midori/*"
