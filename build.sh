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

# Setup database (Docker, schema, seed data)
bash "$PROJECT_DIR/setup_db.sh"

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
