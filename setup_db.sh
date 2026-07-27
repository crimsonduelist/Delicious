#!/bin/bash
set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SQL_DIR="$PROJECT_DIR/sql"
CONTAINER="delicious-oracle"

# ---- Helper: run SQL inside the container ----
run_sql() {
    echo "$1" | docker exec -i "$CONTAINER" sqlplus -S system/oracle@localhost:1521/XE 2>/dev/null
}

run_sql_file() {
    cat "$1" | docker exec -i "$CONTAINER" sqlplus -S system/oracle@localhost:1521/XE @/dev/stdin 2>/dev/null
}

# ---- Helper: query a single number from Oracle ----
oracle_count() {
    echo "$1" | docker exec -i "$CONTAINER" sqlplus -S system/oracle@localhost:1521/XE 2>/dev/null | grep -E '^\s+[0-9]' | head -1 | tr -d '[:space:]'
}

# ---- Oracle Docker ----
if [ -x "$(command -v docker)" ]; then
    if [ "$(docker ps -a -q -f name=$CONTAINER)" ]; then
        if [ "$(docker ps -q -f name=$CONTAINER)" ]; then
            echo "Oracle XE already running — skipping."
        else
            echo "Starting Oracle XE container..."
            docker start "$CONTAINER"
        fi
    else
        echo "Setting up Oracle XE..."
        bash "$PROJECT_DIR/oracle_setup.sh"
    fi
else
    echo "Docker not found — skipping Oracle setup."
    echo "Make sure Oracle XE is running and accessible."
    exit 1
fi

# ---- Wait for DB ready ----
echo "Waiting for Oracle to be ready..."
until run_sql "SELECT 1 FROM DUAL;" | grep -q "1"; do
    sleep 5
done
echo "Oracle is ready."

# ---- 1. Check if tables exist ----
TABLE_COUNT=$(oracle_count "SELECT COUNT(*) FROM ALL_TABLES WHERE OWNER = 'SYSTEM' AND TABLE_NAME = 'PELATIS';")

if [ "$TABLE_COUNT" = "0" ]; then
    echo "Tables not found — creating schema..."
    run_sql_file "$SQL_DIR/CREATE_DB.sql"
    run_sql_file "$SQL_DIR/CHECKCONSTRAINTS.sql"
    echo "Tables and constraints created."
else
    echo "Tables already exist — skipping."
fi

# ---- 2. Check if sequence exists ----
SEQ_COUNT=$(oracle_count "SELECT COUNT(*) FROM ALL_SEQUENCES WHERE SEQUENCE_NAME = 'CUSTSEQ';")

if [ "$SEQ_COUNT" = "0" ]; then
    echo "Creating sequence..."
    run_sql "WHENEVER SQLERROR CONTINUE
ALTER TABLE KRATHSH ADD reservationNo NUMBER;
CREATE SEQUENCE CustSeq INCREMENT BY 1 START WITH 1;"
    echo "Sequence created."
else
    echo "Sequence already exists — skipping."
fi

# ---- 3. Stored objects (CREATE OR REPLACE — idempotent) ----
echo "Creating functions..."
run_sql_file "$SQL_DIR/FUNCTIONS.sql"
echo "Creating procedures..."
run_sql_file "$SQL_DIR/PROCEDURES.sql"
echo "Creating triggers..."
run_sql_file "$SQL_DIR/TRIGGERS.sql"
echo "Stored objects created."

# ---- 4. Check if indexes exist ----
IDX_COUNT=$(oracle_count "SELECT COUNT(*) FROM ALL_INDEXES WHERE INDEX_NAME = 'INDEX1';")

if [ "$IDX_COUNT" = "0" ]; then
    echo "Creating indexes..."
    run_sql_file "$SQL_DIR/INDEXES.sql"
    echo "Indexes created."
else
    echo "Indexes already exist — skipping."
fi

# ---- 5. Check if seeded ----
ROW_COUNT=$(oracle_count "SELECT COUNT(*) FROM PELATIS;")

if [ "$ROW_COUNT" = "0" ]; then
    echo "Seeding database..."
    run_sql_file "$SQL_DIR/INSERT_DB.sql"
    echo "Seed data inserted."
else
    echo "Data already exists ($ROW_COUNT rows) — skipping."
fi

# ---- 6. Check if views exist ----
VIEW_COUNT=$(oracle_count "SELECT COUNT(*) FROM ALL_VIEWS WHERE VIEW_NAME = 'VIEW1';")

if [ "$VIEW_COUNT" = "0" ]; then
    echo "Creating views..."
    run_sql_file "$SQL_DIR/VIEWS.sql"
    echo "Views created."
else
    echo "Views already exist — skipping."
fi

echo ""
echo "=== Database setup complete ==="
