



if not exist %PREFIX%\\Library\\include\\re2\\re2.h exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\lib\\re2.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if exist %PREFIX%\\Library\\lib\\re2_static.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\bin\\re2.dll exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
