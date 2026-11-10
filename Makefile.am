AUTOMAKE_OPTIONS = foreign

SUBDIRS = thirdparty

dist_bin_SCRIPTS = bin/zimdiff
dist_sysconf_DATA = etc/zimdiff.conf.dist
man1_MANS = man/zimdiff.1

EXTRA_DIST = VERSION cpanfile bootstrap README.md LICENSE docs/email.png t/smoke.sh

TESTS = t/smoke.sh
AM_TESTS_ENVIRONMENT = PERL='$(PERL)'; export PERL;

CLEANFILES = man/zimdiff.1

man/zimdiff.1: bin/zimdiff VERSION
	$(AM_V_GEN)$(MKDIR_P) man; $(POD2MAN) --release=$(VERSION) --center=$(PACKAGE_NAME) --name=zimdiff $(srcdir)/bin/zimdiff > $@

# point the installed script at the installed modules, config and state
install-exec-hook:
	$(PERL) -i -p \
	  -e 's{^#!.*perl.*}{#!$(PERL)};' \
	  -e 's{^use lib .*# LIBDIR}{use lib "$(libdir)"; # LIBDIR};' \
	  -e 's{^our \$$VERSION = .*# VERSION}{our \$$VERSION = q{$(PACKAGE_VERSION)}; # VERSION};' \
	  -e 's{^my %opt = .*# CONFFILE}{my %opt = (config => "$(sysconfdir)/zimdiff.conf"); # CONFFILE};' \
	  -e 's{^(\s+my \$$var = path\(\$$cfg->\{cache_dir\} // ).*# VARDIR}{$$1"$(localstatedir)"); # VARDIR};' \
	  "$(DESTDIR)$(bindir)/zimdiff"

# the state directory holds the trusted token, so only the owner may read it
install-data-local:
	$(MKDIR_P) "$(DESTDIR)$(localstatedir)"
	chmod 700 "$(DESTDIR)$(localstatedir)"
