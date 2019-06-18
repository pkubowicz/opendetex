#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([opendetex], [2.8.6-UNRELEASED], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([detex.h])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR([aux_files])
AC_CONFIG_MACRO_DIR([m4])
AC_REQUIRE_AUX_FILE([tap-driver.sh])

AM_INIT_AUTOMAKE([foreign dist-bzip2])

# Checks for programs.
AC_PROG_CC
AC_PROG_LEX
AX_PROG_FLEX([AC_SUBST([FLEX_SCANNER], [1])], [])
AC_PROG_LN_S
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PATH_PROG([PERL], [perl])
AX_CFLAGS_WARN_ALL

# Checks for libraries.
# FIXME: Replace `main' with a function in `-lfl':
AC_CHECK_LIB([fl], [yylex])
# also yywrap, yyrestart

# Checks for header files.
AC_CHECK_HEADERS([fcntl.h stdlib.h string.h strings.h sys/param.h limits.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL

# Checks for library functions.
AC_FUNC_MALLOC
AC_CHECK_FUNCS([strchr strrchr])

AC_CONFIG_FILES([Makefile test.pl])
dnl AC_CONFIG_LINKS([correct.txt:test/correct.txt in.tex:test/in.tex
dnl     noinclude.tex:test/noinclude.tex
dnl     noinclude-correct.txt:test/noinclude-corrext.txt
dnl     nouns.tex:test/nouns.tex nouns-correct.txt:test/nouns-correct.txt
dnl     part.tex:test/part.tex unterminated.txt:test/unterminated.txt
dnl     words.tex:test/words.tex words-correct.txt:test/words-correct.txt])
AC_CONFIG_LINKS([part.tex:test/part.tex])
AC_OUTPUT
