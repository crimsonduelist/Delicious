#!/bin/bash
set -e

CONTAINER_NAME="delicious-oracle"

echo "=== Tearing down Oracle XE Docker container ==="

if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping container '$CONTAINER_NAME'..."
    docker stop "$CONTAINER_NAME"
    docker rm "$CONTAINER_NAME"
    echo "Container removed."
else
    echo "Container '$CONTAINER_NAME' not found. Nothing to tear down."
fi
