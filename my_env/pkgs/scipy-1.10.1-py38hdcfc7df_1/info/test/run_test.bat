



python -c "import sys, scipy, numpy; print(scipy.__version__, numpy.__version__, sys.version_info)"
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import numpy; numpy.show_config()"
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import scipy, sys; sys.exit(not scipy.test(verbose=1, label='full', tests=None, extra_argv=['-k', 'not (_not_a_real_test or test_x0_equals_Mb[bicgstab] or test_svdp or test_examples)', '-n', '3', '--timeout=1800', '--durations=50']))"
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import scipy, sys; scipy.test(verbose=2, label='full', tests=None, extra_argv=['-k', '(test_svdp or test_examples)', '-n', '3', '--timeout=1800', '--durations=50']); sys.exit(0)"
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import scipy, sys; scipy.test(verbose=2, label='full', tests=None, extra_argv=['-k', '(_not_a_real_test or test_x0_equals_Mb[bicgstab])', '-n', '3', '--timeout=1800', '--durations=50']); sys.exit(0)"
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
