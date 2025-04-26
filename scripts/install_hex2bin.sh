#!/bin/bash
if [ ! -f hex2bin.zip ]; then
    wget https://github.com/algodesigner/hex2bin/archive/refs/heads/master.zip -O hex2bin.zip
fi
if [ ! -d hex2bin-master ]; then
    unzip hex2bin.zip
fi
cd hex2bin-master && make && cd ..
cp hex2bin-master/hex2bin bin/hex2bin
rm -rf hex2bin-master
rm -rf hex2bin.zip