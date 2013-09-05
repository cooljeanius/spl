#!/bin/sh

echo "Just run autoreconf with your favorite flags instead."

set -e
set -x
aclocal -I config -I m4
glibtoolize --automake --copy --force
autoheader --force --warnings=all
automake --add-missing --include-deps --copy --force-missing
autoconf --force --warnings=all
