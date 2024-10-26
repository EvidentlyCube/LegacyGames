#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

VAR=$(realpath ../../SWF/KDDL1.swf)

rm -f $VAR

$MXMLC_PATH \
	-default-size=760,600 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src/" \
	-source-path="../src.framework/" \
	-source-path="../src.mp3swfmaker/" \
	-output=../../SWF/KDDL1.swf \
	-define=CF::lib,"false" \
	-define+=CF::play,"true" \
	-define+=CF::debug,"false" \
	-define+=CF::styleAbo,"false" \
	-define+=CF::styleCit,"false" \
	-define+=CF::styleDee,"true" \
	-define+=CF::styleFor,"false" \
	-define+=CF::styleFou,"true" \
	-define+=CF::styleIce,"false" \
	-define+=CF::defaultStyle,"'Deep Spaces'" \
	-define+=CF::holdKdd1,"true" \
	-define+=CF::holdKdd2,"false" \
	-define+=CF::holdKdd3,"false" \
	-static-link-runtime-shared-libraries=true \
	../src/Preloader.as

$PLAYER_PATH $VAR