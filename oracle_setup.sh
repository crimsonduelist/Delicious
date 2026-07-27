#!/bin/bash
set -e

CONTAINER_NAME="delicious-oracle"
PORT=1521
IMAGE="gvenzl/oracle-xe:21-slim"

echo "=== Setting up Oracle XE with Docker ==="

if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Container '$CONTAINER_NAME' already exists. Removing..."
    docker rm -f "$CONTAINER_NAME"
fi

echo "Pulling $IMAGE..."
docker pull "$IMAGE"

echo "Starting Oracle XE container..."
docker run -d \
    --name "$CONTAINER_NAME" \
    -p "$PORT:1521" \
    -e ORACLE_PASSWORD=oracle \
    "$IMAGE"

echo "Waiting for Oracle to be ready..."
until docker logs "$CONTAINER_NAME" 2>&1 | grep -q "DATABASE IS READY TO USE"; do
    sleep 5
done

echo ""
echo "=== Oracle XE is ready ==="
echo "Connection string: jdbc:oracle:thin:@localhost:$PORT/XE"
echo "Username: system"
echo "Password: oracle"
echo ""
echo "Schema scripts are in sql/ — run 4020_CREATE_DB.sql first, then the rest in order."
