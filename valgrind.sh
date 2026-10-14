#!/bin/sh

set -e

export VALGRIND_OPTS="--show-leak-kinds=all"
CFLAGS='-ansi -pedantic -Wall -g -O0 -D_POSIX_C_SOURCE=200809L' make clean all
./test.pl --valgrind
make clean
