"""
Загрузка стартовых данных в БД (через SQLAlchemy).
"""
from sqlalchemy import text
from database_tools.database_config import engine, SessionLocal
from database_tools.models import Base

SCHEMA_SQL = (Path("database_schema.sql")).read_text(encoding="utf-8")

from pathlib import Path

def init_db_from_schema():
    # Выполним чисто SQL (быстро и совпадает с заданием)
    with engine.begin() as conn:
        conn.exec_driver_sql(SCHEMA_SQL)

def main():
    init_db_from_schema()
    with SessionLocal() as session:
        # пример чтения: сколько систем и алгоритмов
        n_alg = session.execute(text("SELECT COUNT(*) FROM ALGORITHMS")).scalar_one()
        n_sys = session.execute(text("SELECT COUNT(*) FROM SYSTEMS")).scalar_one()
        print(f"Инициализация завершена. Алгоритмов: {n_alg}, Систем: {n_sys}")

if __name__ == "__main__":
    main()
