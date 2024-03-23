



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "from joblib import Memory, Parallel, delayed"
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
