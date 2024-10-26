#!/usr/bin/env bash
MXMLC_PATH="../../.lib/flex-sdk/bin/mxmlc"

$MXMLC_PATH \
	-default-size=400,375 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../Source_AS3" \
	-output=../SWF/MarioForeverFlash.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,Mario \
	../Source_AS3/objects/Loading.as

$MXMLC_PATH \
	-default-size=400,375 \
	-optimize \
	-debug \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../Source_AS3" \
	-output=../SWF/MarioForeverFlash-DEBUG.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,Mario \
	../Source_AS3/objects/Loading.as
