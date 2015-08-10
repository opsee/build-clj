#!/bin/bash

cd /build

if [ -x build.sh ]; then
	echo "Running project local build steps..."
	./build.sh
fi

lein uberjar
