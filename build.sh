#!/bin/bash
# Workaround for compilation issue with glibc 2.27
sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c
case "$SHED_BUILD_MODE" in
    toolchain)
        ./configure --prefix=/tools \
                    --without-guile || exit 1
        ;;
    *)
        ./configure --prefix=/usr || exit 1
        ;;
esac
make -j $SHED_NUM_JOBS && \
make DESTDIR="$SHED_FAKE_ROOT" install
