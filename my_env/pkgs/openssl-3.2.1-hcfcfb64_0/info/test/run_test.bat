



copy NUL checksum.txt
IF %ERRORLEVEL% NEQ 0 exit /B 1
%LIBRARY_BIN%\openssl sha256 checksum.txt
IF %ERRORLEVEL% NEQ 0 exit /B 1
pkg-config --print-errors --exact-version "3.2.1" openssl
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
