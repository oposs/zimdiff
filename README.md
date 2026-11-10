# zimdiff

Reports changes in Zimbra calendars by mail. Each run compares the
appointments of the configured calendars with the previous run and sends
an HTML mail listing new, changed and deleted appointments.

## Install

```sh
./bootstrap            # only in a fresh checkout
./configure --prefix=/opt/zimdiff
make
make install
```

`configure` needs perl 5.26 or newer, a C compiler and the OpenSSL headers.
`make` installs the Perl modules from `cpanfile` into `thirdparty/`.

## Setup

```sh
cd /opt/zimdiff
cp etc/zimdiff.conf.dist etc/zimdiff.conf
chmod 600 etc/zimdiff.conf
$EDITOR etc/zimdiff.conf
bin/zimdiff --login    # asks for the OTP if the account uses two factor authentication
bin/zimdiff            # first run stores the current state
```

Run it from cron, for example daily at 07:00:

```
0 7 * * * /opt/zimdiff/bin/zimdiff > /dev/null
```

`bin/zimdiff --man` documents the options and config keys.

The source tree runs without installing: after `make`, `bin/zimdiff` uses
`etc/` and `var/` of the tree.
