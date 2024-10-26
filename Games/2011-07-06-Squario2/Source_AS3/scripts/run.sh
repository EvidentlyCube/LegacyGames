#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../.lib/ruffle/linux/ruffle

$MXMLC_PATH \
	-default-size=400,375 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src" \
	-output=../../SWF/Squario2.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,Mario \
	../src/objects/Loading.as

VAR=$(realpath ../../SWF/Squario2.swf)

$PLAYER_PATH $VAR