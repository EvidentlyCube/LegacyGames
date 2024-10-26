SET MXMLC_PATH="../../.lib/flex-sdk/bin/mxmlc.bat"

%MXMLC_PATH% ^
	-default-size=800,600 ^
	-optimize ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src" ^
	-output=../../SWF/SketcherLevelMaker.swf ^
	-static-link-runtime-shared-libraries=true ^
	../src/SketcherLevelMaker.mxml


%MXMLC_PATH% ^
	-default-size=800,600 ^
	-optimize ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src" ^
	-output=../../SWF/SketcherLevelMaker-DEBUG.swf ^
	-debug=true ^
	-static-link-runtime-shared-libraries=true ^
	../src/SketcherLevelMaker.mxml
