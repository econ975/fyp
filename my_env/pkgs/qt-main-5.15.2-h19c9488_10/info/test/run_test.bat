



if not exist %LIBRARY_PREFIX%\plugins\sqldrivers\qsqlite.dll exit 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
