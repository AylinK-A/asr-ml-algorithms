# ERD Модель (упрощённый вид)

```mermaid
erDiagram
    SYSTEMS {
        INTEGER system_id PK
        TEXT name
    }

    ALGORITHMS {
        INTEGER algorithm_id PK
        TEXT name
    }

    STRUCTURAL_UNITS {
        INTEGER unit_id PK
        TEXT unit
    }

    SYSTEMS ||--o{ ALGORITHMS : uses
    ALGORITHMS ||--o{ STRUCTURAL_UNITS : works_with

