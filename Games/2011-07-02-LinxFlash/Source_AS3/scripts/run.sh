#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

VAR=$(realpath ../../SWF/Linx.swf)

rm -f $VAR

$MXMLC_PATH \
	-default-size=512,448 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src/" \
	-source-path="../src.framework/" \
	-output=../../SWF/Linx.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,Main \
	../src/Preloader.as

$PLAYER_PATH $VAR