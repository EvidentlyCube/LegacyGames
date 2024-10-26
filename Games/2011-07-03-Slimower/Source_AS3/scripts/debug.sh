#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

$MXMLC_PATH \
	-default-size=512,448 \
	-optimize \
	-debug \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src" \
	-source-path="../src.framework" \
	-source-path="../src.sfxr" \
	-output=../../SWF/Slimower-DEBUG.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,game.core.Main \
	../src/game/preloader/Preloader.as

VAR=$(realpath ../../SWF/Slimower-DEBUG.swf)

$PLAYER_PATH $VAR