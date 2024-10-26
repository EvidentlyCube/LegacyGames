SET MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc.bat"

%MXMLC_PATH% ^
	-default-size=400,375 ^
	-optimize ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src" ^
	-output=../../SWF/Squario.swf ^
	-static-link-runtime-shared-libraries=true ^
	-frame=ContentFrame,Mario ^
	../src/objects/Loading.as

%MXMLC_PATH% ^
	-default-size=400,375 ^
	-optimize ^
	-debug ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src" ^
	-output=../../SWF/Squario-DEBUG.swf ^
	-static-link-runtime-shared-libraries=true ^
	-frame=ContentFrame,Mario ^
	../src/objects/Loading.as