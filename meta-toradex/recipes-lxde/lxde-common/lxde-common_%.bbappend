WALLPAPER-MACHINE = "Wallpaper_Toradex.png"
WALLPAPER-MACHINE_colibri-t20 = "Wallpaper_ColibriT20.png"
WALLPAPER-MACHINE_colibri-t30 = "Wallpaper_ColibriT30.png"
WALLPAPER-MACHINE_apalis-t30 = "Wallpaper_ApalisT30.png"

FILESEXTRAPATHS_prepend := "${THISDIR}/lxde-common:"

PACKAGE_ARCH = "${MACHINE_ARCH}"

SRC_URI += " \
    file://Wallpaper_Toradex.png \
    file://${WALLPAPER-MACHINE} \
    file://wallpaper.patch \
    file://desktop.conf \
    file://defaults.list \
    file://panel-buttons.patch \
"

# for colibri-vf50, colibri-vf61 we decide on the target during postinst
SRC_URI_append_vf += " \
    file://Wallpaper_ColibriVF50.png \
    file://Wallpaper_ColibriVF61.png \
"
# for apalis-imx6, we decide on the target during postinst
SRC_URI_append_mx6 += " \
    file://Wallpaper_ApalisiMX6D.png \
    file://Wallpaper_ApalisiMX6Q.png \
    file://Wallpaper_ColibriiMX6DL.png \
    file://Wallpaper_ColibriiMX6S.png \
"

do_install_append () {
    install -m 0755 -d ${D}/${datadir}/lxde/wallpapers
    install -m 0644 ${WORKDIR}/Wallpaper*.png ${D}/${datadir}/lxde/wallpapers/
    ln -sf ${WALLPAPER-MACHINE} ${D}/${datadir}/lxde/wallpapers/toradex.png
    rm  ${D}/etc/xdg/lxsession/LXDE/desktop.conf
    install -m 0644 ${WORKDIR}/desktop.conf ${D}/etc/xdg/lxsession/LXDE/
    install -m 0755 -d ${D}/${datadir}/applications/
    install -m 0644 ${WORKDIR}/defaults.list ${D}/${datadir}/applications/
}

pkg_postinst_${PN}_vf () {
    # can't do this offline
    if [ "x$D" != "x" ]; then
        exit 1
    fi
    IS_VF50=`grep -c VF50 /proc/cpuinfo`
    IS_VF50_DTB=`grep -c toradex,vf500-colibri_vf50 /proc/device-tree/compatible`
    IS_VF61=`grep -c VF61 /proc/cpuinfo`
    IS_VF61_DTB=`grep -c toradex,vf610-colibri_vf61 /proc/device-tree/compatible`
    if [ $IS_VF50 -gt 0 ] || [ $IS_VF50_DTB -gt 0 ]; then
        ln -sf Wallpaper_ColibriVF50.png ${datadir}/lxde/wallpapers/toradex.png
    elif [ $IS_VF61 -gt 0 ] || [ $IS_VF61_DTB -gt 0 ]; then
        ln -sf Wallpaper_ColibriVF61.png ${datadir}/lxde/wallpapers/toradex.png
    fi
}

pkg_postinst_${PN}_mx6 () {
    # can't do this offline
    if [ "x$D" != "x" ]; then
        exit 1
    fi
    SOC_TYPE=`cat /sys/bus/soc/devices/soc0/soc_id`
    CORES=`grep -c processor /proc/cpuinfo`
    case $CORES in
        4)
            ln -sf Wallpaper_ApalisiMX6Q.png ${datadir}/lxde/wallpapers/toradex.png
            ;;
        2)
            if [ "x$SOC_TYPE" = "xi.MX6DL" ]; then
                ln -sf Wallpaper_ColibriiMX6DL.png ${datadir}/lxde/wallpapers/toradex.png
            else
                ln -sf Wallpaper_ApalisiMX6D.png ${datadir}/lxde/wallpapers/toradex.png
            fi
            ;;
        1)
            ln -sf Wallpaper_ColibriiMX6S.png ${datadir}/lxde/wallpapers/toradex.png
            ;;
        *)
            ln -sf Wallpaper_Toradex.png ${datadir}/lxde/wallpapers/toradex.png
            ;;
    esac
}
