



if not exist %LIBRARY_BIN%\\libclang-13.dll exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if exist %LIBRARY_BIN%\\libclang.dll exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if exist %LIBRARY_LIB%\\libclang.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if exist %LIBRARY_BIN%\\libclang-14.dll exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
