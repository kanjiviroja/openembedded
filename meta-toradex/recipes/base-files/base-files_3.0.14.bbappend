FILESEXTRAPATHS_prepend := "${THISDIR}/base-files:"

do_install_append () {
        echo "search colibri.net"  > ${D}${sysconfdir}/resolv.conf
        echo "nameserver 8.8.8.8" >> ${D}${sysconfdir}/resolv.conf
        echo "nameserver 8.8.4.4" >> ${D}${sysconfdir}/resolv.conf
}
