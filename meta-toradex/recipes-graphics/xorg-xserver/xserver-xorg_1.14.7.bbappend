FILESEXTRAPATHS_prepend := "${THISDIR}/xserver-xorg-${PV}:"

SRC_URI_append_tegra = " file://Revert_Use_new_pixman_glyph_cache_t_API_that_will_be_in_pixman0.28.0.patch"

# HACK: during do_rootfs opkg takes the latest and greatest available
# in any feed, e.g. one built for another machine without prefered version
# rather than what PREFERRED_VERSION puts in the MACHINE_ARCH feed
# so we set the recipe epoch here. Thus for our architecture we're
# always latest and greatest.
PE_tegra = "99"

PACKAGE_ARCH_tegra = "${MACHINE_ARCH}"
