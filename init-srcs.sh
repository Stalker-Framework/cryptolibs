#!/bin/bash

init_srcs() {
    git submodule update --init
    init_src_common cryptolib
}

init_src_common() {
    pushd .
    cd src/$1
    ./init-src.sh
    popd
}

init_srcs