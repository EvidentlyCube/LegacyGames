#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

# Release
$MXMLC_PATH \
	-default-size=600,600 \
	-optimize \
	-default-background-color=0x000000 \
	-frame=ContentFrame,Game \
	-default-frame-rate=60 \
	-source-path="../src" \
	-output=../../SWF/MMG-Trapdoorer.swf \
	-static-link-runtime-shared-libraries=true \
	../src/Obs/Loader.as

$PLAYER_PATH ../../SWF/MMG-Trapdoorer.swf