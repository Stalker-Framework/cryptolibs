#!/bin/bash

wget -qO- https://cryptlib-release.s3-ap-southeast-1.amazonaws.com/cryptlib346.zip | bsdtar -xvf-
sed -i -e "s/\r//g" makefile
sed -i -e "s/\r//g" ./tools/*.sh