



IF NOT EXIST %PREFIX%\Library\bin\mkl*.dll EXIT /B 1
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
