#!/bin/bash

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi

export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

xvfb-run --server-args="$DISPLAY -screen 0 $GEOMETRY -ac +extension RANDR" \
  java -jar /opt/selenium/selenium-server-standalone.jar ${JAVA_OPTS} "${@:1}" &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID
