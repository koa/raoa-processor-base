FROM ubuntu:24.04 as dcraw-build

RUN apt-get update && apt-get -y upgrade && apt install -y gcc wget libjpeg-turbo8-dev libva-drm2 libva2 i965-va-driver

RUN mkdir -p /opt/dcraw/src; \
    wget http://www.dechifro.org/dcraw/dcraw.c -O /opt/dcraw/src/dcraw.c; \
    mkdir -p /opt/dcraw/bin
RUN gcc -o /opt/dcraw/bin/dcraw -static -O4 -D NO_JASPER -D NO_LCMS /opt/dcraw/src/dcraw.c -lm -ljpeg

FROM docker.io/jrottenberg/ffmpeg:7.1.1-vaapi2404 as ffmpeg-source

FROM ubuntu:24.04 as target

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64

COPY --from=dcraw-build /opt/dcraw/bin/dcraw /usr/bin/dcraw

COPY --from=ffmpeg-source /usr/local /usr/local/
COPY --from=ffmpeg-source /usr/lib/x86_64-linux-gnu/libssl.so.3 /usr/lib/x86_64-linux-gnu/
COPY --from=ffmpeg-source /usr/lib/x86_64-linux-gnu/libcrypto.so.3 /usr/lib/x86_64-linux-gnu/
