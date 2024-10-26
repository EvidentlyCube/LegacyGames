#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

VAR=$(realpath ../../SWF/KDDL2.swf)

rm -f $VAR

$MXMLC_PATH \
	-default-size=760,600 \
	-optimize \
	-default-background-color=0x000000 \
	-default-frame-rate=60 \
	-source-path="../src/" \
	-source-path="../src.framework/" \
	-source-path="../src.mp3swfmaker/" \
	-output=../../SWF/KDDL2.swf \
	-define=CF::lib,"false" \
	-define+=CF::play,"true" \
	-define+=CF::debug,"false" \
	-define+=CF::styleAbo,"false" \
	-define+=CF::styleCit,"false" \
	-define+=CF::styleDee,"false" \
	-define+=CF::styleFor,"true" \
	-define+=CF::styleFou,"false" \
	-define+=CF::styleIce,"true" \
	-define+=CF::defaultStyle,"'Iceworks'" \
	-define+=CF::holdKdd1,"false" \
	-define+=CF::holdKdd2,"true" \
	-define+=CF::holdKdd3,"false" \
	-static-link-runtime-shared-libraries=true \
	../src/Preloader.as

$PLAYER_PATH $VAR