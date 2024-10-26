SET MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc.bat"

%MXMLC_PATH% ^
	-default-size=760,600 ^
	-optimize ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src/" ^
	-source-path="../src.framework/" ^
	-source-path="../src.mp3swfmaker/" ^
	-output=../../SWF/KDDL1.swf ^
	-define=CF::lib,"false" ^
	-define+=CF::play,"true" ^
	-define+=CF::debug,"false" ^
	-define+=CF::styleAbo,"false" ^
	-define+=CF::styleCit,"false" ^
	-define+=CF::styleDee,"true" ^
	-define+=CF::styleFor,"false" ^
	-define+=CF::styleFou,"true" ^
	-define+=CF::styleIce,"false" ^
	-define+=CF::defaultStyle,"'Deep Spaces'" ^
	-define+=CF::holdKdd1,"true" ^
	-define+=CF::holdKdd2,"false" ^
	-define+=CF::holdKdd3,"false" ^
	-static-link-runtime-shared-libraries=true ^
	../src/Preloader.as


%MXMLC_PATH% ^
	-default-size=760,600 ^
	-optimize ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src/" ^
	-source-path="../src.framework/" ^
	-source-path="../src.mp3swfmaker/" ^
	-output=../../SWF/KDDL2.swf ^
	-define=CF::lib,"false" ^
	-define+=CF::play,"true" ^
	-define+=CF::debug,"false" ^
	-define+=CF::styleAbo,"false" ^
	-define+=CF::styleCit,"false" ^
	-define+=CF::styleDee,"false" ^
	-define+=CF::styleFor,"true" ^
	-define+=CF::styleFou,"false" ^
	-define+=CF::styleIce,"true" ^
	-define+=CF::defaultStyle,"'Iceworks'" ^
	-define+=CF::holdKdd1,"false" ^
	-define+=CF::holdKdd2,"true" ^
	-define+=CF::holdKdd3,"false" ^
	-static-link-runtime-shared-libraries=true ^
	../src/Preloader.as

%MXMLC_PATH% ^
	-default-size=760,600 ^
	-optimize ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src/" ^
	-source-path="../src.framework/" ^
	-source-path="../src.mp3swfmaker/" ^
	-output=../../SWF/KDDL3.swf ^
	-define=CF::lib,"false" ^
	-define+=CF::play,"true" ^
	-define+=CF::debug,"false" ^
	-define+=CF::styleAbo,"true" ^
	-define+=CF::styleCit,"true" ^
	-define+=CF::styleDee,"false" ^
	-define+=CF::styleFor,"false" ^
	-define+=CF::styleFou,"false" ^
	-define+=CF::styleIce,"false" ^
	-define+=CF::defaultStyle,"'Aboveground'" ^
	-define+=CF::holdKdd1,"false" ^
	-define+=CF::holdKdd2,"false" ^
	-define+=CF::holdKdd3,"true" ^
	-static-link-runtime-shared-libraries=true ^
	../src/Preloader.as

%MXMLC_PATH% ^
	-default-size=760,600 ^
	-optimize ^
	-debug ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src/" ^
	-source-path="../src.framework/" ^
	-source-path="../src.mp3swfmaker/" ^
	-output=../../SWF/KDDL1-DEBUG.swf ^
	-define=CF::lib,"false" ^
	-define+=CF::play,"true" ^
	-define+=CF::debug,"true" ^
	-define+=CF::styleAbo,"false" ^
	-define+=CF::styleCit,"false" ^
	-define+=CF::styleDee,"true" ^
	-define+=CF::styleFor,"false" ^
	-define+=CF::styleFou,"true" ^
	-define+=CF::styleIce,"false" ^
	-define+=CF::defaultStyle,"'Deep Spaces'" ^
	-define+=CF::holdKdd1,"true" ^
	-define+=CF::holdKdd2,"false" ^
	-define+=CF::holdKdd3,"false" ^
	-static-link-runtime-shared-libraries=true ^
	../src/Preloader.as

%MXMLC_PATH% ^
	-default-size=760,600 ^
	-optimize ^
	-debug ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src/" ^
	-source-path="../src.framework/" ^
	-source-path="../src.mp3swfmaker/" ^
	-output=../../SWF/KDDL2-DEBUG.swf ^
	-define=CF::lib,"false" ^
	-define+=CF::play,"true" ^
	-define+=CF::debug,"true" ^
	-define+=CF::styleAbo,"false" ^
	-define+=CF::styleCit,"false" ^
	-define+=CF::styleDee,"false" ^
	-define+=CF::styleFor,"true" ^
	-define+=CF::styleFou,"false" ^
	-define+=CF::styleIce,"true" ^
	-define+=CF::defaultStyle,"'Iceworks'" ^
	-define+=CF::holdKdd1,"false" ^
	-define+=CF::holdKdd2,"true" ^
	-define+=CF::holdKdd3,"false" ^
	-static-link-runtime-shared-libraries=true ^
	../src/Preloader.as

%MXMLC_PATH% ^
	-default-size=760,600 ^
	-optimize ^
	-debug ^
	-default-background-color=0x000000 ^
	-default-frame-rate=60 ^
	-source-path="../src/" ^
	-source-path="../src.framework/" ^
	-source-path="../src.mp3swfmaker/" ^
	-output=../../SWF/KDDL3-DEBUG.swf ^
	-define=CF::lib,"false" ^
	-define+=CF::play,"true" ^
	-define+=CF::debug,"true" ^
	-define+=CF::styleAbo,"true" ^
	-define+=CF::styleCit,"true" ^
	-define+=CF::styleDee,"false" ^
	-define+=CF::styleFor,"false" ^
	-define+=CF::styleFou,"false" ^
	-define+=CF::styleIce,"false" ^
	-define+=CF::defaultStyle,"'Aboveground'" ^
	-define+=CF::holdKdd1,"false" ^
	-define+=CF::holdKdd2,"false" ^
	-define+=CF::holdKdd3,"true" ^
	-static-link-runtime-shared-libraries=true ^
	../src/Preloader.as