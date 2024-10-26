#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
$MXMLC_PATH \
	-default-size=450,450 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src" \
	-source-path="../src.framework" \
	-output=../../SWF/Galaxus.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,core.Main \
	../src/preloader/Preloader.as

$MXMLC_PATH \
	-default-size=450,450 \
	-optimize \
	-debug \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src" \
	-source-path="../src.framework" \
	-output=../../SWF/Galaxus-DEBUG.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,core.Main \
	../src/preloader/Preloader.as