



genbrk --help
IF %ERRORLEVEL% NEQ 0 exit /B 1
gencfu --help
IF %ERRORLEVEL% NEQ 0 exit /B 1
gencnval --help
IF %ERRORLEVEL% NEQ 0 exit /B 1
gendict --help
IF %ERRORLEVEL% NEQ 0 exit /B 1
icuinfo --help
IF %ERRORLEVEL% NEQ 0 exit /B 1
makeconv gb-18030-2000.ucm
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
