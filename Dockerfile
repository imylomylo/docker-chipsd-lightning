# Dockerfile must start with a FROM instruction
# FROM instruction specifies the Base Image from which you are building
# FROM <image>[:<tag>]
FROM ubuntu:16.04
# Install bitcoind from PPA
ENV BUILD_PACKAGES="software-properties-common autoconf git build-essential libtool libprotobuf-c-dev libgmp-dev libsqlite3-dev python python3 zip jq libevent-dev pkg-config libssl-dev curl libcurl4-gnutls-dev cmake libboost-all-dev automake jq"

RUN apt-get update && \
  apt-get install -y $BUILD_PACKAGES

RUN git clone https://github.com/jl777/chips3.git && \
  cd chips3 && \
  git checkout dev

ADD db-4.8.30.NC.tar.gz /chips3

RUN  cd /chips3/db-4.8.30.NC/build_unix/ && \ 
  ../dist/configure -enable-cxx -disable-shared -with-pic -prefix=/chips3/db4 && \
  make -j6 && \
  make install 

RUN cd /chips3 && \
  ./autogen.sh && \
  ./configure LDFLAGS="-L/chips3/db4/lib/" CPPFLAGS="-I/chips3/db4/include/" -without-gui -without-miniupnpc --disable-tests --disable-bench --with-gui=no && \
  make -j6

RUN ln -sf /chips3/src/chipsd /usr/local/bin/chipsd && \
  ln -sf /chips3/src/chips-cli /usr/local/bin/chips-cli 

# copy chips.conf
#ADD . /home/chips3
RUN mkdir /home/chips3    
# WORKDIR sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow
WORKDIR /home/chips3

# EXPOSE rpc port for the node to allow outside container access
EXPOSE 57777 57776

# There can only be one CMD instruction in a Dockerfile
# CMD provides defaults for an executing container
# Drop user into bash shell by default
#CMD ["/bin/bash"]
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

