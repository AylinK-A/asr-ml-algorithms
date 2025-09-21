import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "data" / "asr.db"
SCHEMA = (ROOT / "sql" / "schema.sql").read_text(encoding="utf-8")
SEED = (ROOT / "sql" / "seed.sql").read_text(encoding="utf-8")
QUERIES = (ROOT / "sql" / "queries.sql").read_text(encoding="utf-8")

def run_script(conn, sql_text):
    with conn:
        conn.executescript(sql_text)

def run_queries(conn, sql_text):
    print("=== Running sample queries ===")
    for q in [q.strip() for q in sql_text.split(";") if q.strip()]:
        print("\n---- Query ----")
        print(q)
        cur = conn.execute(q)
        rows = cur.fetchall()
        cols = [d[0] for d in cur.description] if cur.description else []
        if not rows:
            print("(no rows)")
            continue
        # pretty print
        widths = [max(len(str(c)), *(len(str(r[i])) for r in rows)) for i, c in enumerate(cols)]
        print(" | ".join(str(c).ljust(widths[i]) for i, c in enumerate(cols)))
        print("-+-".join("-" * w for w in widths))
        for r in rows:
            print(" | ".join(str(r[i]).ljust(widths[i]) for i in range(len(cols))))

def main():
    DB_PATH.parent.mkdir(parents=True, exist_ok=True)
    if DB_PATH.exists():
        DB_PATH.unlink()
    conn = sqlite3.connect(DB_PATH.as_posix())
    try:
        run_script(conn, SCHEMA)
        run_script(conn, SEED)
        run_queries(conn, QUERIES)
    finally:
        conn.close()
    print(f"\nDB created at: {DB_PATH}")

if __name__ == "__main__":
    main()
