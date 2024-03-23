



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import pandas; pandas.test(extra_args=['-m not clipboard and not single_cpu and not slow and not network and not db', '-n=2', '-k', 'not (_not_a_real_test)'])"
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
