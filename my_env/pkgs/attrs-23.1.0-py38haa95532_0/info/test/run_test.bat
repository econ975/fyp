



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
pytest --fixtures tests -vv
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
