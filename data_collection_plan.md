# План сбора данных

Цель: собрать сведения об алгоритмах ASR, структурных единицах и системах:
- Алгоритмы (HMM, DNN, RNN, LSTM, Transformer, CTC, CNN): эра, описание.
- Структурные единицы (фонема, трифон, слово, графема, …): учитывает ли контекст.
- Системы: разработчик, год, лицензия, URL, какие алгоритмы используются.
- Связи: алгоритм↔структурная единица, система↔алгоритм.

## Источники и группы
1. **Hugging Face модели** — метаданные моделей ASR (pipelines, card’ы).
2. **Датасеты** — языки/домены/размеры (Common Voice, LibriSpeech и др.).
3. **Научные статьи** — архитектуры и методики (RNN/CTC, Transformer).
4. **Бенчмарки/лидерборды** — WER/CER для сравнения (Papers with Code/HEAR).

## Поля
- algorithms: name, era, description
- structural_units: unit, considers_context
- systems: name, developer, release_year, license, url, description
- links: SYSTEMS_ALGORITHMS, ALGORITHM_STRUCTURAL_UNITS

## Процесс
1. Черновой сбор (скрейперы групп).
2. Валидация (ручная проверка ключевых полей).
3. Загрузка в БД (SQLAlchemy).
4. Аналитика и визуализация (скрипты в `analysis/` и `visualization/`).
