FROM        ubuntu:16.04
MAINTAINER  taegeun@skku.edu

RUN         apt -y update
RUN         apt -y install build-essential vim

# Install libblake3
COPY        ./libblake3.so /usr/local/lib
ENV         LD_LIBRARY_PATH /usr/local/lib

# Install libgcrypt
COPY        ./libgcrypt-1.8.5 /usr/src/libgcrypt-1.8.5
COPY        ./libgpg-error-1.38 /usr/src/libgpg-error-1.38
RUN         cd /usr/src/libgpg-error-1.38 && ./configure && make install
RUN         cd /usr/src/libgcrypt-1.8.5 && ./configure && make install

# Copy PexCoin Compressor
COPY        ./compressor /usr/src/compressor
WORKDIR     /usr/src/compressor

RUN         gcc -o markers_to_brs markers_to_brs.c
RUN         make


WORKDIR     /usr/src