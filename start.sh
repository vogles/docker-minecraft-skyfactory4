#!/bin/bash

set -e

cd /data

cp -rf /tmp/feed-the-beast/* .
echo "eula=true" > eula.txt

if [[ ! -e server.properties ]]; then
    cp /tmp/server.properties .
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /data/server.properties
fi
if [[ -n "$SEED" ]]; then
    sed -i "/level-seed\s*=/ c level-seed=$SEED" /data/server.properties
fi
if [[ -n "$GENERATORPRESET" ]]; then
    sed -i "/generator-settings\s*=/ c generator-settings={\"Topography-Preset\":\"$GENERATORPRESET\"}" /data/server.properties
fi
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

#java $JVM_OPTS -jar forge-*-universal.jar nogui
java $JVM_OPTS -jar forge-1.12.2-14.23.5.2860.jar nogui
