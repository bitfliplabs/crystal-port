# $OpenBSD: Makefile.template,v 1.75 2016/03/20 17:19:49 naddy Exp $

ONLY_FOR_ARCHS			  = amd64

#							|----------------------------------------------------------|
COMMENT					  = A Ruby-like, statically typed, object oriented, language.

VERSION					  = 0.24.0
OS_VERSION				  = openbsd62
DISTNAME				  = crystal-${VERSION}
PKGNAME					  = crystal-${VERSION}

CATEGORIES				  = lang
HOMEPAGE				  = https://crystal-lang.org/
MAINTAINER				  = Chris Huxtable <chris@bitfliplabs.com>

# Apache License, v2.0
PERMIT_PACKAGE_CDROM	  = Yes
PERMIT_PACKAGE_FTP		  = Yes
PERMIT_DISTFILES_FTP	  = Yes

WANTLIB					 += c event_core event_extra gc iconv m pcre pthread z

MASTER_SITES			  = https://github.com/crystal-lang/crystal/archive/
MASTER_SITES0			  = https://assets.bitfliplabs.com/crystal/archive/
DISTFILES				  = ${VERSION}.tar.gz \
							crystal-${VERSION}-${MACHINE_ARCH}-${OS_VERSION}.tar.gz:0

NO_CONFIGURE			  = Yes
USE_GMAKE				  = Yes

LIB_DEPENDS				  = converters/libiconv \
							devel/boehm-gc \
							devel/libevent2 \
							devel/llvm \
							devel/pcre \

BUILD_DEPENDS			  = shells/bash
RUN_DEPENDS				  = shells/bash


# Variables
CRYSTAL_CC				  = clang-5.0
CRYSTAL_COMPILER		  = ${WRKSRC}/.build/crystal
CRYSTAL_OBJECT			  = ${WRKSRC}/../crystal-${VERSION}-${MACHINE_ARCH}-${OS_VERSION}.o

LLVMEXT_SRC				  = ${WRKSRC}/src/llvm/ext/llvm_ext
SIGFAULT_SRC			  = ${WRKSRC}/src/ext/sigfault


do-build:
	${CRYSTAL_CC} -c -o ${LLVMEXT_SRC}.o ${LLVMEXT_SRC}.cc `llvm-config --cxxflags`
	${CRYSTAL_CC} -c -o ${SIGFAULT_SRC}.o ${SIGFAULT_SRC}.c

	# Crystal
	mkdir -p ${WRKSRC}/.build

	${CRYSTAL_CC} ${CRYSTAL_OBJECT} -o ${CRYSTAL_COMPILER} -rdynamic ${SIGFAULT_SRC}.o ${LLVMEXT_SRC}.o `(llvm-config --libs --system-libs --ldflags 2> /dev/null)` -lstdc++ -lpcre -lgc -lpthread -levent_core -levent_extra -lssl -liconv
	cd ${WRKSRC} && gmake deps && gmake release=1 CC=${CRYSTAL_CC} CRYSTAL_CONFIG_PATH="lib:/usr/local/lib/crystal"

do-install:
	# Library
	${INSTALL_DATA_DIR} ${PREFIX}/lib/crystal

	# Crystal
	${INSTALL_PROGRAM} ${WRKSRC}/.build/crystal ${PREFIX}/bin
	cp -R ${WRKSRC}/src/* ${PREFIX}/lib/crystal/.

.include <bsd.port.mk>
