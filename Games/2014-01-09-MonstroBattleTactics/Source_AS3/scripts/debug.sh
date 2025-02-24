#!/usr/bin/env bash
MXMLC_PATH="../../../../.lib/flex-sdk/bin/mxmlc"
PLAYER_PATH="../../../../.lib/ruffle/linux/ruffle"

VAR=$(realpath ../../SWF/MonstroBattleTactics-DEBUG.swf)

rm -f $VAR

$MXMLC_PATH \
	-default-size=1280,720 \
	-optimize \
	-debug \
	-default-background-color=0 \
	-use-network=true \
	-source-path="../src" \
	-source-path="../src.framework" \
	-source-path="../src.lighting" \
	-source-path="../src.starling" \
	-source-path="../src.suspenders" \
	-source-path="../src.utils" \
	-external-library-path+="../src.framework/NewgroundsAPI.swc" \
	-define+=CF::debug,true \
	-define+=CF::isRelease,true \
	-define+=CF::enableCheats,true \
	-define+=CF::steam,false \
	-define+=CF::drmFree,false \
	-define+=CF::desktop,false \
	-define+=CF::flash,true \
	-define+=L::OG,true \
	-locale=en_US \
	-keep-as3-metadata=Inject,PostConstruct \
	-target-player=11.9 \
	-output=$VAR \
	-static-link-runtime-shared-libraries=true \
	../src/net/retrocade/tacticengine/monstro/global/core/CoreStarter.as

$PLAYER_PATH $VAR