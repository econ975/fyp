



if not exist %PREFIX%\\Library\\bin\\tiff.dll exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\lib\\tiffxx.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\bin\\libtiff.dll exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
