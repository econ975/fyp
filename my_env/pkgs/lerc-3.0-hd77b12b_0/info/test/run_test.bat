



if not exist %LIBRARY_INC%\Lerc_types.h exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %LIBRARY_BIN%\Lerc.dll exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %LIBRARY_LIB%\Lerc.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
