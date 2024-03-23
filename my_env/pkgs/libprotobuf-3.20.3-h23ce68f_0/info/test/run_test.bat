



protoc --help
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\lib\\libprotoc.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\lib\\libprotobuf.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\lib\\libprotobuf-lite.lib exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
