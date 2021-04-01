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
AC_CONFIG_MACRO_DIRS([config m4])
AC_LANG([C])

# System-specific stuff
AC_CANONICAL_TARGET
AX_CREATE_TARGET_H dnl# from m4/ax_create_target_h.m4 (from the autoconf-archive)
AC_USE_SYSTEM_EXTENSIONS
AC_OBJEXT
AC_EXEEXT
AC_SYS_LARGEFILE
AC_SYS_LONG_FILE_NAMES
AX_CHECK_DOS_FILESYS_LIMITATIONS dnl# from m4/ax_check_dos_filesys.m4 (from the autoconf-archive)
AC_GET_MACOSX_VERSION

dnl# EBG_* macros are from m4/EbgMacOSXOptions.m4 (my personal macro file)
m4_ifdef([EBG_MAC_UNIVERSAL],[
  dnl# yes, this is my own macro that I seem to have lost... I am disorganized
  EBG_MAC_UNIVERSAL
])
EBG_PROG_MACHINE
EBG_DEVELOPER_DIR

# SPL-specific macros
SPL_AC_META
SPL_AC_CONFIG

# Automake
AM_INIT_AUTOMAKE([1.11 foreign tar-ustar -Wall])
AM_MAINTAINER_MODE
AM_MISSING_PROG([KEXTUTIL],[kextutil])
AM_PROG_INSTALL_STRIP

dnl# Putting AC_PROG_AWK (and other macros like this) inside a conditional
dnl# like this is a hack to emulate the use of AC_REQUIRE([]) outside of
dnl# an AC_DEFUN([])
if test "x${AWK}" = "x"; then
	test -z "${AWK}"
	AC_PROG_AWK
else
	# Autoconf likes to remove AC_SUBSTs from conditions
	# so this test and the others like it are dummies
	# to make sure that the "else" condition does not
	# become empty
	test ! -z "${AWK}" && export AWK
	AC_SUBST([AWK])
fi
AC_CONFIG_HEADERS([spl_config.h],[
	(mv spl_config.h spl_config.h.tmp &&
	awk -f ${ac_srcdir}/config/config.awk spl_config.h.tmp >spl_config.h &&
	rm spl_config.h.tmp) || exit 1])

# Checks for programs.
AC_PROG_INSTALL
AC_PROG_LN_S
AX_PROG_CP_S dnl# from m4/ax_prog_cp_s.m4 (from the autoconf-archive)
AC_PROG_MKDIR_P
if test "x${MAKE_SET}" = "x"; then
	test -z "${MAKE_SET}"
	AC_PROG_MAKE_SET
fi

dnl# save ${CFLAGS} since AC_PROG_CC likes to insert "-g -O2"
dnl# if ${CFLAGS} is blank
cflags_save="${CFLAGS}"
if test "x${CC}" = "x"; then
	test -z "${CC}"
	AC_PROG_CC
else
	test ! -z "${CC}" && export CC
	AC_SUBST([CC])
fi
if test "x${CC_C_O}" = "x"; then
	test -z "$CC_C_O"
	AM_PROG_CC_C_O
else
	test ! -z "${CC_C_O}" && export CC_C_O
	AC_SUBST([CC_C_O])
fi
if test "x${CPP}" = "x"; then
	test -z "${CPP}"
	AC_PROG_CPP
else
	XORG_PROG_RAWCPP([]) dnl# from m4/xorg-macros.m4 (from the xorg-util-macros package)
fi
AC_PROG_CXX
AC_PROG_OBJC
AC_PROG_OBJCPP
AC_PROG_OBJCXX
AC_PROG_OBJCXXCPP
CFLAGS="${cflags_save}"
export CFLAGS

AM_PROG_AR
AM_PROG_AS

LT_PREREQ([2.2.4])
LT_INIT([static]) dnl# linking in the kernel is done statically

