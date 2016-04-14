SECTION = "graphic/utils"
SUMMARY = "giblib is a simple library which wraps imlib2"
HOMEPAGE = "http://linuxbrit.co.uk/software/"
LICENSE ="BSD"
RDEPENDS_${PN} = "imlib2"
DEPENDS = "imlib2"

MIRRORS_prepend () {
    http://linuxbrit.co.uk/downloads/ http://pkgs.fedoraproject.org/repo/pkgs/giblib/giblib-${PV}.tar.gz/c810ef5389baf24882a1caca2954385e/
}

SRC_URI = "http://linuxbrit.co.uk/downloads/giblib-${PV}.tar.gz  \
           file://fix-giblib-binconfig-paths.patch "
LIC_FILES_CHKSUM = "file://COPYING;md5=dd3cb8d7a69f3d0b2a52a46c92389011"
SRC_URI[md5sum] = "c810ef5389baf24882a1caca2954385e"
SRC_URI[sha256sum] = "176611c4d88d742ea4013991ad54c2f9d2feefbc97a28434c0f48922ebaa8bac"

PR = "r0"

do_compile_prepend () {
    #remove linkerpath to host libraries
    sed -i -e 's:-L/usr/lib\s::' Makefile
    sed -i -e 's:-L/usr/lib\s::' giblib/Makefile
    export DESTDIR=${D}
}

do_compile_prepend () {
    export DESTDIR=${D}
}

FILES_${PN}-doc = "/usr/doc"

inherit autotools-brokensep binconfig

