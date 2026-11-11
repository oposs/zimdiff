#!/bin/sh
# Check the script against the bundled modules of the build tree. In a VPATH
# build the modules are in the build tree, not next to $srcdir/bin.
set -e
: "${PERL:=perl}"
: "${THIRDPARTY_LIB:=$srcdir/thirdparty/lib/perl5}"

$PERL -I"$THIRDPARTY_LIB" -e '
    use Mojolicious; use IO::Socket::SSL; use Net::SSLeay; use Authen::SASL;
    for my $m ("Mojolicious.pm", "IO/Socket/SSL.pm", "Net/SSLeay.pm", "Authen/SASL.pm") {
        index($INC{$m}, $ARGV[0]) == 0 or die "$m loaded from $INC{$m}, not $ARGV[0]\n";
    }' "$THIRDPARTY_LIB"
$PERL -I"$THIRDPARTY_LIB" -c "$srcdir/bin/zimdiff"
$PERL -I"$THIRDPARTY_LIB" "$srcdir/bin/zimdiff" --version | grep -q '^zimdiff '

# --install-service and --uninstall-service with --no-action touch nothing
units=$(mktemp -d)
trap 'rm -rf "$units"' EXIT
XDG_CONFIG_HOME=$units $PERL -I"$THIRDPARTY_LIB" "$srcdir/bin/zimdiff" \
    --no-action --install-service=06:30 2>/dev/null > "$units/out"
grep -q '^OnCalendar=\*-\*-\* 06:30:00$' "$units/out"
grep -q '^ExecStart=/' "$units/out"
XDG_CONFIG_HOME=$units $PERL -I"$THIRDPARTY_LIB" "$srcdir/bin/zimdiff" \
    --no-action --uninstall-service | grep -q '^No zimdiff units'
test ! -e "$units/systemd"
