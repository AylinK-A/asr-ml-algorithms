import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DB_URL = os.getenv("DB_URL", "sqlite:///./asr.db")
ECHO_SQL = os.getenv("ECHO_SQL", "0") == "1"

engine = create_engine(DB_URL, echo=ECHO_SQL, future=True)
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False, future=True)
