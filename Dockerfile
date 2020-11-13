FROM debian:10.6 as dcraw-build

RUN apt update
RUN apt install -y gcc wget libjpeg62-turbo-dev

RUN mkdir -p /opt/dcraw/src; \
    wget http://www.dechifro.org/dcraw/dcraw.c -O /opt/dcraw/src/dcraw.c; \
    mkdir -p /opt/dcraw/bin
RUN gcc -o /opt/dcraw/bin/dcraw -static -O4 -D NO_JASPER -D NO_LCMS /opt/dcraw/src/dcraw.c -lm -ljpeg

FROM docker.io/library/openjdk:11-slim as target
COPY --from=dcraw-build /opt/dcraw/bin/dcraw /opt/bin/dcraw
ENV PATH="/opt/bin:${PATH}"
