# libav 9.x -> 10.x changed/deprecated some of it's API
# opencv 4.8.9 is not yet ready for this, the patches address the issues
# They are taken from here:
# https://github.com/Itseez/opencv/pull/2293

FILESEXTRAPATHS_prepend := "${THISDIR}/opencv:"

SRC_URI += " \
    file://0001-cap_ffmpeg-drop-support-for-very-old-libav-versions.patch \
    file://0002-cap_ffmpeg-drop-the-local-copy-of-the-RIFF-FourCC-li.patch \
    file://0003-cap_ffmpeg-wrap-a-forgotten-instance-of-CODEC_ID_H26.patch \
    file://0004-cap_ffmpeg-do-not-use-AVStream.r_frame_rate.patch \
    file://0005-cap_ffmpeg-use-avcodec_encode_video2-where-available.patch \
"
