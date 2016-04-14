FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PACKAGE_ARCH_tegra = "${MACHINE_ARCH}"

# Set Tegra specific dependencies and device type
DEPENDS_tegra += "virtual/libgles2"
EGLINFO_DEVICE_tegra = "generic"

SRCREV = "223817ee37988042db7873cfb5b2e899dfe35c10"

SRC_URI_append_tegra = " \
    file://eglinfo.patch \
"
