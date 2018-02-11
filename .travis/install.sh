#!/bin/sh

if [ "$TRAVIS_OS_NAME" = 'osx' ]; then
	echo OSX
else
	sudo apt-get -qq update
	sudo apt-get install -y flex valgrind
fi
