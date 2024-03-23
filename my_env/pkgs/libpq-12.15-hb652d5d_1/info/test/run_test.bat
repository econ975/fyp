



pg_config
IF %ERRORLEVEL% NEQ 0 exit /B 1
IF NOT EXIST %LIBRARY_BIN%\libpq.dll EXIT 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
IF NOT EXIST %LIBRARY_BIN%\pg_config.exe EXIT 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
