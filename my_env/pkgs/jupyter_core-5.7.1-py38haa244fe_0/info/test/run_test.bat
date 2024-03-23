



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
jupyter -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
jupyter-migrate -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
jupyter-troubleshoot --help
IF %ERRORLEVEL% NEQ 0 exit /B 1
pytest -vv --color=yes  -k "not (test_not_on_path or test_path_priority)"
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
