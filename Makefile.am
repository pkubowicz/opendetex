bin_PROGRAMS = detex

detex_SOURCES = detex.h detex.l
detex_AMCFLAGS = -O
# detex_AMCPPFLAGS = -DVERSION=\"${VERSION}\"

dist_man_MANS = detex.1

TESTS = test.pl
TEST_EXTENSIONS = .pl
PL_LOG_COMPILER = $(PERL)
AM_PL_LOG_FLAGS = -w

PL_LOG_DRIVER = env AM_TAP_AWK='$(AWK)' $(SHELL) \
	$(top_srcdir)/aux_files/tap-driver.sh

dist_check_DATA = test/correct.txt test/in.tex test/noinclude.tex	\
	test/noinclude-correct.txt test/nouns.tex			\
	test/nouns-correct.txt test/part.tex test/unterminated.txt	\
	test/words.tex test/words-correct.txt
dist_check_SCRIPTS = test.pl valgrind.sh

EXTRA_DIST = ChangeLog COPYRIGHT INSTALL README README-development.md \
	CONTRIBUTING Makefile.sample

install-exec-hook:
	(cd "$(DESTDIR)$(bindir)" && rm -f delatex && $(LN_S) detex$(EXEEXT) delatex)

uninstall-hook:
	(cd "$(DESTDIR)$(bindir)" && rm -f delatex)

installcheck-local:
	test -x "$(DESTDIR)$(bindir)/detex$(EXEEXT)"
	test -x "$(DESTDIR)$(bindir)/delatex"

check-valgrind:
	./test.pl --valgrind

print: detex.h detex.l
	lpr -p Makefile detex.h detex.l

ACLOCAL_AMFLAGS = -I m4
