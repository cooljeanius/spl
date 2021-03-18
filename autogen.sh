#!/bin/sh

echo "Just run autoreconf with your favorite flags instead."

set -e
set -x
test -n "`which aclocal`" && test -x "`which aclocal`" && aclocal -Iconfig -Im4 --install
test -n "`which glibtoolize`" && test -x "`which glibtoolize`" && glibtoolize --automake --copy --force
test -n "`which autoheader`" && test -x "`which autoheader`" && autoheader --force --warnings=all
test -n "`which automake`" && test -x "`which automake`" && automake --add-missing --include-deps --copy --force-missing
test -n "`which autoconf`" && test -x "`which autoconf`" && autoconf --force --warnings=all
test -e spl_config.h.in~ && rm -f spl_config.h.in~
test -e autom4te.cache && rm -rf autom4te.cache
