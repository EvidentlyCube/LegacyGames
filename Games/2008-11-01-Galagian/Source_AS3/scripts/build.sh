#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"

$MXMLC_PATH \
	-default-size=500,550 \
	-optimize \
	-default-background-color=0xFFFFFF \
	-frame=ContentFrame,core.Galagian \
	-source-path="../src" \
	-source-path+="../src.framework" \
	-output=../../SWF/Galagian.swf \
	-static-link-runtime-shared-libraries=true \
	../src/core/preloader/Preloader.as

$MXMLC_PATH \
	-default-size=500,550 \
	-optimize \
	-debug \
	-default-background-color=0xFFFFFF \
	-frame=ContentFrame,core.Galagian \
	-source-path="../src" \
	-source-path+="../src.framework" \
	-output=../../SWF/Galagian-DEBUG.swf \
	-static-link-runtime-shared-libraries=true \
	../src/core/preloader/Preloader.as