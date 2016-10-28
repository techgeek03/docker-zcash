FROM ubuntu:xenial
MAINTAINER Gordan Jandreoski

ENV DEBIAN_FRONTEND noninteractive

# Usual update / upgrade
RUN apt-get update && \
    apt-get -y -qq upgrade && \
    apt-get -y install  build-essential \
                        pkg-config \
                        libc6-dev \
                        m4 \
                        g++-multilib \
                        autoconf \
                        libtool \
                        ncurses-dev \
                        unzip \
                        git \
                        python \
                        zlib1g-dev \
                        wget \
                        bsdmainutils \
                        automake && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /src/zcash
WORKDIR /src/zcash

RUN git clone https://github.com/zcash/zcash.git /src/zcash
RUN git checkout v1.0.0
RUN ./zcutil/fetch-params.sh
RUN ./zcutil/build.sh -j$(nproc)
RUN mkdir -p ~/.zcash
RUN echo "addnode=mainnet.z.cash" >~/.zcash/zcash.conf
RUN echo "rpcuser=username" >>~/.zcash/zcash.conf
RUN echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >>~/.zcash/zcash.conf