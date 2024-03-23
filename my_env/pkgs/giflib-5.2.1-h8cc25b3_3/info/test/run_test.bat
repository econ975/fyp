



gifbuild -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
giffix -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
giftext -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
gifclrmp -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
gif2rgb -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
