#!/bin/bash

set -ex

if [ "$(uname)" == "Linux" ];
then
    # protobuf uses PROTOBUF_OPT_FLAG to set the optimization level
    # unit test can fail if optmization above 0 are used.
    # update: no -O at all is triggering warnings.
    # CPPFLAGS="${CPPFLAGS//-O[0-9]/}"
    # CXXFLAGS="${CXXFLAGS//-O[0-9]/}"
    export PROTOBUF_OPT_FLAG="-O2"
    # to improve performance, disable checks intended for debugging
    CXXFLAGS="$CXXFLAGS -DNDEBUG"
elif [ "$(uname)" == "Darwin" ];
then
    # remove pie from LDFLAGS
    LDFLAGS="${LDFLAGS//-pie/}"
fi

# sed is missing from path in build for osx-arm64.  This is a
# workaround for expediency and should be removed when possible.
if [[ "${target_platform}" == "osx-arm64" ]]; then
    export SED="${BUILD_PREFIX}/bin/sed"
fi


# required to pick up conda installed zlib
export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"

# Build configure/Makefile as they are not present.
aclocal
libtoolize
autoconf
autoreconf -i
automake --add-missing

./configure --prefix="${PREFIX}" \
            --build=${BUILD}     \
            --host=${HOST}       \
            --with-pic           \
            --with-zlib          \
            --enable-shared      \
            CC_FOR_BUILD=${CC}   \
            CXX_FOR_BUILD=${CXX}

# Skip memory hungry tests
export GTEST_FILTER="-IoTest.LargeOutput"
if [ "${HOST}" == "powerpc64le-conda_cos7-linux-gnu" ]; then
    make -j 2
    make check -j 2 || (cat src/test-suite.log; exit 1)
else
    make -j ${CPU_COUNT}
    if [[ "$CONDA_BUILD_CROSS_COMPILATION" != 1 ]]; then
        make check -j ${CPU_COUNT} || (cat src/test-suite.log; exit 1)
    fi
fi
make install
rm ${PREFIX}/lib/libprotobuf.a
rm ${PREFIX}/lib/libprotobuf-lite.a
rm ${PREFIX}/lib/libprotoc.a
