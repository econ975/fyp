



saved_model_cli --help
IF %ERRORLEVEL% NEQ 0 exit /B 1
tf_upgrade_v2 --help
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
