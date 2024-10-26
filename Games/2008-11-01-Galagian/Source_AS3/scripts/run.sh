#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

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

$PLAYER_PATH ../../SWF/Galagian.swf