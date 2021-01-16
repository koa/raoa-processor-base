FROM debian:10.6 as dcraw-build

RUN apt-get update && apt-get -y upgrade
RUN apt install -y gcc wget libjpeg62-turbo-dev

RUN mkdir -p /opt/dcraw/src; \
    wget http://www.dechifro.org/dcraw/dcraw.c -O /opt/dcraw/src/dcraw.c; \
    mkdir -p /opt/dcraw/bin
RUN gcc -o /opt/dcraw/bin/dcraw -static -O4 -D NO_JASPER -D NO_LCMS /opt/dcraw/src/dcraw.c -lm -ljpeg

FROM gcr.io/distroless/java:11 as target
COPY --from=dcraw-build /opt/dcraw/bin/dcraw /usr/bin/dcraw
