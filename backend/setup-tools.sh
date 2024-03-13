#!/bin/bash

REPO_URL='https://github.com/findy-network/findy-wallet-pwa.git'
SUB_PATH='tools/env'
TARGET_DIR='tools/env'
BRANCH='master'

TMP_DIR=$(mktemp -d)

echo "$TMP_DIR"

trap 'rm -rf "$TMP_DIR"' EXIT

cd "$STMP_DIR"
git clone "$REPO_URL" "$TMP_DIR"
mkdir -p "$TARGET_DIR"
mv "$TMP_DIR"/"$SUB_PATH"/* "$TARGET_DIR"
cd - > /dev/null

echo "Subpath '$SUB_PATH' from repository '$REPO_URL' has been extracted to '$TARGET_DIR'."
