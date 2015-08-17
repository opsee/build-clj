#!/bin/bash

cd /build

if [ -x build.sh ]; then
	echo "Running project local build steps..."
	./build.sh
fi

if [ "$1" = "nobuild" ]; then
	echo "Not building the project."
	exit 0
fi

lein midje
if [ $? -ne 0 ]; then
	echo "Tests failed -- bailing out..."
	exit 1
fi

lein uberjar
