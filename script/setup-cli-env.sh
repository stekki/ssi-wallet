#!/bin/bash

cli=${FCLI:-findy-agent-cli}

# Read IP address from the host_address file
HOST_ADDRESS=$(cat host_address)

if [ -z "$FCLI_KEY" ]; then
    export FCLI_KEY=`$cli new-key`
    printf "export FCLI_KEY=%s" $FCLI_KEY > use-key.sh
    echo "$FCLI_KEY" >> .key-backup
fi

# Use the read IP address for setting environment variables
export FCLI_TLS_PATH="$PWD/config/cert"
export FCLI_USER="findy-root"
export FCLI_URL="http://$HOST_ADDRESS:8088"
export FCLI_SERVER="$HOST_ADDRESS:50052"
export FCLI_ORIGIN="http://$HOST_ADDRESS:3000"
export FCLI=$cli
