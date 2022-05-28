#!/bin/bash
version=$(date "+%Y%m%d%H%M%S")
mkdir target
podman run --mount=type=bind,src=$(pwd)/src,destination=/src --mount=type=bind,src=$(pwd)/target,destination=/target --rm debian:10.6  /src/build-inner.sh
