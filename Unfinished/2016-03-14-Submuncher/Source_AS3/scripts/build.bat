SET MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc.bat"

%MXMLC_PATH% ^
	-default-size=960,704 ^
	-optimize ^
	-debug ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src/" ^
	-source-path="../src.framework/" ^
	-source-path="../src.starling/" ^
	-source-path="../src.utils/" ^
	-define=A::SSERT,"false" ^
	-output=../../SWF/Submuncher.swf ^
	-static-link-runtime-shared-libraries=true ^
	../src/submuncher/initialization/SubmuncherMain.as

%MXMLC_PATH% ^
	-default-size=960,704 ^
	-optimize ^
	-debug ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src/" ^
	-source-path="../src.framework/" ^
	-source-path="../src.starling/" ^
	-source-path="../src.utils/" ^
	-define=A::SSERT,"true" ^
	-output=../../SWF/Submuncher-DEBUG.swf ^
	-static-link-runtime-shared-libraries=true ^
	../src/submuncher/initialization/SubmuncherMain.as
