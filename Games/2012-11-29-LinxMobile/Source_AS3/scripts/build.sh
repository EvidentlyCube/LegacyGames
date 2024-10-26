#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"

$MXMLC_PATH \
	-default-size=600,600 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src/" \
	-source-path="../src.framework/" \
	-source-path="../src.starling/" \
	-output=../../SWF/LinxMobile.swf \
	-static-link-runtime-shared-libraries=true \
	../src/Main.as

$MXMLC_PATH \
	-default-size=600,600 \
	-optimize \
	-debug \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src/" \
	-source-path="../src.framework/" \
	-source-path="../src.starling/" \
	-output=../../SWF/LinxMobile-DEBUG.swf \
	-static-link-runtime-shared-libraries=true \
	../src/Main.as