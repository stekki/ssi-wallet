#!/bin/bash

# clones scripts from findy-agent-cli
# https://github.com/findy-network/findy-agent-cli.git

REPO_URL='https://github.com/findy-network/findy-agent-cli.git'
TARGET_DIR='findy-agent-cli'
BRANCH='master'

if [ ! -d "$TARGET_DIR" ]; then
    git clone "$REPO_URL"
else
    echo "Nothing to be done"
fi

