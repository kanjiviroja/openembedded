ANGSTROM_URI = "http://feeds.toradex.com/angstrom"

do_compile_append() {
    #no debug feed available so empty the feed configs
    echo "" >  ${S}/${sysconfdir}/opkg/debug-feed.conf

    #trdx: no machine feed available so empty the feed configs
    echo "" >  ${S}/${sysconfdir}/opkg/${MACHINE_ARCH}-feed.conf
}
