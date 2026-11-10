AUTOMAKE_OPTIONS = foreign

THIRDPARTY_DIR := $(abs_builddir)

all-local: touch

# modules from ../cpanfile go to lib/perl5, also those perl already has,
# so the installation does not depend on distribution perl packages
touch: $(top_srcdir)/cpanfile bin/cpanm
	$(AM_V_at)echo "** Installing Perl modules from cpanfile"
	PERL_CPANM_OPT= PERL_CPANM_HOME=$(THIRDPARTY_DIR)/.cpanm $(PERL) bin/cpanm -q --notest --no-man-pages --local-lib-contained $(THIRDPARTY_DIR) --installdeps $(top_srcdir)
	$(AM_V_at)touch touch

bin/cpanm:
	$(AM_V_at)$(MKDIR_P) bin
	$(URL_CAT) https://cpanmin.us > bin/cpanm
	$(AM_V_at)chmod 755 bin/cpanm

install-exec-local:
	$(MKDIR_P) "$(DESTDIR)$(libdir)"
	cp -fr lib/perl5/* "$(DESTDIR)$(libdir)"

clean-local:
	rm -rf lib bin .cpanm touch
