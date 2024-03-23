#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: source setup-agent.sh <agent-name>"
    return 1
fi

source setup-cli-env.sh

export MY_ROOT=cli-tools/fullstack
AGENT_NAME="$1"
AGENT_PATH=play/"$AGENT_NAME"

cd "$MY_ROOT"
if [ -d "$AGENT_PATH" ]; then
    echo "agent "$1" exists"
    ./"$AGENT_PATH"/relogin
else
    ./make-play-agent.sh "$AGENT_NAME"
    echo "created new agent "$1""
fi

./"$AGENT_PATH"/auto-accept
./"$AGENT_PATH"/jwt
jwt="$(cat "$AGENT_PATH"/token)"
export FCLI_JWT="$jwt"

