#!/bin/bash
set -euo pipefail

autoreconf -vfi
./autogen.sh

./configure --prefix="$PREFIX" --disable-Werror --with-libsodium  --disable-libsodium_randombytes_close
make -j${CPU_COUNT}

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" ]]; then
  make check
fi

