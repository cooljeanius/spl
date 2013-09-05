#                                                         -*- Autoconf -*-#
###########################################################################
# SPL AutoConf Configuration
###########################################################################
# Copyright (C) 2007-2010 Lawrence Livermore National Security, LLC.
# Copyright (C) 2007 The Regents of the University of California.
# Produced at Lawrence Livermore National Laboratory (cf, DISCLAIMER).
# Written by Brian Behlendorf <behlendorf1@llnl.gov>.
# UCRL-CODE-235197
#
# This file is part of the SPL, Solaris Porting Layer.
# For details, see <http://github.com/behlendorf/spl/>.
#
# The SPL is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your
# option) any later version.
#
# The SPL is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with the SPL.  If not, see <http://www.gnu.org/licenses/>.
###########################################################################

AC_PREREQ([2.69])
AC_INIT(m4_esyscmd([awk '/^Name:/ {print $2}' META | tr -d '\n']),
	m4_esyscmd([awk '/^Version:/ {print $2}' META | tr -d '\n']),
        [lundman@lundman.net])
dnl# the equivalent of: AC_INIT([$SPL_META_NAME],[$SPL_META_VERSION])
AC_CONFIG_SRCDIR([spl_config.h.in])
AC_CONFIG_AUX_DIR([config])
AC_CONFIG_MACRO_DIR([m4])
AC_LANG([C])
AC_CANONICAL_TARGET
AC_USE_SYSTEM_EXTENSIONS
AC_OBJEXT
AC_EXEEXT
SPL_AC_META
SPL_AC_CONFIG
AM_INIT_AUTOMAKE([1.11 foreign -Wall])
AM_MAINTAINER_MODE
AM_MISSING_PROG([KEXTUTIL],[kextutil])
if test "x$AWK" = "x"; then
	test -z "$AWK"
	AC_PROG_AWK
else
	test ! -z "$AWK"
	export AWK
	AC_SUBST([AWK])
fi
AC_CONFIG_HEADERS([spl_config.h],[
	(mv spl_config.h spl_config.h.tmp &&
	awk -f ${ac_srcdir}/config/config.awk spl_config.h.tmp >spl_config.h &&
	rm spl_config.h.tmp) || exit 1])

AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MKDIR_P

dnl# save $CFLAGS since AC_PROG_CC likes to insert "-g -O2"
dnl# if $CFLAGS is blank
cflags_save="$CFLAGS"
if test "x$CC" = "x"; then
	test -z "$CC"
	AC_PROG_CC
else
	test ! -z "$CC"
	export CC
	AC_SUBST([CC])
fi
AC_PROG_CXX
AC_PROG_OBJC
CFLAGS="$cflags_save"
AM_PROG_AR
LT_INIT
LT_LANG([C])
AM_PROG_AS
AM_PROG_CC_C_O
if test "x$RANLIB" = "x"; then
	test -z "$RANLIB"
	AC_PROG_RANLIB
else
	test ! -z "$RANLIB"
	export RANLIB
	AC_SUBST([RANLIB])
fi

PKG_PROG_PKG_CONFIG

AM_CONDITIONAL([CONFIG_KERNEL],[ true ])
AM_CONDITIONAL([CONFIG_USER],[ true ])

AC_PATH_PROG([XCRUN],[xcrun])
AC_PATH_PROG([KEXTLIBS],[kextlibs])
AC_PATH_PROG([KEXTLOAD],[kextload])
AC_PATH_PROG([RSYNC],[rsync])

# Checks for libraries.
# FIXME: Replace `main' with a function in `-lcc_kext':
AC_CHECK_LIB([cc_kext],[main])
# FIXME: Replace `main' with a function in `-lkmod':
AC_CHECK_LIB([kmod],[main])
# Note: Do NOT add checks for any other libraries
# (such as libc), because doing so can cause errors

# Checks for header files.
AC_CHECK_HEADERS([cdefs.h errno.h fcntl.h kern/debug.h kern/locks.h \
                  kern/thread.h libkern/libkern.h libkern/locks.h \
                  libkern/OSAtomic.h libkern/OSByteOrder.h mach/mach.h \
                  mach/vm_param.h machine/byte_order.h machine/limits.h \
                  signal.h stdio.h sys/cdefs.h sys/file.h sys/fcntl.h \
                  sys/ioctl.h sys/kernel.h sys/kernel_types.h sys/lock.h \
                  sys/mount.h sys/param.h sys/proc.h sys/signal.h \
                  sys/systeminfo.h sys/time.h sys/ucred.h sys/uio.h \
                  sys/vfs.h sys/vm.h sys/vnode.h time.h])
AC_CHECK_DECLS([NULL])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_UID_T
AC_C_BIGENDIAN
AC_C_INLINE
AC_C_PROTOTYPES
AC_TYPE_INT8_T
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_MODE_T
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UINT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_CHECK_SIZEOF([int])
AC_CHECK_ALIGNOF([int])
AC_CHECK_SIZEOF([void *])
AC_CHECK_ALIGNOF([void *])
AC_CHECK_TYPES([thread_t])
AC_CHECK_TYPES([sigset_t])
AC_CHECK_TYPES([uintptr_t])
AC_CHECK_TYPES([uio_t])
AC_CHECK_TYPES([vnode_t])

# Checks for library functions.
AC_HEADER_MAJOR
AC_FUNC_CHOWN
AC_CHECK_FUNCS([bzero current_proc current_thread gethrtime kevent kmemchr \
                kqueue memset printf sigmask strchr strdup strpbrk strrchr \
                strtol strtoul system uio_offset])

AC_CONFIG_FILES([Makefile \
		 module/Makefile \
		 module/spl/Makefile \
		 include/Makefile \
		 scripts/Makefile \
		 spl.spec \
		 spl-modules.spec \
		 PKGBUILD-spl \
		 PKGBUILD-spl-modules \
		 spl.release \
		 dkms.conf])
AC_OUTPUT
