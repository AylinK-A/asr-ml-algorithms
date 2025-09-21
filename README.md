# ASR/TTS Системы — Сбор и Анализ Данных

![Python](https://img.shields.io/badge/Python-3.11-blue.svg)
![DB](https://img.shields.io/badge/Database-MySQL%20%7C%20SQLite-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

Проект для **сбора**, **структурирования** и **анализа** данных о системах автоматического распознавания речи (**ASR**) и синтеза речи (**TTS**).
Цель — собрать единообразную базу знаний по системам, их словарям, функциональным назначениям, метрикам качества, связанным статьям, датасетам и бенчмаркам.

---

## Содержание
- [ERD-модель](#erd-модель)
- [Структура проекта](#структура-проекта)
- [План сбора данных](#план-сбора-данных)
- [Установка и запуск](#установка-и-запуск)
- [Фаза реализации и анализа](#фаза-реализации-и-анализа)
- [Выходные файлы](#выходные-файлы)
- [Структура данных](#структура-данных)
- [Примечания](#примечания)
- [Лицензия](#лицензия)

---

## ERD-модель

> ER-диаграмма охватывает системы, типы словарей, функциональные назначения, а также дополнительные сущности для метрик, статей, датасетов и бенчмарков.


### Сущности

**Основные таблицы:**
- `systems` — ASR/TTS системы
- `vocabulary_types` — типы словарей (*малый*, *средний*, *большой*)
- `functional_purposes` — функциональные назначения (*командная*, *диктовка*, *SLU*, *диалоговая*)

**Связи (многие-ко-многим):**
- `systems` ↔ `vocabulary_types`
- `systems` ↔ `functional_purposes`

**Дополнительные таблицы:**
- `system_metrics` — метрики производительности (например, *WER*, *CER*, *MOS*)
- `system_papers` — научные статьи и ссылки на первоисточники
- `datasets` — датасеты, на которых обучались/оценивались системы
- `benchmarks` — бенчмарки и лидерборды
- `benchmark_results` — результаты систем в бенчмарках/датасетах

Подробности схемы см. в [`erd_model.md`](./erd_model.md) и [`database_schema.sql`](./database_schema.sql).

---

## Структура проекта
```bash
├── erd_model.md # ERD модель системы
├── database_schema.sql # SQL схема базы данных
├── data_collection_plan.md # План сбора данных
├── requirements.txt # Зависимости Python
├── data_collection/ # Скрипты сбора данных
│ ├── group1_huggingface_models/ # Группа 1: Модели с Hugging Face
│ │ └── huggingface_scraper.py
│ ├── group2_datasets/ # Группа 2: Датасеты
│ │ └── datasets_scraper.py
│ ├── group3_papers/ # Группа 3: Научные статьи
│ │ └── papers_scraper.py
│ └── group4_benchmarks/ # Группа 4: Бенчмарки и лидерборды
│ └── benchmarks_scraper.py
├── database_tools/ # Инструменты для работы с БД
│ ├── database_config.py # Конфигурация БД
│ ├── models.py # SQLAlchemy модели
│ ├── data_loader.py # Загрузка данных в БД
│ └── config_example.py # Пример конфигурации
├── analysis/ # Анализ данных
│ ├── data_analysis.py # Анализ и SQL запросы
│ └── interactive_analysis.ipynb # Jupyter notebook для анализа
├── visualization/ # Визуализация
│ └── visualization.py # Графики и диаграммы
├── run_analysis.py # Основной скрипт анализа
└── README.md # Этот файл
```
Скриншоты и артефакты анализа:
screenshots/
├── erd.png
├── wer_vs_year.png
├── mos_vs_year.png
├── architecture_distribution.png
├── top_developers.png
├── yearly_trends.png
└── benchmark_comparison.png

---

## План сбора данных

### Группа 1: Модели с Hugging Face
**Источники:**
- https://huggingface.co/models?pipeline_tag=automatic-speech-recognition
- https://huggingface.co/models?pipeline_tag=text-to-speech
- https://huggingface.co/models?pipeline_tag=audio-to-audio

**Собираемые данные:**
- Название модели, разработчик/организация, архитектура
- Количество скачиваний, лицензия
- Поддерживаемые языки, ссылки на статьи/коды

### Группа 2: Датасеты
**Источники:**
- https://huggingface.co/datasets
- https://openslr.org/

**Собираемые данные:**
- Название, описание, объем (часы/ГБ)
- Язык, лицензия, источник

### Группа 3: Научные статьи
**Источники:**
- arXiv.org
- Google Research, Yandex Research (и др.)

**Собираемые данные:**
- Название модели, метрики (WER, MOS и т.п.)
- Ссылки на arXiv, год публикации
- Авторы, краткие результаты экспериментов

### Группа 4: Бенчмарки и лидерборды
**Источники (примеры):**
- Papers with Code / Leaderboards
- SUPERB / HEAR / VCTK и др.

**Собираемые данные:**
- Название бенчмарка, задачи, датасеты, ссылки
- Результаты: ранги, метрики (WER/MOS/…); ссылки на paper/code

Подробный чек-лист и полевая схема — в [`data_collection_plan.md`](./data_collection_plan.md).

---

## Установка и запуск

### 1) Установите зависимости
```bash
pip install -r requirements.txt
2а) Создание базы в MySQL (как у ребят)
# пример: создайте БД заранее
# mysql -u root -p -e "CREATE DATABASE asr_tts CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# примените схему
mysql -u <username> -p asr_tts < database_schema.sql
2б) Альтернатива: SQLite для локального запуска
В database_tools/database_config.py по умолчанию используется SQLite (sqlite:///./asr_tts_systems.db).
Ничего дополнительно делать не нужно — БД создастся автоматически.
Фаза реализации и анализа
После сбора данных запустите полный конвейер:
# Установка зависимостей
pip install -r requirements.txt

# Полный анализ (загрузка в БД + анализ + визуализация)
python run_analysis.py
Отдельные компоненты
Загрузка данных в базу:
cd database_tools
python data_loader.py
Анализ данных:
cd analysis
python data_analysis.py
Создание визуализаций:
cd visualization
python visualization.py
Интерактивный анализ в Jupyter:
jupyter notebook analysis/interactive_analysis.ipynb
Выходные файлы
Сбор данных:
*_data_YYYYMMDD_HHMMSS.json — сырые собранные данные
collection_summary_YYYYMMDD_HHMMSS.json — сводка по сбору
collection_log.txt — лог выполнения
Анализ и визуализация:
asr_tts_systems.db — база данных (SQLite) или данные в MySQL
wer_vs_year.png — зависимость WER от года
mos_vs_year.png — зависимость MOS от года
architecture_distribution.png — распределение архитектур
top_developers.png — топ разработчиков
yearly_trends.png — тренды по годам
interactive_wer.html — интерактивный график WER
benchmark_comparison.png — сравнение бенчмарков
analysis_log_*.txt — лог анализа
См. примеры в папке screenshots/.
Структура данных
Модели (Группа 1):
{
  "model_name": "string",
  "author_organization": "string",
  "system_type": "ASR|TTS|Audio-to-Audio",
  "architecture": "string",
  "downloads": "number",
  "languages": ["array"],
  "license": "string",
  "papers": ["array"]
}
Датасеты (Группа 2):
{
  "dataset_name": "string",
  "description": "string",
  "size_hours": "number",
  "size_gb": "number",
  "language": "string",
  "license": "string",
  "source": "huggingface|openslr"
}
Статьи (Группа 3):
{
  "paper_title": "string",
  "arxiv_link": "string",
  "publication_year": "number",
  "authors": ["array"],
  "system_type": "ASR|TTS|Voice Cloning",
  "metrics": [
    {
      "type": "WER|MOS|BLEU",
      "value": "number",
      "dataset": "string"
    }
  ]
}
Бенчмарки (Группа 4):
{
  "benchmark_name": "string",
  "tasks": ["array"],
  "dataset": "string",
  "url": "string",
  "description": "string",
  "source": "paperswithcode|superbbenchmark",
  "results": [
    {
      "model_name": "string",
      "rank": "number",
      "metrics": [
        {
          "type": "WER|MOS|BLEU",
          "value": "number",
          "dataset_split": "test|dev|validation"
        }
      ],
      "paper_link": "string",
      "code_link": "string"
    }
  ]
}
