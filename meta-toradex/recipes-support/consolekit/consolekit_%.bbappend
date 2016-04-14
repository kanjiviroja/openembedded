# arm-angstrom-linux-gnueabi-libtool: link: cannot find the library `.../libsystemd.la' or unhandled argument `=/usr/lib/libsystemd.la'
DEPENDS += "${@bb.utils.contains("DISTRO_FEATURES", "systemd", "systemd", "", d)}"
