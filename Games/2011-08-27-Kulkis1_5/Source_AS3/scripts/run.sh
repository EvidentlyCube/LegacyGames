#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

$MXMLC_PATH \
	-default-size=528,448 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src" \
	-source-path="../src.framework" \
	-output=../../SWF/Kulkis1_5.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,game.core.Main \
	../src/game/core/preloader/Preloader.as

VAR=$(realpath ../../SWF/Kulkis1_5.swf)

$PLAYER_PATH $VAR