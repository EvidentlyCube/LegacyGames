setlocal EnableDelayedExpansion

:: Configuration
set FLEX_SDK=..\..\..\..\.lib\flex-sdk
set ROOT=..\
set BIN_DIR=%ROOT%\..\Exe
set CERT_PATH=%ROOT%\keys\newcert.p12
set CERT_PASSWORD=password123password123

:: Create directories
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
if not exist "%ROOT%\keys" mkdir "%ROOT%\keys"

:: Package AIR
echo Packaging AIR application...
"%FLEX_SDK%\bin\adt.bat" -package ^
    -storetype pkcs12 ^
    -keystore "%CERT_PATH%" ^
    -storepass "%CERT_PASSWORD%" ^
    -tsa "https://rfc3161.ai.moda/" ^
    -target bundle ^
    "%BIN_DIR%" ^
    "%ROOT%\src\Monstro-Steam-AIR.xml" ^
    -C "%BIN_DIR%" "Monstro.swf" ^
    -C "%ROOT%\assets\gfx" "gameIcon" ^
    -C "%ROOT%\assets" "video" ^
    -C "%ROOT%\assets\gfx" "map" ^
    -C "%ROOT%\libs" "steam_api.dll" ^
    -C "%ROOT%\assets" "voices" ^
    -extdir "%ROOT%\libs"
