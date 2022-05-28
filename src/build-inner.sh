#!/bin/bash
apt-get update && apt-get -y upgrade
apt install -y gcc wget libjpeg62-turbo-dev

mkdir -p /opt/dcraw/src
wget http://www.dechifro.org/dcraw/dcraw.c -O /opt/dcraw/src/dcraw.c
mkdir -p /opt/dcraw/bin

gcc -o /target/dcraw -static -O4 -D NO_JASPER -D NO_LCMS /opt/dcraw/src/dcraw.c -lm -ljpeg
