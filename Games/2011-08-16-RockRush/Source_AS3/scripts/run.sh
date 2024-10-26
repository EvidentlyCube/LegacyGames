#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

VAR=$(realpath ../../SWF/RockRush.swf)

rm -f $VAR

$MXMLC_PATH \
	-default-size=528,448 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src/" \
	-source-path="../src.framework/" \
	-output=../../SWF/RockRush.swf \
	-static-link-runtime-shared-libraries=true \
	-frame=ContentFrame,game.global.CoreStarter \
	../src/game/global/Preloader.as

$PLAYER_PATH $VAR