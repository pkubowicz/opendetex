#!/bin/sh

if [ "$TRAVIS_OS_NAME" = 'osx' ]; then
	brew install valgrind
else
	apt-get -qq update
	apt-get install -y flex valgrind
fi
