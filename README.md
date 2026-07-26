# Delicious

A Java Swing restaurant management app connecting to Oracle Database via JDBC. The app provides CRUD operations for customers, dishes, orders, and related entities through a graphical interface.

## Project Structure

```
├── .gitignore
├── README.md
├── build.sh          Compiles and runs the app
├── oracle_setup.sh   Sets up Oracle XE via Docker (optional)
├── oracle_undo.sh    Tears down Oracle XE Docker container (optional)
├── sql/              Oracle SQL scripts
│   ├── ANONBLOCKS.sql
│   ├── AUTOINCREMENTS.sql
│   ├── CHECKCONSTRAINTS.sql
│   ├── CREATE_DB.sql
│   ├── DROP_DB.sql
│   ├── DROP_STORED_OBJECTS.sql
│   ├── FUNCTIONS.sql
│   ├── INDEXES.sql
│   ├── INSERT_DB.sql
│   ├── PROCEDURES.sql
│   ├── setup_db.sql  Full DB recreate script (all of the above)
│   ├── TRIGGERS.sql
│   └── VIEWS.sql
└── src/              Java source code (all classes in root, no package subdirs)
```

## Dependencies

- Java 8+ (`java`, `javac` on `PATH`)
- Oracle Database (XE recommended)
- `ojdbc8.jar` — the Oracle JDBC driver (required at compile and runtime)
  - Usually pre-installed at `/usr/lib/ojdbc8.jar` with `oracle-instantclient-jdbc`
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

Oracle XE setup is handled separately — `oracle_setup.sh` (Docker - the build script handles this also) or your own local Oracle instance. Just make sure the connection credentials match if you're using your own.

The connection string the app expects is `jdbc:oracle:thin:@localhost:1521/XE` with username `system` and password `oracle`.
