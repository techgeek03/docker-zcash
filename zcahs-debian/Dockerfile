FROM debian:jessie
MAINTAINER Gordan Jandreoski

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /zcash
WORKDIR /zcash

# Usual update / upgrade
RUN apt-get update && \
    apt-get -y install  apt-transport-https \
                        wget \
                        git

RUN wget -qO - https://apt.z.cash/zcash.asc | apt-key add -
RUN echo "deb [arch=amd64] https://apt.z.cash/ jessie main" | tee /etc/apt/sources.list.d/zcash.list

RUN apt-get update && \
    apt-get -y install zcash

RUN git clone https://github.com/zcash/zcash.git
WORKDIR /zcash/zcash/
RUN git checkout v1.0.1
RUN ./zcutil/fetch-params.sh

RUN mkdir -p ~/.zcash
RUN echo "addnode=mainnet.z.cash" >~/.zcash/zcash.conf
RUN echo "rpcuser=username" >>~/.zcash/zcash.conf
RUN echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >>~/.zcash/zcash.conf

EXPOSE 18232

#ENTRYPOINT ["/src/zcash/src/zcashd", "--daemon"]