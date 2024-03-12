#!/bin/bash

#set -x

cli='findy-agent-cli'

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username> [device_option]"
    return 1
fi

USERNAME="$1"

#TODO - allow to specify device for flutter run
if [ ! -z $2 ]; then
    DEVICE="$2"
fi

if [ -z "$FCLI_KEY" ]; then
    export FCLI_KEY=`$cli new-key`
    printf "export FCLI_KEY=%s" $FCLI_KEY > use-key.sh
    echo "$FCLI_KEY" >> .key-backup
fi

source setup-cli-env.sh

LOGIN_OUTPUT=$($cli authn login -u "$USERNAME" 2>&1)

if echo "$LOGIN_OUTPUT" | grep -qE "user \(.+\) not exist"; then
    REGISTRATION_OUTPUT=$($cli authn register -u "$USERNAME" 2>&1)
    if echo "$REGISTRATION_OUTPUT" | grep -q "\"Registration Success\""; then
        echo "$USERNAME: $REGISTRATION_OUTPUT"
    else
        echo "$REGISTRATION_OUTPUT"
        return 1
    fi
    LOGIN_OUTPUT=$($cli authn login -u "$USERNAME" 2>&1)
fi

if [[ $LOGIN_OUTPUT == e* ]]; then
    echo "Login successful"
    echo "$USERNAME: $LOGIN_OUTPUT"
else
    echo "Login failed or did not produce a valid JWT token:"
    echo "$LOGIN_OUTPUT"
    return 1
fi

#why this doesn't work??
#if [[ $LOGIN_OUTPUT =~ ^[A-Za-z0-9-_]*\.[A-Za-z0-9-_]*\.[A-Za-z0-9-_]*$ ]]; then
#   echo "Login successful"
#   echo "$USERNAME: $LOGIN_OUTPUT"
#else
#   echo "Login failed or did not produce a valid JWT token:"
#   echo "$LOGIN_OUTPUT"
#   return 1
#fi

# Read IP address from the host_address file
HOST_ADDRESS=$(cat host_address)
pushd ../frontend/ > /dev/null
flutter run --dart-define=TOKEN="$LOGIN_OUTPUT" --dart-define=BASE_URL=$HOST_ADDRESS:8085/query
popd > /dev/null
