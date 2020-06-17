## Coding conventions

Use tabs for indentation, however try to minimize changes and don't re-format lines that aren't part of your task. The project has a long history and when most of the code was created, there were many authors but no coding conventions.

## Building

Compiling:
```
make
```

Running tests:
```
make test
```

It is recommended that you install Valgrind and run tests using it (as it is done in Travis CI):
```
./test.pl --valgrind
```

Also recommended: check if compilation is not broken on oldest compilers supported by Tex Live (again, if you don't do this, it will be checked on CI):
```
make clean all DEFS='-std=iso9899:199409'
```

After pushing check cross-platform compilation results on commits list on GitHub or directly on [Travis CI](https://travis-ci.org/pkubowicz/opendetex).

## Releasing a new version

1. Make sure you have GnuPG configured in order to sign commits
2. Run `./release.sh` which will
- create a commit releasing the current version and tag it
- create a `.tar.bz2` file with the released version
- create a commit starting work on the next version
3. git-push using the instruction printed by the script
4. On GitHub go to Code → Releases → Draft a new release
  - attach the `.tar.bz2` file