dnl# libtool should have already found ranlib, but autoscan will still
dnl# complain about it, and I am more okay with libtoolize warnings than
dnl# I am with autoscan warnings
if test "x${RANLIB}" = "x"; then
	test -z "${RANLIB}"
	AC_PROG_RANLIB
else
	test ! -z "${RANLIB}" && export RANLIB
	AC_SUBST([RANLIB])
fi

PKG_PROG_PKG_CONFIG

AM_CONDITIONAL([CONFIG_KERNEL],[true])
AM_CONDITIONAL([CONFIG_USER],[true])dnl

AC_CHECK_FILE([/dev/kmem])
AC_PATH_PROG([KEXTLIBS],[kextlibs])
AC_PATH_PROG([KEXTLOAD],[kextload])
AX_PROG_MODPROBE dnl# from m4/ax_prog_modprobe.m4 (from the autoconf-archive)

AC_PATH_PROG([RSYNC],[rsync])
AC_PATH_PROG([XCRUN],[xcrun])dnl

# Checks for libraries and frameworks.
MP_CHECK_FRAMEWORK_IOKIT dnl# from m4/EbgMacOSXOptions.m4 (my personal macro file)
# FIXME: Replace `main' with a function in `-lcc_kext':
AC_CHECK_LIB([cc_kext],[main])
# FIXME: Replace `main' with a function in `-lkmod':
AC_CHECK_LIB([kmod],[main])
# FIXME: Replace `main' with a function in `-lkmodc++':
AC_CHECK_LIB([kmodc++],[main])
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
AC_CHECK_HEADERS_ONCE([IOKit/IOLib.h IOKit/IOService.h limits.h])dnl

# Checks for declarations.
AC_CHECK_DECLS([NULL])dnl

# Checks for compiler characteristics.
AC_CHECK_SIZEOF([short int])
AC_CHECK_ALIGNOF([short int])
AC_C_BIGENDIAN dnl# For Apple universal builds
dnl# Only force universal build if ld_classic is NOT present,
dnl# because it will be used if available, which can cause failures
if test -z "`which ld_classic`"; then
	AC_SUBST([ac_cv_c_bigendian])
	AC_DEFINE([AC_APPLE_UNIVERSAL_BUILD],[1],[Define if building universal (internal helper macro)])
elif test -n "`which ld_classic`" && test -x "`which ld_classic`"; then
	unset ac_cv_c_bigendian
	AC_PATH_PROG([LD_CLASSIC],[ld_classic])
	if test ! -z "`echo ${LDFLAGS} | grep \"dead_strip_dylibs\"`"; then
		LDFLAGS="`echo ${LDFLAGS} | sed \"s|-Wl,-dead_strip_dylibs||g\"`"
		export LDFLAGS
	fi
else
	unset ac_cv_c_bigendian
fi
AC_C_CONST
AC_C_INLINE
AC_C_PROTOTYPES

# Checks for types
AC_TYPE_INT8_T
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_MODE_T
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UID_T
AC_TYPE_UINT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_CHECK_TYPES([thread_t])
AC_CHECK_TYPES([sigset_t])
AC_CHECK_TYPES([uintptr_t])
AC_CHECK_TYPES([uio_t])
AC_CHECK_TYPES([vnode_t])dnl

# Checks for sizes and alignments of types
AC_CHECK_SIZEOF([int])
AC_CHECK_ALIGNOF([int])
AC_CHECK_SIZEOF([long])
AC_CHECK_ALIGNOF([long])
AC_CHECK_SIZEOF([void *])
AC_CHECK_ALIGNOF([void *])dnl

# More checks for compiler characteristics (specifically flags recongnized)
AC_PROG_GCC_TRADITIONAL
AX_GCC_ARCHFLAG dnl# from m4/ax_gcc_archflag.m4 (from the autoconf-archive)
dnl# These are all from m4/ax_check_compile_flag.m4 (from the autoconf-archive)
AX_CHECK_COMPILE_FLAG([-Werror=unused-command-line-argument],
                      [CFLAGS="${CFLAGS} -Werror=unused-command-line-argument"],
  [CFLAGS="`echo ${CFLAGS} | sed \"s|-Werror=unused-command-line-argument||g\"`"])
