# ASR Algorithms & Structural Units — Анализ

Репозиторий для учебного проекта по теме: алгоритмы распознавания речи, структурные единицы и системы, которые их используют.

## Структура

├── erd_model.md
├── database_schema.sql
├── data_collection_plan.md
├── requirements.txt
├── data_collection/
│ ├── group1_huggingface_models/
│ │ └── huggingface_scraper.py
│ ├── group2_datasets/
│ │ └── datasets_scraper.py
│ ├── group3_papers/
│ │ └── papers_scraper.py
│ └── group4_benchmarks/
│ └── benchmarks_scraper.py
├── database_tools/
│ ├── database_config.py
│ ├── models.py
│ ├── data_loader.py
│ └── config_example.py
├── analysis/
│ ├── data_analysis.py
│ └── interactive_analysis.ipynb
├── visualization/
│ └── visualization.py
└── run_analysis.py


## Быстрый старт

```bash
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt

# Создать/пересоздать БД, выполнить анализ и построить график
python run_analysis.py

## Что будет создано

```bash
asr.db — SQLite база данных (в корне репозитория).
CSV-отчёты: analysis_*.csv в корне.
Картинка: visualization_systems_per_algorithm.png.

## Описание данных

```bash

## Таблицы

```bash

ALGORITHMS(id, name, era, description) — HMM, DNN, RNN, LSTM, Transformer, CTC, CNN.
STRUCTURAL_UNITS(id, unit, considers_context) — фонема, трифон, слово, графема, …
SYSTEMS(id, name, developer, release_year, license, url, description) — CMU Sphinx, Kaldi, DeepSpeech, wav2vec 2.0, Whisper, Vosk.
SYSTEMS_ALGORITHMS(system_id, algorithm_id) — M:N.
ALGORITHM_STRUCTURAL_UNITS(algorithm_id, unit_id) — M:N.

## Примеры запросов

```bash

Какие алгоритмы использует система?
С какими структурными единицами работает алгоритм?
Какие системы используют «современные» алгоритмы?

## Настройки

```bash

По умолчанию используется SQLite:
DB_URL=sqlite:///./asr.db

## Источники данных

```bash

Скрипты в data_collection/* — заготовки для сбора с Hugging Face, датасетов, статей и бенчмарков. На учебном этапе достаточно статического наполнения из database_schema.sql. Потом можно расширить: собирать в JSON и загружать в БД через SQLAlchemy.
