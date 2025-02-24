setlocal EnableDelayedExpansion

:: Configuration
set FLEX_SDK=..\..\..\..\.lib\flex-sdk
set ROOT=..\
set BIN_DIR=%ROOT%\bin
set CERT_PATH=%ROOT%\keys\newcert.p12
set CERT_PASSWORD=password123password123

:: Create directories
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
if not exist "%ROOT%\keys" mkdir "%ROOT%\keys"

:: goto gohere

:: Generate certificate
echo Generating certificate...
"%FLEX_SDK%\bin\adt.bat" -certificate ^
    -cn "Self Signed" ^
    -ou "Development" ^
    -o "Company" ^
    -c "US" ^
    2048-RSA ^
    "%CERT_PATH%" ^
    "%CERT_PASSWORD%"