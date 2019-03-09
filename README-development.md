## Building

Compiling:
```
make
```

Running tests:
```
make test
```

After pushing check cross-platform compilation results on commits list on GitHub or directly on [Travis CI](https://travis-ci.org/pkubowicz/opendetex).

## Releasing a new version

1. Create a commit setting version to stable:
  - ChangeLog: change UNRELEASED to current date
  - Makefile: strip -UNRELEASED from version number
  - README: remove UNRELEASED
2. Make sure it works: `make clean test package`
3. Git-tag this version like "v2.8.5"
4. Create a commit setting version to unstable
  - revert changes from step 1 and increment version
5. `git push && git push --tags`
6. On GitHub go to Code → Releases → Draft a new release
  - attach .tar.bz2 file created by `make package` from step 2
