## Process this file with automake to produce Makefile.in.

AUTOMAKE_OPTIONS = subdir-objects 1.12
ACLOCAL_AMFLAGS = -I m4

AM_CFLAGS = \
	$(LIBYANG_CFLAGS) \
	$(SQLITE3_CFLAGS) \
	$(UNWIND_CFLAGS) \
	$(SAN_FLAGS) \
	$(WERROR) \
	# end
AM_CPPFLAGS = \
	-I$(top_srcdir) -I$(top_srcdir)/lib \
	-I$(top_builddir) -I$(top_builddir)/lib \
	$(LUA_INCLUDE) \
	# end
AM_LDFLAGS = \
	-export-dynamic \
	$(AC_LDFLAGS) \
	$(SAN_FLAGS) \
	# end
DEFS = @DEFS@ -DSYSCONFDIR=\"$(sysconfdir)/\" -DCONFDATE=$(CONFDATE)

AR_FLAGS = @AR_FLAGS@
ARFLAGS = @ARFLAGS@
RANLIB = @RANLIB@

# these two targets are provided to easily grab autoconf/Makefile variables
# you can use either:
#   eval `make VARFD=3 shvar-CFLAGS 3>&1 1>&2`
#   CFLAGS="`make VARFD=3 var-CFLAGS 3>&1 1>&2`"
# where the former can be used to set several variables at once.  Note the
# fd redirections -- this is to prevent garbage from make rebuilding other
# targets from causing issues.
.PHONY: shvar-% var-%
VARFD ?= 1
shvar-%:
	@echo "$*=\"$($*)\"" >&$(VARFD)
var-%:
	@echo "$($*)" >&$(VARFD)

if ONLY_CLIPPY
.DEFAULT_GOAL := clippy-only
endif
clippy-only: Makefile lib/clippy config.h
.PHONY: clippy-only

# overwriting these vars breaks cross-compilation.  let's be helpful and warn.
#
# note: "#AUTODERP# " will be removed from Makefile by configure.  These are
# GNU make directives & automake will f*ck them up by trying to process them
# as automake directives.
#
#AUTODERP# null=
#AUTODERP# SPACE=$(null) $(null)
#AUTODERP# mkcheck_CC =       $(findstring $(SPACE)CC=,      $(SPACE)$(MAKEOVERRIDES))
#AUTODERP# mkcheck_CFLAGS =   $(findstring $(SPACE)CFLAGS=,  $(SPACE)$(MAKEOVERRIDES))
#AUTODERP# mkcheck_CPPFLAGS = $(findstring $(SPACE)CPPFLAGS=,$(SPACE)$(MAKEOVERRIDES))
#AUTODERP# mkcheck_CCLD =     $(findstring $(SPACE)CCLD=,    $(SPACE)$(MAKEOVERRIDES))
#AUTODERP# mkcheck_LD =       $(findstring $(SPACE)LD=,      $(SPACE)$(MAKEOVERRIDES))
#AUTODERP# mkcheck_LDFLAGS =  $(findstring $(SPACE)LDFLAGS=, $(SPACE)$(MAKEOVERRIDES))
#AUTODERP# #
#AUTODERP# ifneq ($(mkcheck_CC),)
#AUTODERP#   $(warning WARNING: you have overwritten the "CC" variable on the make command line.)
#AUTODERP# endif
#AUTODERP# ifneq ($(mkcheck_CFLAGS),)
#AUTODERP#   $(warning WARNING: you have overwritten the "CFLAGS" variable on the make command line.)
#AUTODERP# endif
#AUTODERP# ifneq ($(mkcheck_CPPFLAGS),)
#AUTODERP#   $(warning WARNING: you have overwritten the "CPPFLAGS" variable on the make command line.)
#AUTODERP# endif
#AUTODERP# ifneq ($(mkcheck_CCLD),)
#AUTODERP#   $(warning WARNING: you have overwritten the "CCLD" variable on the make command line.)
#AUTODERP# endif
#AUTODERP# ifneq ($(mkcheck_LD),)
#AUTODERP#   $(warning WARNING: you have overwritten the "LD" variable on the make command line.)
#AUTODERP# endif
#AUTODERP# ifneq ($(mkcheck_LDFLAGS),)
#AUTODERP#   $(warning WARNING: you have overwritten the "LDFLAGS" variable on the make command line.)
#AUTODERP# endif
#AUTODERP# #
#AUTODERP# ifneq ($(mkcheck_CC)$(mkcheck_CFLAGS)$(mkcheck_CPPFLAGS)$(mkcheck_CCLD)$(mkcheck_LD)$(mkcheck_LDFLAGS),)
#AUTODERP#   $(warning ------)
#AUTODERP#   $(warning While overwriting these variables works most of the time, it is not recommended and can cause confusing build errors.)
#AUTODERP#   $(warning This is especially problematic when cross-compiling, since tools that run on the build system during the build process will not be compiled correctly.)
#AUTODERP#   $(warning All of these variables should be supplied to 'configure', and they will be remembered and correctly applied during 'make'.)
#AUTODERP#   $(warning ------)
#AUTODERP# endif

EXTRA_DIST =
BUILT_SOURCES =
CLEANFILES =
DISTCLEANFILES =

examplesdir = $(exampledir)

bin_PROGRAMS =
sbin_PROGRAMS =
sbin_SCRIPTS =
noinst_PROGRAMS =
noinst_HEADERS =
noinst_LIBRARIES =
nodist_noinst_DATA =
lib_LTLIBRARIES =
module_LTLIBRARIES =
pkginclude_HEADERS =
nodist_pkginclude_HEADERS =
dist_examples_DATA =
dist_yangmodels_DATA =
man_MANS =
vtysh_scan =

## libtool, the self-made GNU scourge
## ... this should fix relinking
## ... and AUTOMAKE_DUMMY is needed to prevent automake from treating this
##     as overriding the normal targets...
$(AUTOMAKE_DUMMY)install-moduleLTLIBRARIES: install-libLTLIBRARIES
$(AUTOMAKE_DUMMY)install-binPROGRAMS: install-libLTLIBRARIES
$(AUTOMAKE_DUMMY)install-sbinPROGRAMS: install-libLTLIBRARIES

include lib/subdir.am
include yang/subdir.am

include vtysh/subdir.am

clean-local: clean-python
.PHONY: clean-python
clean-python:
	find . -name __pycache__ -o -name .pytest_cache | xargs rm -rf
	find . -name "*.pyc" -o -name "*_clippy.c" | xargs rm -f

redistclean:
	$(MAKE) distclean CONFIG_CLEAN_FILES="$(filter-out $(EXTRA_DIST), $(CONFIG_CLEAN_FILES))"
