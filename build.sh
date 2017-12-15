#!/bin/bash
./configure --prefix=/usr
make -j $SHED_NUMJOBS
make DESTDIR=${SHED_FAKEROOT} install
