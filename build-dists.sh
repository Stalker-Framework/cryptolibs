#! /bin/bash

build_all() {
    build_openssl
    build_mbedtls
    build_hacl
}

build_openssl() {
    dst=`pwd`/dist/openssl
    cd src/openssl
    ./config --prefix=$dst
    echo "== Building OpenSSL"
    make
    echo "== Installing files to $dst"
    make install
}

build_mbedtls() {
    dst=`pwd`/dist/mbedtls
    cd src/mbedtls
    mkdir -p build && cd build
    cmake -DUSE_SHARED_MBEDTLS_LIBRARY=On -DCMAKE_INSTALL_PREFIX=$dst ..
    echo "== Building hacl-star"
    make
    echo "== Installing files to $dst"
    make install
}

build_hacl() {
    dst=`pwd`/dist/hacl-star
    cd src/hacl-star/dist/gcc-compatible
    ../configure --disable-ocaml
    echo "== Building hacl-star"
    make
    echo "== Installing files to $dst"
    mkdir -p $dst/lib $dst/include
    cp ./*.h $dst/include
    cp ./*.so ./*.a $dst/lib
}

build_all
