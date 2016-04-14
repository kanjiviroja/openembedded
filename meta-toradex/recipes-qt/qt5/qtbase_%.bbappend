PACKAGECONFIG_GL_tegra = "gles2"
PACKAGECONFIG_EXAMPLES ?= "examples"

#qtbase must be configured with icu for qtwebkit
PACKAGECONFIG_append_tegra = " \
    icu \
    ${PACKAGECONFIG_EXAMPLES} \
"

PACKAGECONFIG_append_vf = " \
    icu \
    ${PACKAGECONFIG_EXAMPLES} \
"
