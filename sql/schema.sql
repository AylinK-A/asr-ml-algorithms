
---

# `sql/schema.sql`

```sql
PRAGMA foreign_keys = ON;

-- Таблица алгоритмов
CREATE TABLE IF NOT EXISTS ALGORITHMS (
    algorithm_id   INTEGER PRIMARY KEY,
    name           TEXT NOT NULL UNIQUE,
    era            TEXT NOT NULL CHECK (era IN ('классическая','гибридная','современная')),
    description    TEXT
);

-- Таблица структурных единиц
CREATE TABLE IF NOT EXISTS STRUCTURAL_UNITS (
    unit_id            INTEGER PRIMARY KEY,
    unit               TEXT NOT NULL UNIQUE,
    considers_context  BOOLEAN NOT NULL DEFAULT 0
);

-- Таблица систем (ASR)
CREATE TABLE IF NOT EXISTS SYSTEMS (
    system_id     INTEGER PRIMARY KEY,
    name          TEXT NOT NULL UNIQUE,
    developer     TEXT,
    release_year  INTEGER,
    license       TEXT,
    url           TEXT,
    description   TEXT
);

-- Связь: системы ↔ алгоритмы (M:N)
CREATE TABLE IF NOT EXISTS SYSTEMS_ALGORITHMS (
    system_id    INTEGER NOT NULL,
    algorithm_id INTEGER NOT NULL,
    PRIMARY KEY (system_id, algorithm_id),
    FOREIGN KEY (system_id) REFERENCES SYSTEMS(system_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (algorithm_id) REFERENCES ALGORITHMS(algorithm_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Связь: алгоритмы ↔ структурные единицы (M:N)
CREATE TABLE IF NOT EXISTS ALGORITHM_STRUCTURAL_UNITS (
    algorithm_id INTEGER NOT NULL,
    unit_id      INTEGER NOT NULL,
    PRIMARY KEY (algorithm_id, unit_id),
    FOREIGN KEY (algorithm_id) REFERENCES ALGORITHMS(algorithm_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (unit_id)      REFERENCES STRUCTURAL_UNITS(unit_id) ON DELETE CASCADE ON UPDATE CASCADE
);
