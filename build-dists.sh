#! /bin/bash

build_all() {
    build_hacl
    build_openssl
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

build_hacl() {
    dst=`pwd`/dist/hacl-star
    cd src/hacl-star/dist/gcc-compatible
    # ../configure --disable-ocaml
    echo "== Building hacl-star"
    make
    echo "== Installing files to $dst"
    mkdir -p $dst/lib $dst/include
    cp ./*.h $dst/include
    cp ./*.so ./*.a $dst/lib
}

build_hacl
