FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

RDEPENDS_${PN} += "librsvg-gtk"
SRC_URI = " \
    ${SOURCEFORGE_MIRROR}/florence/florence/0.5.1/florence-0.5.1.tar.bz2 \
    file://0001-Fix-glib-includes.patch \
    file://fix_garbled_titlebar.patch \
"