AX_CHECK_COMPILE_FLAG([-fno-common],[CFLAGS="${CFLAGS} -fno-common"],
                     [CFLAGS="`echo ${CFLAGS} | sed \"s|-fno-common||g\"`"])
AX_CHECK_COMPILE_FLAG([-fno-exceptions],[CFLAGS="${CFLAGS} -fno-exceptions"],
                      [CFLAGS="`echo ${CFLAGS} | sed \"s|-fno-exceptions||g\"`"])
AX_CHECK_COMPILE_FLAG([-fno-non-call-exceptions],
                      [CFLAGS="${CFLAGS} -fno-non-call-exceptions"],
              [CFLAGS="`echo ${CFLAGS} | sed \"s|-fno-non-call-exceptions||g\"`"])
AX_CHECK_COMPILE_FLAG([-mno-altivec],[CFLAGS="${CFLAGS} -mno-altivec"],
                      [CFLAGS="`echo ${CFLAGS} | sed \"s|-mno-altivec||g\"`"])
AX_CHECK_COMPILE_FLAG([-msoft-float],[CFLAGS="${CFLAGS} -msoft-float"],
                      [CFLAGS="`echo ${CFLAGS} | sed \"s|-msoft-float||g\"`"])
AX_CHECK_COMPILE_FLAG([-fno-builtin],[CFLAGS="${CFLAGS} -fno-builtin"],
                      [CFLAGS="`echo ${CFLAGS} | sed \"s|-fno-builtin||g\"`"])
AX_CHECK_COMPILE_FLAG([-mlong-branch],[CFLAGS="${CFLAGS} -mlong-branch"],
                      [CFLAGS="`echo ${CFLAGS} | sed \"s|-mlong-branch||g\"`"])
AX_CHECK_COMPILE_FLAG([-mkernel],[CFLAGS="${CFLAGS} -mkernel"],
                      [CFLAGS="`echo ${CFLAGS} | sed \"s|-mkernel||g\"`"])
AX_CHECK_COMPILE_FLAG([-mfix-and-continue],[CFLAGS="${CFLAGS} -mfix-and-continue"],
                  [CFLAGS="`echo ${CFLAGS} | sed \"s|-mfix-and-continue||g\"`"])
AX_CHECK_COMPILE_FLAG([-fasm-blocks],[CFLAGS="${CFLAGS} -fasm-blocks"],
                      [CFLAGS="`echo ${CFLAGS} | sed \"s|-fasm-blocks||g\"`"])
AX_CHECK_COMPILE_FLAG([-force_cpusubtype_ALL],
                      [CFLAGS="${CFLAGS} -force_cpusubtype_ALL"],
                  [CFLAGS="`echo ${CFLAGS} | sed \"s|-force_cpusubtype_ALL||g\"`"])

AC_LANG_PUSH([C++])
AX_CHECK_COMPILE_FLAG([-fapple-kext],[CXXFLAGS="${CXXFLAGS} -fapple-kext"],
                      [CXXFLAGS="`echo ${CXXFLAGS} | sed \"s|-fapple-kext||g\"`"])
AX_CHECK_COMPILE_FLAG([-fno-weak],[CXXFLAGS="${CXXFLAGS} -fno-weak"],
                      [CXXFLAGS="`echo ${CXXFLAGS} | sed \"s|-fno-weak||g\"`"])
AX_CHECK_COMPILE_FLAG([-fno-rtti],[CXXFLAGS="${CXXFLAGS} -fno-rtti"],
                      [CXXFLAGS="`echo ${CXXFLAGS} | sed \"s|-fno-rtti||g\"`"])
