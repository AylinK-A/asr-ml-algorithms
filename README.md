# Анализ алгоритмов распознавания речи (ASR)

![Python](https://img.shields.io/badge/Python-3.11-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Database](https://img.shields.io/badge/Database-SQLite-lightgrey.svg)

Учебный проект: моделирование и анализ алгоритмов и систем автоматического распознавания речи.  
Цель — показать эволюцию алгоритмов (от HMM до Transformer), их связь со структурными единицами (фонема, трифон, слово и др.) и применение в системах (Sphinx, Kaldi, DeepSpeech, wav2vec 2.0, Whisper, Vosk).

---

## Содержание
- [ER-модель](#er-модель)
- [Структура проекта](#структура-проекта)
- [Быстрый старт](#быстрый-старт)
- [Примеры анализа](#примеры-анализа)
- [Визуализации](#визуализации)
- [Источники данных](#источники-данных)
- [Авторы](#авторы)

---

## ER-модель
  
*Связи: алгоритмы ↔ системы, алгоритмы ↔ структурные единицы.*

---

## Структура проекта

```bash

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
├── run_analysis.py
└── README.md

---

## Быстрый старт

```bash
git clone https://github.com/<your-login>/asr-ml-algorithms.git
cd asr-ml-algorithms

python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt

---

# создать БД, выполнить анализ и построить графики
python run_analysis.py
В результате появятся:
asr.db — база SQLite
CSV-файлы с результатами (analysis_*.csv)
картинка visualization_systems_per_algorithm.png
Примеры анализа
SQL-запрос: какие алгоритмы использует каждая система?
SELECT s.name AS system, GROUP_CONCAT(a.name, ', ') AS algorithms
FROM SYSTEMS s
JOIN SYSTEMS_ALGORITHMS sa ON sa.system_id = s.id
JOIN ALGORITHMS a ON a.id = sa.algorithm_id
GROUP BY s.id;
Вывод
system	algorithms
CMU Sphinx	HMM
Kaldi	HMM, DNN
DeepSpeech	RNN, CTC
wav2vec2.0	Transformer, CTC
Whisper	Transformer
Vosk	HMM, DNN
Визуализации
Гистограмма: сколько систем использует каждый алгоритм.
Источники данных
Hugging Face — карточки моделей (Whisper, wav2vec 2.0 и др.)
Научные статьи — Deep Speech, Attention is All You Need
Датасеты — LibriSpeech, Common Voice
Бенчмарки — Papers with Code, лидерборды WER
Авторы
👤 Студентка [Твоё имя]
📘 Учебный проект по курсу [название дисциплины]
