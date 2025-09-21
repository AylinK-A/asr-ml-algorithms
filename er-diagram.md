# ERD модель: Алгоритмы ASR, Структурные единицы и Системы

```mermaid
erDiagram
    ALGORITHMS {
      INTEGER id PK
      TEXT name
      TEXT era
      TEXT description
    }

    STRUCTURAL_UNITS {
      INTEGER id PK
      TEXT unit
      BOOLEAN considers_context
    }

    SYSTEMS {
      INTEGER id PK
      TEXT name
      TEXT developer
      INTEGER release_year
      TEXT license
      TEXT url
      TEXT description
    }

    SYSTEMS_ALGORITHMS {
      INTEGER system_id FK
      INTEGER algorithm_id FK
      PK "PRIMARY KEY (system_id, algorithm_id)"
    }

    ALGORITHM_STRUCTURAL_UNITS {
      INTEGER algorithm_id FK
      INTEGER unit_id FK
      PK "PRIMARY KEY (algorithm_id, unit_id)"
    }

    ALGORITHMS ||--o{ SYSTEMS_ALGORITHMS : used_in
    SYSTEMS ||--o{ SYSTEMS_ALGORITHMS : uses
    ALGORITHMS ||--o{ ALGORITHM_STRUCTURAL_UNITS : works_with
    STRUCTURAL_UNITS ||--o{ ALGORITHM_STRUCTURAL_UNITS : used_by
