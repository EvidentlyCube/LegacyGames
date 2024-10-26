#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

# Release
$MXMLC_PATH \
	-default-size=540,400 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-frame=ContentFrame,Mecard \
	-source-path="../src" \
	-output=../../SWF/Mecard.swf \
	-static-link-runtime-shared-libraries=true \
	../src/Loading.as

$PLAYER_PATH ../../SWF/Mecard.swf