FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get --assume-yes install software-properties-common && \
    apt-get updgdaate && \
    apt-get --assume-yes install gdal-bin libgdal-dev build-essential cmake libboost-program-options-dev libboost-filesystem-dev && \
    apt-get clean && \
    dpkg -l | grep -i gdal

ADD . /usr/local/src/tin-terrain/
RUN mkdir /var/tmp/tin-terrain-build/

WORKDIR /var/tmp/tin-terrain-build/

RUN cmake -DCMAKE_BUILD_TYPE=Release /usr/local/src/tin-terrain/ && \
    VERBOSE=1 make -j$(nproc) && \
    cp ./tin-terrain /usr/local/bin/ && \
    rm -rf /var/tmp/tin-terrain-build/

WORKDIR /home
