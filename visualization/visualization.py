"""
Простая визуализация: столбики «сколько систем использует каждый алгоритм».
"""
import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import os

DB_URL = os.getenv("DB_URL", "sqlite:///./asr.db")
engine = create_engine(DB_URL, future=True)

def plot_systems_per_algorithm():
    sql = """
        SELECT a.name AS algorithm, COUNT(sa.system_id) AS systems_count
        FROM ALGORITHMS a
        LEFT JOIN SYSTEMS_ALGORITHMS sa ON sa.algorithm_id = a.id
        GROUP BY a.id
        ORDER BY systems_count DESC, a.name;
    """
    with engine.begin() as conn:
        df = pd.read_sql(sql, conn)

    plt.figure()
    plt.bar(df["algorithm"], df["systems_count"])
    plt.title("Сколько систем использует каждый алгоритм")
    plt.xlabel("Алгоритм")
    plt.ylabel("Количество систем")
    plt.xticks(rotation=30, ha="right")
    plt.tight_layout()
    plt.savefig("visualization_systems_per_algorithm.png", dpi=160)
    print("Saved -> visualization_systems_per_algorithm.png")

if __name__ == "__main__":
    plot_systems_per_algorithm()
