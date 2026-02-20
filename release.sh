#!/bin/bash

VERSION=$(head -1 README | perl -ne '/Version (\d+\.\d+\.\d+)/; print $1')
NEXT_VERSION=$(echo "$VERSION" | perl -ne '/(\d+\.\d+\.)(\d+)/; print $1,$2+1')

echo "Last tag is $(git tag | tail -1)"
echo "Releasing $VERSION, then bumping to $NEXT_VERSION"

git tag | grep "$VERSION"

if git tag | grep -q "$VERSION"; then
	echo "Error: this version already exists."
	exit 2
fi

set -e

if [[ -n $(git status --porcelain --untracked-files=no) ]]; then
	echo "Error: make sure you committed everything"
	exit 3
fi

CHANGELOG_DATE=$(LC_TIME=en_US date '+%B, %Y')
sed -i "s/UNRELEASED/$CHANGELOG_DATE/" ChangeLog
sed -i "s/-SNAPSHOT//" Makefile
sed -i "s/ UNRELEASED//" README

make clean test package
git commit -a -S -m "Release $VERSION"
git tag -s v"$VERSION" -m "$VERSION" HEAD

echo -e "\n(Version $NEXT_VERSION) -- UNRELEASED" >> ChangeLog
sed -i "s/$VERSION/$NEXT_VERSION-SNAPSHOT/" Makefile
sed -i "s/$VERSION/$NEXT_VERSION UNRELEASED/" README
git diff -U1 HEAD^
git commit -a -m "Start developing $NEXT_VERSION"

echo -e "\nInspect commits and run\ngit push origin master v$VERSION"
