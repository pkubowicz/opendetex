#!/bin/sh

if [ "$TRAVIS_OS_NAME" = 'osx' ]; then
	brew install valgrind
fi
