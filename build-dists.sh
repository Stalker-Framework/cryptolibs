#! /bin/bash

jobs=16

build_all() {
    build_mbedtls
    build_hacl
    build_common_make libgcrypt libgcrypt
    build_common_make libressl LibreSSL
    build_common_make openssl OpenSSL
    build_common_make libsodium LibSodium
}

build_common_make() {
    pushd .
    dst=`pwd`/dist/$1
    cd src/$1
    if [ -f ./autogen.sh ]; then
        ./autogen.sh
    fi
    ./configure --prefix=$dst
    echo "== Building $2"
    make -j $jobs
    echo "== Installing files to $dst"
    make install
    popd
}

build_mbedtls() {
    pushd .
    dst=`pwd`/dist/mbedtls
    cd src/mbedtls
    mkdir -p build && cd build
    cmake -DUSE_SHARED_MBEDTLS_LIBRARY=On -DCMAKE_INSTALL_PREFIX=$dst ..
    echo "== Building hacl-star"
    make -j $jobs
    echo "== Installing files to $dst"
    make install
    popd
}

build_hacl() {
    pushd .
    dst=`pwd`/dist/hacl-star
    cd src/hacl-star/dist/gcc-compatible
    ../configure --disable-ocaml
    echo "== Building hacl-star"
    make -j $jobs
    echo "== Installing files to $dst"
    mkdir -p $dst/lib $dst/include
    cp ./*.h $dst/include
    cp ./*.so ./*.a $dst/lib
    popd
}

build_all
