



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
rmdir /s /q tests\autobahn
IF %ERRORLEVEL% NEQ 0 exit /B 1
pytest -k "not (_not_a_real_test or test_expires or test_max_age or test_cookie_jar_clear_expired or test_http_response_parser_bad_chunked_strict_c[pyloop] or test_http_response_parser_bad_chunked_strict_py[pyloop] or test_http_response_parser_strict_headers[c-parser-pyloop] or test_access_root_of_static_handler[pyloop-index_forbidden] or test_client_session_timeout_zero or test_run_app_preexisting_inet6_socket[pyloop]  or test_handler_cancellation or test_no_handler_cancellation or test_shutdown_pending_handler_responds or test_no_warnings[aiohttp.worker])" --ignore=tests/test_proxy_functional.py
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
