



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "from google.protobuf.internal import api_implementation; assert api_implementation.Type() == 'python'"
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
