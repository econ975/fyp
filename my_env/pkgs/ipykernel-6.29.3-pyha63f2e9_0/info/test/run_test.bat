



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
jupyter kernelspec list
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
