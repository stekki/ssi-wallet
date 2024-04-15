#!/bin/bash

#set -x

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: source run-as-user.sh <username> <local|findy>"
    echo "Options:"
    echo "  -h, --help    Show this help message."
    echo " local - use locally deployed backend "
    echo " findy - use findy deployed backend "
    return 1
fi

if [ "$#" -ne 2 ]; then
    echo "Usage: source run-as-user.sh <username> <local|findy>"
    return 1
fi

cli='findy-agent-cli'
USERNAME="$1"
HOST="$2"

if [ "$HOST" = "findy" ]; then
    BASE_URL="https://findy-agency.op-ai.fi/query"
    source .setup-cli-env-findy.sh
elif [ "$HOST" = "local" ]; then
    LOCAL_HOST=$(cat host_address)
    BASE_URL="http://"$LOCAL_HOST":8085/query"
    source .setup-cli-env-local.sh
else
    echo "Error: Invalid host argument. Must be 'local' or 'findy'."
    return 1
fi

LOGIN_OUTPUT=$("$cli" authn login -u "$USERNAME" 2>&1)

if echo "$LOGIN_OUTPUT" | grep -qE "user \(.+\) not exist"; then
    REGISTRATION_OUTPUT=$($cli authn register -u "$USERNAME" 2>&1)
    if echo "$REGISTRATION_OUTPUT" | grep -q "\"Registration Success\""; then
        echo "$USERNAME: $REGISTRATION_OUTPUT"
    else
        echo "$REGISTRATION_OUTPUT"
        return 1
    fi
    LOGIN_OUTPUT=$("$cli" authn login -u "$USERNAME" 2>&1)
fi

case "$LOGIN_OUTPUT" in
    *[.]*[.]*[A-Za-z-0-9-_])
        echo "Login successful"
        echo "$USERNAME: $LOGIN_OUTPUT"
        ;;
    *)
        echo "Login failed or did not produce a valid JWT token:"
        echo "$LOGIN_OUTPUT"
        return 1
        ;;
esac

cd ../frontend/
echo "$BASE_URL"
flutter run --dart-define=BASE_URL="$BASE_URL"
cd ../scripts/
