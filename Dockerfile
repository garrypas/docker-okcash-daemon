# OK source GiT: https://github.com/okcashpro/okcash
# OK daemon Docker GiT: https://github.com/okcashpro/docker-okcash-daemon

# Dockerfile for building and deploying an OKCash daemon.

FROM ubuntu:latest

MAINTAINER oktoshi <devteam@okcash.co>

RUN apt-get update --yes && apt-get upgrade --yes && \
    apt-get install --yes software-properties-common && \
    apt-get update --yes && apt-get install --yes \
    autoconf \
    automake \
    autotools-dev \
    bsdmainutils \
    build-essential \
    git \
    libboost-all-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-thread-dev \
#    libdb++-dev \
#    libdb-dev \
    libevent-dev \
    libminiupnpc-dev \
    libprotobuf-dev \
    libqrencode-dev \
    libqt5core5a \
    libqt5dbus5 \
    libqt5gui5 \
    libqt5webkit5-dev  \
    libsqlite3-dev \
    libssl-dev \
    libtool \
    pkg-config \
    protobuf-compiler \
    qt5-default \
    qtbase5-dev \
    qtdeclarative5-dev \
    qttools5-dev \
    qttools5-dev-tools \
    wget

RUN wget http://download.oracle.com/berkeley-db/db-4.8.30.zip && \
    unzip db-4.8.30.zip && \
    cd db-4.8.30 && \
    cd build_unix/ && \
    ../dist/configure --prefix=/usr/local  --enable-mingw --enable-cxx && \
    make && \
    make install

RUN git clone https://github.com/okcashpro/okcash /node/okcashsource

WORKDIR /node/okcashsource/src

RUN make -f makefile.unix USE_UPNP=- && strip okcashd && mv okcashd /node/okcashd && rm -rf /node/okcashsource

WORKDIR /node
VOLUME ["/node/home"]

ENV HOME /node/home

CMD ["/node/okcashd"]

# PORT, RPCPORT
EXPOSE 6970 6969