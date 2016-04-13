FILESEXTRAPATHS_prepend := "${THISDIR}/glibc:"
SRC_URI_append = " file://0001-memcpy-don-t-use-optimized-for-VFP-NEON-versions.patch"
