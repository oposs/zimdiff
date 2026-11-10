AC_INIT([zimdiff],m4_esyscmd([tr -d '\n' < VERSION]))
AC_PREREQ([2.69])
AC_CONFIG_AUX_DIR(conftools)

AM_INIT_AUTOMAKE([1.11 tar-ustar foreign])
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_PREFIX_DEFAULT(/opt/zimdiff)

AC_ARG_VAR(PERL, [Path to the perl binary])
AC_PATH_PROG(PERL, perl, no)
AC_PATH_PROG(CURL, curl, no)
AC_PATH_PROG(WGET, wget, no)
AC_PATH_PROG(POD2MAN, pod2man, no)

if test "x$PERL" = xno; then
  AC_MSG_ERROR([perl not found])
fi

ac_perl_version="5.26.0"
AC_MSG_CHECKING([for perl $ac_perl_version or newer])
if $PERL -e "use v$ac_perl_version;" >/dev/null 2>&1; then
  AC_MSG_RESULT([yes])
else
  AC_MSG_RESULT([no])
  AC_MSG_ERROR([zimdiff needs perl $ac_perl_version or newer])
fi

AC_MSG_CHECKING([whether perl is complete])
if $PERL -MExtUtils::MakeMaker -MStorable -MNet::SMTP -e '' 2>/dev/null; then
  AC_MSG_RESULT([yes])
else
  AC_MSG_RESULT([no])
  AC_MSG_ERROR([a complete perl is required ('perl-core' on Red Hat)])
fi

perl_cc=`$PERL -MConfig -e 'print $Config{cc}'`
AC_PATH_PROG(PERL_CC_PATH, $perl_cc, no)
if test "x$PERL_CC_PATH" = xno; then
  AC_MSG_ERROR([perl needs the '$perl_cc' compiler to build Net::SSLeay])
fi

AC_CHECK_HEADER([openssl/ssl.h],[],[
  AC_MSG_ERROR([Net::SSLeay needs the 'libssl-dev' (Debian) or 'openssl-devel' (Red Hat) package])
])

if test -x "$WGET"; then
  URL_CAT="$WGET -q -O -"
elif test -x "$CURL"; then
  URL_CAT="$CURL --silent --location"
else
  AC_MSG_ERROR([neither curl nor wget found])
fi
AC_SUBST(URL_CAT)

if test "x$POD2MAN" = xno; then
  AC_MSG_ERROR([pod2man not found])
fi

AC_CONFIG_FILES([
    Makefile
    thirdparty/Makefile
])

AC_OUTPUT

cat <<NOTES

** CONFIGURE DONE **********************************************

  PERL   = $PERL
  prefix = $prefix

Continue with

  make
  make install

NOTES
