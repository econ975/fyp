#!/bin/bash
set -ex

mkdir build-cmake
pushd build-cmake

cmake ${CMAKE_ARGS} -GNinja \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DENABLE_TESTING=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  ..

ninja -v install

popd

# Also do this installation to get .pc files. This duplicates the compilation
# but gets us all necessary components without patching.
make -j "${CPU_COUNT}" prefix=${PREFIX} shared-install
