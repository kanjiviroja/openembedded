EXTRA_OECONF +=  "--disable-sdl"

do_install_append () {
    # make an empty file, so that ${PN} packages has not size 0 and does get created
    mkdir -p ${D}${datadir}/gstreamer-${LIBV}
    touch ${D}${datadir}/gstreamer-${LIBV}/gst-plugins-bad
}

