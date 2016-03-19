#!/bin/sh

export VALGRIND_OPTS="--show-leak-kinds=all"
make clean all CFLAGS='-ansi -pedantic -Wall -g -O0'
./test.pl --valgrind
make clean
