#! /bin/sh
# Prepare files needed for flashing a Colibri VF50/VF61 module and
# copy them to a convenient location for using from a running U-Boot

set -e

# sometimes we need the binary echo, not the shell builtin
ECHO=`which echo`

Flash()
{
	echo "To flash the Colibri VF50/VF61 module a running U-Boot is required. Boot the"
	echo "module to the U-Boot prompt and"
	echo ""
	echo "insert the SD card, USB flash drive or when using TFTP connect Ethernet only"
	echo "and enter:"
	echo "'run setupdate'"
	echo ""
	echo "then to update all components enter:"
	echo "'run update'"
	echo ""
	echo "to update a single component enter one of:"
	echo "'run update_uboot'"
	echo "'run update_rootfs'"
	echo ""
	echo ""
	echo "If you don't have a working U-Boot anymore, connect your PC to the module's"
	echo "UART, bring the module into the serial download mode and start the update.sh"
	echo "script with the -d option. This will copy U-Boot into the module's RAM and"
	echo "execute it. Don't forget to also bridge RTS/CTS if using an USB-to-serial"
	echo "converter without handshake signals."
	echo ""
	echo "Then use the following command to get U-Boot running:"
	echo "'./update.sh -n -d /dev/ttyUSB0'"
	echo ""
	echo "Next, recreate the Boot Configuration Block and the Toradex Config Block:"
	echo "'run setupdate'"
	echo "'run update_uboot'"
	echo "'run create_bcb'"
	echo "'cfgblock create'"
}

Usage()
{
	echo ""
	echo "Prepares and copies files for flashing internal NAND of Colibri VF50/VF61"
	echo ""
	echo "The recommended way is to copy the files on a SD card or USB flash drive."
	echo "The script format_sd.sh may be used to format the SD card."
	echo ""
	echo "The flash step requires a running U-Boot on the target. Either one already"
 	echo "flashed on the NAND or downloaded using serial downloader (argument -d)."
	echo ""
	echo "-d uart_dev  : use UART connection to copy/execute U-Boot to/from module's RAM"
	echo "-f           : flash instructions"
	echo "-h           : prints this message"
	echo "-n           : disable hardware flow control (bridge RTS/CTS!)"
	echo "-o directory : output directory"
	echo "-s           : optimise file system for 128MB NAND, increases usable space"
	echo "               on VF50 module a little, but on VF61 uses also only 128MB"
	echo ""
        echo "Example \"./update.sh -o /media/KERNEL/\" copies the required files to SD card"
	echo ""
	echo "*** For detailed recovery/update procedures, refer to the following website: ***"
        echo "http://developer.toradex.com/knowledge-base/flashing-linux-on-vybrid-modules"
	echo ""
}

# initialise options
UBOOT_RECOVERY=0
NORTSCTS=0
OUT_DIR=""
# NAND parameters
PAGE=2KiB
BLOCK=124KiB
MAXLEB=8112

while getopts "d:fhno:s" Option ; do
	case $Option in
		d)	UBOOT_RECOVERY=1
			UARTDEV=$OPTARG
			;;
		f)	Flash
			exit 0
			;;
		h)	Usage
			# Exit if only usage (-h) was specified.
			if [ "$#" -eq 1 ] ; then
				exit 10
			fi
			exit 0
			;;
		n)	NORTSCTS=1
			;;
		o)	OUT_DIR=$OPTARG
			;;
		s)	MAXLEB=982
			;;
	esac
done

if [ "$OUT_DIR" = "" ] && [ "$UBOOT_RECOVERY" = "0" ] ; then
	Usage
	exit 0
fi

# is OUT_DIR an existing directory?
if [ ! -d "$OUT_DIR" ] && [ "$UBOOT_RECOVERY" = "0" ] ; then
	echo "$OUT_DIR" "does not exist, exiting"
	exit 1
fi

