#!/bin/bash
set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$PROJECT_DIR/src"
BUILD_DIR="$PROJECT_DIR/build"
MAIN_CLASS="Delicious"

# Clean build — remove stale class files
echo "Cleaning build directory..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Run Oracle setup (if Docker is available and Oracle not already running)
if [ -x "$(command -v docker)" ]; then
    if [ "$(docker ps -a -q -f name=oracle-xe)" ]; then
        echo "Oracle XE container already exists — skipping setup."
    else
        echo "Setting up Oracle database..."
        "$PROJECT_DIR/oracle_setup.sh"
    fi
else
    echo "Docker not found — skipping Oracle setup."
    echo "Make sure Oracle XE is running and accessible before running the app."
fi

# Resolve ojdbc8.jar — prefer local lib/ then system path
if [ -f "$PROJECT_DIR/lib/ojdbc8.jar" ]; then
    JDBC_JAR="$PROJECT_DIR/lib/ojdbc8.jar"
elif [ -f "/usr/lib/ojdbc8.jar" ]; then
    JDBC_JAR="/usr/lib/ojdbc8.jar"
else
    echo "Error: ojdbc8.jar not found."
    echo "Place it in lib/ojdbc8.jar or install the system package:"
    echo "  Arch/Manjaro: yay -S oracle-instantclient-jdbc"
    exit 1
fi

echo "Compiling..."
javac -cp "$JDBC_JAR" -d "$BUILD_DIR" "$SRC_DIR"/*.java

echo "Running..."
java -cp "$BUILD_DIR:$JDBC_JAR" "$MAIN_CLASS"
