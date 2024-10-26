#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"

# Release
$MXMLC_PATH \
	-default-size=600,600 \
	-optimize \
	-default-background-color=0x000000 \
	-frame=ContentFrame,Game \
	-default-frame-rate=60 \
	-source-path="../src" \
	-output=../../SWF/MMG-Trapdoorer-DEBUG.swf \
	-debug=true \
	-static-link-runtime-shared-libraries=true \
	../src/Obs/Loader.as

# Debug
$MXMLC_PATH \
	-default-size=600,600 \
	-optimize \
	-default-background-color=0x000000 \
	-frame=ContentFrame,Game \
	-default-frame-rate=60 \
	-source-path="./src" \
	-output=../../SWF/MMG-Trapdoorer-DEBUG.swf \
	-debug=true \
	-static-link-runtime-shared-libraries=true \
	../src/Obs/Loader.as