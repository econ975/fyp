



pip check
IF %ERRORLEVEL% NEQ 0 exit /B 1
python -c "import contourpy as c; c.contour_generator(z=[[0, 1], [2, 3]]).lines(0.9)"
IF %ERRORLEVEL% NEQ 0 exit /B 1
exit /B 0
