#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
SHED_PKG_LOCAL_PREFIX='/usr'
SHED_PKG_LOCAL_GUILE_OPTION=''
if [ -n "${SHED_PKG_LOCAL_OPTIONS[toolchain]}" ]; then
    SHED_PKG_LOCAL_PREFIX='/tools'
    SHED_PKG_LOCAL_GUILE_OPTION='--without-guile'
fi
# Workaround for compilation issue with glibc 2.27
sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c &&
# Configure
./configure --prefix=$SHED_PKG_LOCAL_PREFIX \
            $SHED_PKG_LOCAL_GUILE_OPTION &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
