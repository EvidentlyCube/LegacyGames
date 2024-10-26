#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"

$MXMLC_PATH \
	-default-size=600,600 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src" \
	-output=../../SWF/Trapdoorer.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,TD \
	../src/LoadingDir/Loading.as

$MXMLC_PATH \
	-default-size=600,600 \
	-optimize \
	-debug \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src" \
	-output=../../SWF/Trapdoorer-DEBUG.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,TD \
	../src/LoadingDir/Loading.as