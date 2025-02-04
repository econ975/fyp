#!/bin/bash

export GRPC_BUILD_WITH_BORING_SSL_ASM=""
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB="True"
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL="True"
export GRPC_PYTHON_BUILD_SYSTEM_RE2="True"
export GRPC_PYTHON_BUILD_SYSTEM_CARES="True"
export GRPC_PYTHON_BUILD_SYSTEM_GRPC_CORE="True"
export GRPC_PYTHON_USE_PREBUILT_GRPC_CORE=""
export GRPC_PYTHON_BUILD_WITH_CYTHON="True"

if [[ "${target_platform}" == linux-* ]]; then
    # set these so the default in setup.py are not used
    # it seems that we need to link to pthrad on linux or osx.
    export GRPC_PYTHON_LDFLAGS="-lpthread"
elif [[ "$target_platform" == osx-* ]]; then
    export CC=$(basename "${CC}")
    export GRPC_PYTHON_LDFLAGS=" -framework CoreFoundation"
    # cp $RECIPE_DIR/clang_wrapper.sh $SRC_DIR/$CC
    # chmod +x $SRC_DIR/$CC
    export SYSTEM_VERSION_COMPAT=1
fi

if [[ "$target_platform" == osx-64 ]]; then
    export CFLAGS="$CFLAGS -DTARGET_OS_OSX=1 --sysroot /opt/MacOSX10.10.sdk/ -Wno-unknown-warning-option -Wno-unused-command-line-argument -Wno-nullability-completeness"
    export CXXFLAGS="$CXXFLAGS -DTARGET_OS_OSX=1 --sysroot /opt/MacOSX10.10.sdk/ -Wno-unknown-warning-option -Wno-unused-command-line-argument -Wno-nullability-completeness"
fi

[[ -f "${SRC_DIR}/cc" ]] || ln -sf "$(which $CC)" "$SRC_DIR/cc"
export PATH="$SRC_DIR:$PATH"

$PYTHON -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vvv
