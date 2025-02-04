setlocal EnableDelayedExpansion

mkdir build-dynamic
cd build-dynamic

set CFLAGS=
set CXXFLAGS=

cmake -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DSNAPPY_BUILD_BENCHMARKS=OFF ^
    ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

:: need to be in the root directory for this to run properly
cd ..
build-dynamic\snappy_unittest
if errorlevel 1 exit 1
cd build-dynamic

nmake install
if errorlevel 1 exit 1

cd ..
mkdir build-static
cd build-static

cmake -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DCMAKE_POSITION_INDEPENDENT_CODE=1 ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DSNAPPY_BUILD_BENCHMARKS=OFF ^
    ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

:: need to be in the root directory for this to run properly
cd ..
build-static\snappy_unittest
if errorlevel 1 exit 1
cd build-static

nmake install
if errorlevel 1 exit 1
