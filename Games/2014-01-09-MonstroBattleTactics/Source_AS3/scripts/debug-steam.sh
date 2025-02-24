#!/usr/bin/env bash

# Place Monstro EXE into `<Monstro>/EXE` and run this script to quickly
# check if things work

FLEX_PATH=$(realpath "../../../../.lib/flex-sdk")
MXMLC_PATH="$FLEX_PATH/bin/mxmlc"
EXEC_PATH=$(realpath "../../Exe/Monstro Battle Tactics.exe")

OUTPUT=$(realpath "../../Exe/Monstro.swf")

rm -f "$OUTPUT"

$MXMLC_PATH \
	-target-player=11.9 \
	-default-size=1280,720 \
	-default-background-color=0 \
	-use-network=true \
	-locale=en_US \
	-optimize \
	-debug \
	-source-path="../src" \
	-source-path="../src.framework" \
	-source-path="../src.lighting" \
	-source-path="../src.starling" \
	-source-path="../src.suspenders" \
	-source-path="../src.utils" \
    -library-path+="$FLEX_PATH/frameworks/libs/air" \
	-external-library-path+="../src.framework/NewgroundsAPI.swc" \
    -external-library-path+="../libs/FRESteamWorks.ane" \
    -static-link-runtime-shared-libraries=true \
    -namespace=http://ns.adobe.com/air/application/3.6,"$FLEX_PATH/frameworks/air-config.xml" \
	-keep-as3-metadata=Inject,PostConstruct \
	-define+=CF::debug,true \
	-define+=CF::isRelease,true \
	-define+=CF::enableCheats,true \
	-define+=CF::steam,true \
	-define+=CF::drmFree,false \
	-define+=CF::desktop,true \
	-define+=CF::flash,false \
	-define+=L::OG,true \
	-output="$OUTPUT" \
	../src/net/retrocade/tacticengine/monstro/global/core/CoreStarter.as

cd $(dirname "$EXEC_PATH")
wine "$EXEC_PATH"