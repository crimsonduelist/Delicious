# Delicious

A Java Swing restaurant management app connecting to Oracle Database via JDBC. The app provides CRUD operations for customers, dishes, orders, and related entities through a graphical interface.

## Project Structure

```
sql/                  Oracle SQL scripts and setup
src/                  Java source code (package: delicious)
build.xml             Ant build file
nbproject/            NetBeans project configuration
manifest.mf           JAR manifest
build.sh              Build & run script
oracle_setup.sh       Set up Oracle XE via Docker (optional)
oracle_undo.sh        Tear down Oracle XE Docker container (optional)
```

## SQL Scripts

| File | Purpose |
|------|---------|
| `setup_db.sql` | **Full DB recreation** — drops existing objects, creates schema, inserts sample data. Run this to get a fresh database. |
| `CREATE_DB.sql` | Creates all tables |
| `DROP_DB.sql` | Drops all tables |
| `CHECKCONSTRAINTS.sql` | Adds check constraints |
| `FUNCTIONS.sql` | PL/SQL functions |
| `PROCEDURES.sql` | PL/SQL procedures |
| `TRIGGERS.sql` | Database triggers |
| `INDEXES.sql` | Performance indexes |
| `INSERT_DB.sql` | Sample data inserts |
| `VIEWS.sql` | SQL views |
| `ANONBLOCKS.sql` | Anonymous PL/SQL test blocks |
| `AUTOINCREMENTS.sql` | Sequences and column modifications |
| `DROP_STORED_OBJECTS.sql` | Drops procedures, functions, triggers |

## Dependencies

- Java 8+ (`java`, `javac` on `PATH`)
- Oracle Database (XE recommended)
- `ojdbc8.jar` — the Oracle JDBC driver (required at compile and runtime)
  - Usually pre-installed at `/usr/lib/ojdbc8.jar` with `oracle-instantclient-jdbc` (Arch)
  - Or download from https://www.oracle.com/database/technologies/appdev/jdbc-downloads.html and place in `lib/ojdbc8.jar`

## Quick Start

### Fresh database setup

```bash
# Run the combined setup script on Oracle:
sqlplus user/pass @sql/setup_db.sql
```

### Build and run the app

```bash
./build.sh
```

This cleans the build directory, compiles Java sources, and runs the app.

Oracle XE setup is handled separately — `oracle_setup.sh` (Docker) or your own local Oracle instance. Just make sure the connection credentials match.

The connection string the app expects is `jdbc:oracle:thin:@localhost:1521/XE` with username `system` and password `oracle`.

## Database

The app expects an Oracle database with the schema already created. Run `sql/setup_db.sql` to recreate from scratch, or run individual scripts in order:

1. `DROP_STORED_OBJECTS.sql`
2. `DROP_DB.sql`
3. `CREATE_DB.sql`
4. `CHECKCONSTRAINTS.sql`
5. `AUTOINCREMENTS.sql`
6. `FUNCTIONS.sql`
7. `PROCEDURES.sql`
8. `TRIGGERS.sql`
9. `INDEXES.sql`
10. `INSERT_DB.sql`
11. `VIEWS.sql`

## Oracle Container Management (optional)

```bash
./oracle_setup.sh   # Spin up Oracle XE via Docker
./oracle_undo.sh    # Tear down Oracle XE Docker container
```
