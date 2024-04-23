#!/bin/bash

#set -x

if [ "$0" = "-h" ] || [ "$0" = "--help" ]; then
    echo "Usage: ./run <local|findy>"
    echo "Options:"
    echo "  -h, --help    Show this help message."
    echo " local - use locally deployed backend "
    echo " findy - use findy deployed backend "
    exit 1
fi

HOST="$1"

if [ "$HOST" = "findy" ]; then
    BASE_URL="https://findy-agency.op-ai.fi/query"
elif [ "$HOST" = "local" ]; then
    LOCAL_HOST=$(cat host_address)
    BASE_URL="http://"$LOCAL_HOST":8085/query"
else
    echo "Error: Invalid host argument. Must be 'local' or 'findy'."
    exit 1
fi

cd ../frontend/
echo "$BASE_URL"
flutter run --dart-define=BASE_URL="$BASE_URL"
cd ../scripts/
