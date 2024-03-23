



f2py -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import numpy; numpy.show_config()"
IF %ERRORLEVEL% NEQ 0 exit /B 1
set OPENBLAS_NUM_THREADS=1
IF %ERRORLEVEL% NEQ 0 exit /B 1
pytest -vvv --pyargs numpy -k "not (_not_a_real_test or test_overrides or test_partial_iteration_cleanup)" --durations=0
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
