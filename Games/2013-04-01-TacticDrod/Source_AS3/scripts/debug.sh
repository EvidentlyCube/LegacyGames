#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

VAR=$(realpath ../../SWF/TacticDrod-DEBUG.swf)

rm -f $VAR

$MXMLC_PATH \
	-default-size=800,600 \
	-optimize \
	-debug \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src/" \
	-source-path="../src.framework/" \
	-source-path="../src.starling/" \
	-define=CF::debug,"false" \
	-output=../../SWF/TacticDrod-DEBUG.swf \
	-static-link-runtime-shared-libraries=true \
	../src/Preloader.as

$PLAYER_PATH $VAR