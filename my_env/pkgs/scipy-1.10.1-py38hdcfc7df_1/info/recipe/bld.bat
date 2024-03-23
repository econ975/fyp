@echo on

REM Align numpy intel fortran compiler flags with what is expected by scipy.
REM Regarding /fp:strict and /assume:minus0 see: https://github.com/scipy/scipy/issues/17075 
REM Regarding /fpp The pre-processor flag is not enabled on older numpy.
powershell -Command "(gc %SP_DIR%\numpy\distutils\fcompiler\intel.py) -replace '''/nologo'', ', '''/nologo'', ''/fpp'', ''/fp:strict'', ''/assume:minus0'', ' | Out-File -encoding ASCII %SP_DIR%\numpy\distutils\fcompiler\intel.py"
if errorlevel 1 exit 1

COPY %PREFIX%\site.cfg site.cfg

REM these are done automatically for openblas by numpy.distutils, but
REM not for our blas libraries
echo %LIBRARY_LIB%\blas.lib > %LIBRARY_LIB%\blas.fobjects
echo %LIBRARY_LIB%\blas.lib > %LIBRARY_LIB%\blas.cobjects
echo %LIBRARY_LIB%\cblas.lib > %LIBRARY_LIB%\cblas.fobjects
echo %LIBRARY_LIB%\cblas.lib > %LIBRARY_LIB%\cblas.cobjects
echo %LIBRARY_LIB%\lapack.lib > %LIBRARY_LIB%\lapack.fobjects
echo %LIBRARY_LIB%\lapack.lib > %LIBRARY_LIB%\lapack.cobjects

REM Use the G77 ABI wrapper everywhere so that the underlying blas implementation
REM can have a G77 ABI (currently only MKL)
set SCIPY_USE_G77_ABI_WRAPPER=1

REM This builds a Fortran file which calls a C function, but numpy.distutils
REM creates an isolated DLL for these fortran functions and therefore it doesn't
REM see these C functions. workaround this by compiling it ourselves and
REM sneaking it with the blas libraries
REM TODO: rewrite wrap_g77_abi.f with iso_c_binding when the compiler supports it
@REM cl.exe scipy\_build_utils\src\wrap_g77_abi_c.c -c /MD
@REM if %ERRORLEVEL% neq 0 exit 1
@REM echo. > scipy\_build_utils\src\wrap_g77_abi_c.c
@REM echo %SRC_DIR%\wrap_g77_abi_c.obj >> %LIBRARY_LIB%\lapack.fobjects
@REM echo %SRC_DIR%\wrap_g77_abi_c.obj >> %LIBRARY_LIB%\lapack.cobjects

REM Add a file to load the fortran wrapper libraries in scipy/.libs
del scipy\_distributor_init.py
if %ERRORLEVEL% neq 0 exit 1
copy %RECIPE_DIR%\_distributor_init.py scipy\
if %ERRORLEVEL% neq 0 exit 1

REM check if clang-cl is on path as required
clang-cl.exe --version
if %ERRORLEVEL% neq 0 exit 1

REM set compilers to clang-cl
set "CC=clang-cl.exe"
set "CXX=clang-cl.exe"

REM clang-cl & gfortran use different LDFLAGS; unset it
set "LDFLAGS="
REM don't add d1trimfile option because clang doesn't recognize it.
set "SRC_DIR="

%PYTHON% setup.py install --single-version-externally-managed --record=record.txt
if %ERRORLEVEL% neq 0 exit 1

REM make sure these aren't packaged
del %LIBRARY_LIB%\blas.fobjects
del %LIBRARY_LIB%\blas.cobjects
del %LIBRARY_LIB%\cblas.fobjects
del %LIBRARY_LIB%\cblas.cobjects
del %LIBRARY_LIB%\lapack.fobjects
del %LIBRARY_LIB%\lapack.cobjects
