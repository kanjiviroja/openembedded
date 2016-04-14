FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-4.1:"

# Load USB functions configurable through configfs (CONFIG_USB_CONFIGFS)
KERNEL_MODULE_AUTOLOAD += "${@bb.utils.contains('COMBINED_FEATURES', 'usbgadget', ' libcomposite', '',d)}"

LOCALVERSION = "-v2.5b3"
SRCREV = "e6d111cd909551cec5902358db1e25dcaa8c86bb"
