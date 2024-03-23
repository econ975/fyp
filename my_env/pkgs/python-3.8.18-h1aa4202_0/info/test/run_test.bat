



echo on
IF %ERRORLEVEL% NEQ 0 exit /B 1
set
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -V
IF %ERRORLEVEL% NEQ 0 exit /B 1
2to3 -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
pydoc -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
set "PIP_NO_BUILD_ISOLATION=False"
IF %ERRORLEVEL% NEQ 0 exit /B 1
set "PIP_NO_DEPENDENCIES=True"
IF %ERRORLEVEL% NEQ 0 exit /B 1
set "PIP_IGNORE_INSTALLED=True"
IF %ERRORLEVEL% NEQ 0 exit /B 1
set "PIP_NO_INDEX=True"
IF %ERRORLEVEL% NEQ 0 exit /B 1
set "PIP_CACHE_DIR=%CONDA_PREFIX%/pip_cache"
IF %ERRORLEVEL% NEQ 0 exit /B 1
set "TEMP=%CONDA_PREFIX%/tmp"
IF %ERRORLEVEL% NEQ 0 exit /B 1
mkdir "%TEMP%"
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -Im ensurepip --upgrade --default-pip
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -m venv test-venv
IF %ERRORLEVEL% NEQ 0 exit /B 1
if exist %PREFIX%\\Scripts\\pydoc exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if exist %PREFIX%\\Scripts\\idle exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if exist %PREFIX%\\Scripts\\2to3 exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Scripts\\pydoc-script.py exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Scripts\\idle-script.py exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Scripts\\2to3-script.py exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Scripts\\idle.exe exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Scripts\\2to3.exe exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Scripts\\pydoc.exe exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
pushd tests
IF %ERRORLEVEL% NEQ 0 exit /B 1
pushd distutils
IF %ERRORLEVEL% NEQ 0 exit /B 1
python setup.py install -v -v
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import foobar"
IF %ERRORLEVEL% NEQ 0 exit /B 1
popd
IF %ERRORLEVEL% NEQ 0 exit /B 1
pushd distutils.cext
IF %ERRORLEVEL% NEQ 0 exit /B 1
python setup.py build_ext -v -v
IF %ERRORLEVEL% NEQ 0 exit /B 1
echo %cd%
IF %ERRORLEVEL% NEQ 0 exit /B 1
dir .
IF %ERRORLEVEL% NEQ 0 exit /B 1
dir build
IF %ERRORLEVEL% NEQ 0 exit /B 1
pushd build\lib*
IF %ERRORLEVEL% NEQ 0 exit /B 1
echo %cd%
IF %ERRORLEVEL% NEQ 0 exit /B 1
echo "After pushd build/lib"
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import greet; greet.greet('Python user')" | rg "Hello Python"
IF %ERRORLEVEL% NEQ 0 exit /B 1
echo "After python -c import"
IF %ERRORLEVEL% NEQ 0 exit /B 1
popd
IF %ERRORLEVEL% NEQ 0 exit /B 1
popd
IF %ERRORLEVEL% NEQ 0 exit /B 1
pushd cmake
IF %ERRORLEVEL% NEQ 0 exit /B 1
cmake -GNinja -DPY_VER=3.8.18
IF %ERRORLEVEL% NEQ 0 exit /B 1
popd
IF %ERRORLEVEL% NEQ 0 exit /B 1
popd
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import ssl; assert '3.0' in ssl.OPENSSL_VERSION"
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