AX_CHECK_COMPILE_FLAG([-fcheck-new],[CXXFLAGS="${CXXFLAGS} -fcheck-new"],
                      [CXXFLAGS="`echo ${CXXFLAGS} | sed \"s|-fcheck-new||g\"`"])
AC_LANG_POP

MY_ARCH_FLAG="-arch `uname -m`"
CFLAGS="${CFLAGS} ${MY_ARCH_FLAG}" # kernel extensions need to be same arch as kernel
# Not doing a check to see if the compiler supports this flag because
# AX_CHECK_COMPILE_FLAG chokes on flags with spaces in them

LT_LANG([C])
LT_LANG([C++])
m4_ifndef([WINE_PATH_LDD],[
  AC_DEFUN([WINE_PATH_LDD],[
    AC_PATH_PROG([LDD],[ldd],[true],[/sbin:/usr/sbin:${PATH}])
  ])
])
WINE_PATH_LDD dnl# from m4/wine.m4 (from wine)

AX_CHECK_LINK_FLAG([-static],[LDFLAGS="${LDFLAGS} -static"],[
  LDFLAGS="`echo ${LDFLAGS} | sed \"s|-static||g\"`"
  AX_CHECK_LINK_FLAG([-Wl,-static],[LDFLAGS="${LDFLAGS} -Wl,-static"],
                     [LDFLAGS="`echo ${LDFLAGS} | sed \"s|-Wl,-static||g\"`"])
]) dnl# from ax_check_link_flag.m4 (from the autoconf-archive)

XORG_LD_WRAP dnl# from m4/xorg-macros.m4 (from the xorg-util-macros package)

# Checks for library functions.
AC_HEADER_MAJOR
AC_FUNC_CHOWN
AC_CHECK_FUNCS([atexit bzero current_proc current_thread gethrtime kevent \
                kmemchr kqueue memset printf sigmask strchr strdup strpbrk \
                strrchr strtol strtoul system uio_offset])dnl

# Output.
AH_TEMPLATE([HAVE_DOS_FILESYS_LIMITATIONS],
            [Define to 1 if your filesystem is DOS-like.])
AC_MSG_CHECKING([how we should use target.h])
if test -e ./target.h; then
	if test ! -z "${DEFS}"; then
		DEFS="${DEFS} -DHAVE_TARGET_H"
	elif test -z "${DEFS}"; then
		DEFS="-DHAVE_TARGET_H"
	else
		AC_MSG_ERROR([DEFS should be either empty or non-empty, not neither])
	fi
	export DEFS
	AC_SUBST([DEFS])
	AC_MSG_RESULT([${DEFS}])
else
	AC_MSG_RESULT([no])
	AC_MSG_NOTICE([not using target.h])
fi

AH_BOTTOM([
#ifdef HAVE_TARGET_H
#include "target.h"
#endif /* HAVE_TARGET_H */
])dnl

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

if test -e ./target.h; then
	if test ! -z "${DEFS}"; then
		DEFS="${DEFS} -DHAVE_TARGET_H"
	elif test -z "${DEFS}"; then
		DEFS="-DHAVE_TARGET_H"
	fi
fi

echo ""

echo "SPL is configured as follows:"
echo ""
echo "Host system type: ${host}"
echo ""
echo "Options used to compile and link:"
echo "  prefix ......... = ${prefix}"
echo "  VERSION ........ = ${PACKAGE_VERSION}"
echo "  CC ............. = ${CC}"
echo "  CPP ............ = ${CPP}"
echo "  CXX ............ = ${CXX}"
echo "  CFLAGS ......... = ${CFLAGS}"
echo "  CPPFLAGS ....... = ${CPPFLAGS}"
echo "  CXXFLAGS ....... = ${CXXFLAGS}"
echo "  DEFS ........... = ${DEFS}"
echo "  LD ............. = ${LD}"
echo "  LDFLAGS ........ = ${LDFLAGS}"
echo "  LIBS ........... = ${LIBS}"
echo ""
