from sqlalchemy.orm import DeclarativeBase, relationship, Mapped, mapped_column
from sqlalchemy import String, Integer, Text, Boolean, ForeignKey, CheckConstraint, Table, Column, UniqueConstraint

class Base(DeclarativeBase):
    pass

# M:N таблицы
from sqlalchemy import MetaData
metadata = MetaData()

systems_algorithms = Table(
    "SYSTEMS_ALGORITHMS",
    metadata,
    Column("system_id", ForeignKey("SYSTEMS.id", ondelete="CASCADE", onupdate="CASCADE"), primary_key=True),
    Column("algorithm_id", ForeignKey("ALGORITHMS.id", ondelete="CASCADE", onupdate="CASCADE"), primary_key=True),
)

algorithm_structural_units = Table(
    "ALGORITHM_STRUCTURAL_UNITS",
    metadata,
    Column("algorithm_id", ForeignKey("ALGORITHMS.id", ondelete="CASCADE", onupdate="CASCADE"), primary_key=True),
    Column("unit_id", ForeignKey("STRUCTURAL_UNITS.id", ondelete="CASCADE", onupdate="CASCADE"), primary_key=True),
)

class Algorithm(Base):
    __tablename__ = "ALGORITHMS"
    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String, unique=True, nullable=False)
    era: Mapped[str] = mapped_column(String, nullable=False)
    description: Mapped[str | None] = mapped_column(Text)

    __table_args__ = (
        CheckConstraint("era IN ('классическая','гибридная','современная')", name="ck_alg_era"),
    )

    systems: Mapped[list["System"]] = relationship(secondary=systems_algorithms, back_populates="algorithms")
    units: Mapped[list["StructuralUnit"]] = relationship(secondary=algorithm_structural_units, back_populates="algorithms")

class StructuralUnit(Base):
    __tablename__ = "STRUCTURAL_UNITS"
    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    unit: Mapped[str] = mapped_column(String, unique=True, nullable=False)
    considers_context: Mapped[bool] = mapped_column(Boolean, nullable=False, default=False)

    algorithms: Mapped[list[Algorithm]] = relationship(secondary=algorithm_structural_units, back_populates="units")

class System(Base):
    __tablename__ = "SYSTEMS"
    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String, unique=True, nullable=False)
    developer: Mapped[str | None] = mapped_column(String)
    release_year: Mapped[int | None] = mapped_column(Integer)
    license: Mapped[str | None] = mapped_column(String)
    url: Mapped[str | None] = mapped_column(String)
    description: Mapped[str | None] = mapped_column(Text)

    algorithms: Mapped[list[Algorithm]] = relationship(secondary=systems_algorithms, back_populates="systems")
