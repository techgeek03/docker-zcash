FROM ubuntu:xenial
MAINTAINER Gordan Jandreoski

# Usual update / upgrade
RUN apt-get update && \
    apt-get -y -qq upgrade && \    
    apt-get -y -qq build-essential pkg-config libc6-dev m4 g++-multilib \
                    autoconf libtool ncurses-dev unzip git python \
                    zlib1g-dev wget bsdmainutils automake
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir -P /src/zcash
WORKDIR /src/zcash

RUN git clone https://github.com/zcash/zcash.git /src/zcash
RUN git checkout v1.0.0-rc4
RUN ./zcutil/fetch-params.sh
RUN ./zcutil/build.sh -j$(nproc)