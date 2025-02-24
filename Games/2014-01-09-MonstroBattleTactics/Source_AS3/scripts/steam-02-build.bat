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


:: Compile SWF
echo Compiling SWF...
java ^
	-Xmx1024m ^
	-Dsun.io.useCanonCaches=false ^
	-jar "..\..\..\..\.lib\flex-sdk\lib\mxmlc.jar" ^
	+flexlib="..\..\..\..\.lib\flex-sdk\frameworks" ^
    -target-player=11.9 ^
    -default-size=1280,720 ^
    -default-background-color=0 ^
    -use-network=true ^
    -locale=en_US ^
    -optimize ^
    -source-path="%ROOT%\src" ^
    -source-path="%ROOT%\src.framework" ^
    -source-path="%ROOT%\src.lighting" ^
    -source-path="%ROOT%\src.starling" ^
    -source-path="%ROOT%\src.suspenders" ^
    -source-path="%ROOT%\src.utils" ^
    -library-path+="%FLEX_SDK%\frameworks\libs\air" ^
    -external-library-path+="%ROOT%\src.framework\NewgroundsAPI.swc" ^
    -external-library-path+="%ROOT%\libs\FRESteamWorks.ane" ^
    -static-link-runtime-shared-libraries=true ^
    -namespace=http://ns.adobe.com/air/application/3.6,"%FLEX_SDK%\frameworks\air-config.xml" ^
    -keep-as3-metadata=Inject,PostConstruct ^
    -define+=CF::debug,false ^
    -define+=CF::isRelease,true ^
    -define+=CF::OG,false ^
    -define+=CF::enableCheats,false ^
    -define+=CF::steam,true ^
    -define+=CF::drmFree,false ^
    -define+=CF::flash,false ^
    -define+=CF::desktop,true ^
    -define+=L::OG,false ^
    -output="%BIN_DIR%\Monstro.swf" ^
    "%ROOT%\src\net\retrocade\tacticengine\monstro\global\core\CoreStarter.as"