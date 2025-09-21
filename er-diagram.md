
---

# `er-diagram.md`

```markdown
```mermaid
erDiagram
    ALGORITHMS {
      INTEGER algorithm_id PK
      TEXT name
      TEXT era
      TEXT description
    }

    STRUCTURAL_UNITS {
      INTEGER unit_id PK
      TEXT unit
      BOOLEAN considers_context
    }

    SYSTEMS {
      INTEGER system_id PK
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
    }

    ALGORITHM_STRUCTURAL_UNITS {
      INTEGER algorithm_id FK
      INTEGER unit_id FK
    }

    ALGORITHMS ||--o{ SYSTEMS_ALGORITHMS : used_in
    SYSTEMS ||--o{ SYSTEMS_ALGORITHMS : uses
    ALGORITHMS ||--o{ ALGORITHM_STRUCTURAL_UNITS : works_with
    STRUCTURAL_UNITS ||--o{ ALGORITHM_STRUCTURAL_UNITS : used_by
