# ASR/TTS Системы — Сбор и Анализ Данных

Проект для сбора и структурирования данных о системах автоматического распознавания речи (ASR) и синтеза речи (TTS).

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
---

## ERD Модель

Модель включает следующие сущности:

### Основные таблицы:

- `systems` — ASR/TTS системы  
- `vocabulary_types` — типы словарей (малый, средний, большой)  
- `functional_purposes` — функциональные назначения (командная, диктовка, SLU, диалоговая)  

### Связи:

- Система ↔ Типы словарей (многие-ко-многим)  
- Система ↔ Функциональные назначения (многие-ко-многим)  

### Дополнительные таблицы:

- `system_metrics` — метрики производительности  
- `system_papers` — научные статьи  
- `datasets` — датасеты для обучения  
- `benchmarks` — бенчмарки и лидерборды  
- `benchmark_results` — результаты в бенчмарках  

---

## План сбора данных

### Группа 1: Модели с Hugging Face

**Источники:**

- https://huggingface.co/models?pipeline_tag=automatic-speech-recognition  
- https://huggingface.co/models?pipeline_tag=text-to-speech  
- https://huggingface.co/models?pipeline_tag=audio-to-audio  

**Собираемые данные:**

- Название модели, разработчик, архитектура  
- Количество скачиваний, лицензия  
- Поддерживаемые языки, ссылки на статьи  

---

### Группа 2: Датасеты

**Источники:**

- https://huggingface.co/datasets  
- https://openslr.org/  

**Собираемые данные:**

- Название, описание, объем (часы / ГБ)  
- Язык, лицензия, источник  

---

### Группа 3: Научные статьи

**Источники:**

- arXiv.org  
- Google Research, Yandex Research  

**Собираемые данные:**

- Название модели, метрики (WER, MOS)  
- Ссылки на arXiv, год публикации  
- Авторы, результаты экспериментов  

---

### Группа 4: Бенчмарки и лидерборды

**Источники:**

- Papers with Code / Leaderboards  
- SUPERB / HEAR и др.  

**Собираемые данные:**

- Название бенчмарка, задачи, датасеты, URL  
- Результаты: ранги, метрики; ссылки на paper / code  

---

## Установка и запуск

```bash
pip install -r requirements.txt
'''
Если используете MySQL
'''bash
mysql -u <username> -p < database_schema.sql
'''
Если хотите SQLite (локально)
'''bash
# настройки в database_tools/database_config.py
'''
Запуск скриптов сбора данных:
'''bash
cd data_collection/group1_huggingface_models
python huggingface_scraper.py
cd data_collection/group2_datasets
python datasets_scraper.py
cd data_collection/group3_papers
python papers_scraper.py
cd data_collection/group4_benchmarks
python benchmarks_scraper.py
'''
Фаза реализации и анализа
'''bash
pip install -r requirements.txt
python run_analysis.py
'''
Отдельные части:
'''bash
cd database_tools
python data_loader.py
cd analysis
python data_analysis.py
cd visualization
python visualization.py
jupyter notebook analysis/interactive_analysis.ipynb
'''
Выходные файлы
Сбор данных:
'''bash
*_data_YYYYMMDD_HHMMSS.json — собранные данные
collection_summary_YYYYMMDD_HHMMSS.json — сводка
collection_log.txt — лог
'''
Анализ и визуализация:
'''bash
asr_tts_systems.db — база данных (SQLite или MySQL)
wer_vs_year.png — график зависимости WER от года
mos_vs_year.png — график MOS по годам
architecture_distribution.png — распределение архитектур
top_developers.png — топ разработчиков
yearly_trends.png — тренды по годам
benchmark_comparison.png — сравнение бенчмарков
analysis_log_*.txt — лог анализа
'''
Структура данных
Модели (Группа 1):
'''bash
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
'''
Датасеты (Группа 2):
'''bash
{
  "dataset_name": "string",
  "description": "string",
  "size_hours": "number",
  "size_gb": "number",
  "language": "string",
  "license": "string",
  "source": "huggingface|openslr"
}
'''
Статьи (Группа 3):
'''bash
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
'''
Бенчмарки (Группа 4):
'''bash
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
'''
Примечания
Скрипты включают задержки между запросами, чтобы не перегружать API.
Все данные сохраняются в формате JSON с кодировкой UTF-8.
Логи пишутся в файл и в консоль; есть обработка ошибок и повторные попытки.
Лицензия
Проект создан в образовательных целях. При использовании данных соблюдайте лицензии исходных источников.
