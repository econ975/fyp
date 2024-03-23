pip check
if errorlevel 1 exit 1
sip-distinfo --help
if errorlevel 1 exit 1
sip-module --help
if errorlevel 1 exit 1
sip-build --help
if errorlevel 1 exit 1
sip-install --help
if errorlevel 1 exit 1
sip-sdist --help
if errorlevel 1 exit 1
sip-wheel --help
if errorlevel 1 exit 1

cd test
sip-build
if errorlevel 1 exit 1
