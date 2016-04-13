FILESEXTRAPATHS_prepend := "${THISDIR}/busybox:"

#we don't want busybox syslog as we use the functionality of journalctl
RRECOMMENDS_${PN}_remove = "${PN}-syslog"
