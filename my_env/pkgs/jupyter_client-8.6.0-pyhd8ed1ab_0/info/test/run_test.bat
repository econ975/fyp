



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
jupyter kernelspec list
IF %ERRORLEVEL% NEQ 0 exit /B 1
jupyter run -h
IF %ERRORLEVEL% NEQ 0 exit /B 1
pytest -vv --cov=jupyter_client --cov=branch --cov-report=term-missing:skip-covered --no-cov-on-fail -k "not (signal_kernel_subprocesses or start_parallel_thread_kernels or start_parallel_process_kernels or open_tunnel or load_ips or input_request or tcp_cinfo) "
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
