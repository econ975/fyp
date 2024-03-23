



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
set OPENBLAS_NUM_THREADS=1
IF %ERRORLEVEL% NEQ 0 exit /B 1
set OMP_NUM_THREADS=1
IF %ERRORLEVEL% NEQ 0 exit /B 1
pytest --timeout 300 -n 1 --verbose --pyargs sklearn -k "not (_not_a_real_test or test_loadings_converges)"
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
