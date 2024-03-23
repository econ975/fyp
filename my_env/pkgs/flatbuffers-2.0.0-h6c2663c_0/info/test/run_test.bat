



if not exist %PREFIX%\\Library\\bin\\flatc.exe exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
if not exist %PREFIX%\\Library\\include\\flatbuffers\\flatbuffers.h exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
