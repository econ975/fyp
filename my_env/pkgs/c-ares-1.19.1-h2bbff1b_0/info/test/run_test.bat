



if not exist %PREFIX%\\Library\\include\\ares.h exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\bin\\cares.dll exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\lib\\cares.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if exist %PREFIX%\\Library\\lib\\cares_static.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