# auto detect MODTYPE from rootfs directory
if [ -f rootfs/etc/issue ] ; then
	CNT=`grep -c "VF" rootfs/etc/issue || true`
	if [ "$CNT" -ge 1 ] ; then
		echo "Colibri VF rootfs detected"
		MODTYPE=colibri-vf
		IMAGEFILE=ubifs.img
		LOCPATH="vf_flash"
		OUT_DIR="$OUT_DIR/colibri_vf"
	fi
fi

if [ -e $MODTYPE ] ; then
	echo "can not detect module type from ./rootfs/etc/issue"
	echo "exiting"
	exit 1
fi
BINARIES=${MODTYPE}_bin

#is only U-Boot to be copied to RAM?
if [ "$UBOOT_RECOVERY" -eq 1 ] ; then
	LOADEROPTS=""
	if [ ${NORTSCTS} = 1 ]; then
		LOADEROPTS="--no-rtscts"
	fi

	echo "Put the module in recovery mode and press [ENTER]..."
	read RESULT
	sudo ${LOCPATH}/imx_uart ${LOADEROPTS} ${UARTDEV} ${LOCPATH}/vybrid_usb_work.conf ${BINARIES}/u-boot.imx
	exit 0
fi

#sanity check for correct untared rootfs
DEV_OWNER=`ls -ld rootfs/dev | awk '{print $3}'`
if [ "${DEV_OWNER}x" != "rootx" ]
then
	$ECHO -e "rootfs/dev is not owned by root, but it should!"
	$ECHO -e "\033[1mPlease unpack the tarball with root rights.\033[0m"
	$ECHO -e "e.g. sudo tar xjvf Colibri_VF_LinuxImageV2.3_20140804.tar.bz2"
	exit 1
fi

#sanity check, can we execute mkfs.ubifs, e.g. see the help text?
CNT=`sudo $LOCPATH/mkfs.ubifs -h | grep -c space-fixup`  
if [ "$CNT" -eq 0 ] ; then
	echo "The program mkfs.ubifs can not be executed or does not provide --space-fixup"
	echo "option."
	echo "Are you on a 64bit Linux host without installed 32bit execution environment?"
	$ECHO -e  "\033[1mPlease install e.g. ia32-libs on 64-bit Ubuntu\033[0m"
	$ECHO -e  "\033[1mMaybe others are needed e.g. liblzo2:i386 on 64-bit Ubuntu\033[0m"
	exit 1
fi

# Prepare full flashing
#build ${IMAGEFILE} if it does not exist
sudo $LOCPATH/mkfs.ubifs --space-fixup -c ${MAXLEB} -e ${BLOCK} -m ${PAGE} -o ${BINARIES}/${IMAGEFILE} -r rootfs/ -v

echo ""
echo "UBI image of root file system generated, coping data to target folder..."

#make a file with the used versions for U-Boot, kernel and rootfs
sudo touch ${BINARIES}/versions.txt
sudo chmod ugo+w ${BINARIES}/versions.txt
echo "Component Versions" > ${BINARIES}/versions.txt
basename "`readlink -e ${BINARIES}/u-boot.imx`" >> ${BINARIES}/versions.txt
$ECHO -n "Rootfs " >> ${BINARIES}/versions.txt
grep VF rootfs/etc/issue >> ${BINARIES}/versions.txt

#create subdirectory for this module type
sudo mkdir -p "$OUT_DIR"

#copy to $OUT_DIR
sudo cp ${BINARIES}/u-boot-nand.imx ${BINARIES}/ubifs.img ${BINARIES}/flash*.img ${BINARIES}/versions.txt "$OUT_DIR"
sudo cp ${BINARIES}/fwd_blk.img "$OUT_DIR/../flash_blk.img"
sudo cp ${BINARIES}/fwd_eth.img "$OUT_DIR/../flash_eth.img"
sudo cp ${BINARIES}/fwd_mmc.img "$OUT_DIR/../flash_mmc.img"
#cleanup intermediate files
sudo rm ${BINARIES}/ubifs.img ${BINARIES}/versions.txt
sync

echo "Successfully copied data to target folder."
echo ""

Flash
