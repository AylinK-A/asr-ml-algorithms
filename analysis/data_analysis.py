"""
Примеры аналитических запросов и вывод в консоль/CSV.
"""
import pandas as pd
from sqlalchemy import create_engine
import os
from tabulate import tabulate

DB_URL = os.getenv("DB_URL", "sqlite:///./asr.db")
engine = create_engine(DB_URL, future=True)

QUERIES = {
    "algorithms_by_era": """
        SELECT id, name, era FROM ALGORITHMS ORDER BY era, name;
    """,
    "units_per_algorithm": """
        SELECT a.name AS algorithm, GROUP_CONCAT(su.unit, ', ') AS units
        FROM ALGORITHMS a
        JOIN ALGORITHM_STRUCTURAL_UNITS asu ON a.id = asu.algorithm_id
        JOIN STRUCTURAL_UNITS su ON su.id = asu.unit_id
        GROUP BY a.id ORDER BY a.name;
    """,
    "algorithms_per_system": """
        SELECT s.name AS system, GROUP_CONCAT(a.name, ', ') AS algorithms
        FROM SYSTEMS s
        JOIN SYSTEMS_ALGORITHMS sa ON sa.system_id = s.id
        JOIN ALGORITHMS a ON a.id = sa.algorithm_id
        GROUP BY s.id ORDER BY s.name;
    """,
    "modern_systems": """
        SELECT DISTINCT s.name
        FROM SYSTEMS s
        JOIN SYSTEMS_ALGORITHMS sa ON sa.system_id = s.id
        JOIN ALGORITHMS a ON a.id = sa.algorithm_id
        WHERE a.era='современная' ORDER BY s.name;
    """,
    "systems_per_algorithm": """
        SELECT a.name, COUNT(*) AS systems_count
        FROM ALGORITHMS a
        LEFT JOIN SYSTEMS_ALGORITHMS sa ON sa.algorithm_id = a.id
        GROUP BY a.id ORDER BY systems_count DESC, a.name;
    """,
    "context_units_algorithms": """
        SELECT DISTINCT a.name
        FROM ALGORITHMS a
        JOIN ALGORITHM_STRUCTURAL_UNITS asu ON asu.algorithm_id = a.id
        JOIN STRUCTURAL_UNITS su ON su.id = asu.unit_id
        WHERE su.considers_context = 1
        ORDER BY a.name;
    """
}

def run_queries():
    with engine.begin() as conn:
        for title, sql in QUERIES.items():
            df = pd.read_sql(sql, conn)
            print(f"\n=== {title} ===")
            if df.empty:
                print("(no rows)")
            else:
                print(tabulate(df, headers="keys", tablefmt="github", showindex=False))
                out = f"analysis_{title}.csv"
                df.to_csv(out, index=False)
                print(f"Saved -> {out}")

if __name__ == "__main__":
    run_queries()
