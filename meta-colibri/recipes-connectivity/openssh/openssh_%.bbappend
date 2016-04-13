PACKAGES =+ "${PN}-scp-dev ${PN}-sftp-dev ${PN}-sftp-server-dev"
PACKAGES =+ "${PN}-scp-dbg ${PN}-sftp-dbg ${PN}-sftp-server-dbg"

FILES_${PN}-scp-dev = ""
FILES_${PN}-sftp-dev = ""
FILES_${PN}-sftp-server-dev = ""
FILES_${PN}-scp-dbg = "${bindir}/.debug/scp.${BPN}"
FILES_${PN}-sftp-dbg = "${bindir}/.debug/sftp"
FILES_${PN}-sftp-server-dbg = "${libexecdir}/.debug/sftp-server"

#do not use reverse DNS
do_install_append () {
    sed -i -e 's:^#UseDNS.*$:UseDNS no:g' ${D}${sysconfdir}/ssh/sshd_config
}
