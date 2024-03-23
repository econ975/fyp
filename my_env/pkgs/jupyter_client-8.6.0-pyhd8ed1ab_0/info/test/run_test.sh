

set -ex



pip check
jupyter kernelspec list
jupyter run -h
pytest -vv --cov=jupyter_client --cov=branch --cov-report=term-missing:skip-covered --no-cov-on-fail -k "not (signal_kernel_subprocesses or start_parallel_thread_kernels or start_parallel_process_kernels or open_tunnel or load_ips or input_request or tcp_cinfo) "
exit 0
