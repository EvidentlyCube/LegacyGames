SET MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc.bat"

%MXMLC_PATH% ^
	-default-size=540,400 ^
	-optimize ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-frame=ContentFrame,Mecard ^
	-source-path="../src" ^
	-output=../../SWF/Mecard.swf ^
	-static-link-runtime-shared-libraries=true ^
	../src/Loading.as

%MXMLC_PATH% ^
	-default-size=540,400 ^
	-optimize ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-frame=ContentFrame,Mecard ^
	-source-path="../src" ^
	-output=../../SWF/Mecard-DEBUG.swf ^
	-debug=true ^
	-static-link-runtime-shared-libraries=true ^
	../src/Loading.as