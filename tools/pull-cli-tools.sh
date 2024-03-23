#!/bin/bash

# clones scripts from findy-agent-cli
# https://github.com/findy-network/findy-agent-cli.git

REPO_URL='https://github.com/findy-network/findy-agent-cli.git'
SUB_PATH='scripts'
TARGET_DIR='cli-tools'
BRANCH='master'

if [ ! -d "$TARGET_DIR" ]; then
    TMP_DIR="$(mktemp -d)"
    echo "$TMP_DIR"
    trap 'rm -rf "$TMP_DIR"' EXIT # remove temp folder on script exit
    cd "$STMP_DIR"
    git clone "$REPO_URL" "$TMP_DIR"
    mkdir -p "$TARGET_DIR"
    mv "$TMP_DIR"/"$SUB_PATH"/* "$TARGET_DIR"
    cd - > /dev/null

    echo "Subpath "$SUB_PATH" from repository "$REPO_URL" has been extracted to "$TARGET_DIR"."
else
    echo ""$TARGET_DIR" already exists. Run 'make clean' for fresh start."
fi
