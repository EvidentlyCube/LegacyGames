#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"

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

$MXMLC_PATH \
	-default-size=512,448 \
	-optimize \
	-debug \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src/" \
	-source-path="../src.framework/" \
	-output=../../SWF/Linx-DEBUG.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,Main \
	../src/Preloader.as