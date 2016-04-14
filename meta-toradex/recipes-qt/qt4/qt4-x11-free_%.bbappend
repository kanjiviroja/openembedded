# Build OpenGL/ES support if available

QT_GLFLAGS_tegra = "-opengl es2 "

DEPENDS_append_tegra += "virtual/libgles2"
