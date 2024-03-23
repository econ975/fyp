



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
nosetests -v -e test_hypergeometric mkl_random
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
