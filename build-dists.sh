#! /bin/bash

JOBS=16

build_all() {
    build_openssl
    build_mbedtls
    build_hacl
    build_libressl
}

build_openssl() {
    pushd .
    dst=`pwd`/dist/openssl
    cd src/openssl
    ./config --prefix=$dst
    echo "== Building OpenSSL"
    make -j $JOBS
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
    make -j $JOBS
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
    make -j $JOBS
    echo "== Installing files to $dst"
    mkdir -p $dst/lib $dst/include
    cp ./*.h $dst/include
    cp ./*.so ./*.a $dst/lib
    popd
}

build_libressl() {
    pushd .
    dst=`pwd`/dist/libressl
    cd src/libressl
    ./autogen.sh
    ./configure --prefix=$dst
    echo "== Building LibreSSL"
    make -j $JOBS
    echo "== Installing files to $dst"
    make install
    popd
}

build_all
