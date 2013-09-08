#!/bin/sh

echo "Just run autoreconf with your favorite flags instead."

set -e
set -x
test -x `which aclocal` && aclocal -I config -I m4
test -x `which glibtoolize` && glibtoolize --automake --copy --force
test -x `which autoheader` && autoheader --force --warnings=all
test -x `which automake` && automake --add-missing --include-deps --copy --force-missing
test -x `which autoconf` && autoconf --force --warnings=all
test -e spl_config.h.in~ && rm -f spl_config.h.in~
test -e autom4te.cache && rm -rf autom4te.cache
