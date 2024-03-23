



IF NOT EXIST %PREFIX%\Library\bin\libiomp*.dll EXIT /B 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
IF NOT EXIST %PREFIX%\Library\bin\omp*.dll EXIT /B 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
IF NOT EXIST %PREFIX%\Library\lib\libiomp5md.lib echo "%PREFIX%\Library\lib\libiomp5md.lib is missing" & EXIT /B 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
