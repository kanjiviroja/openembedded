# use a customized small icu data library created from
# http://apps.icu-project.org/datacustom/ICUData53.html
#   Charset Mapping Tables (only minimum set)
#   Break Iterator (en_US)
#   Base Data

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_colibri-vf = "${BASE_SRC_URI} file://icudt54l.zip "

do_configure_append_colibri-vf () {
    rm  -f ${S}/data/in/icudt*l.dat
    cp ${WORKDIR}/icudt*l.dat ${S}/data/in/
}

PACKAGE_ARCH_colibri-vf = "${MACHINE_ARCH}"
