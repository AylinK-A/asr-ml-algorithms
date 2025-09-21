
---

## database_schema.sql
```sql
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS SYSTEMS_ALGORITHMS;
DROP TABLE IF EXISTS ALGORITHM_STRUCTURAL_UNITS;
DROP TABLE IF EXISTS SYSTEMS;
DROP TABLE IF EXISTS ALGORITHMS;
DROP TABLE IF EXISTS STRUCTURAL_UNITS;

CREATE TABLE ALGORITHMS (
    id           INTEGER PRIMARY KEY,
    name         TEXT NOT NULL UNIQUE,
    era          TEXT NOT NULL CHECK (era IN ('классическая','гибридная','современная')),
    description  TEXT
);

CREATE TABLE STRUCTURAL_UNITS (
    id                  INTEGER PRIMARY KEY,
    unit                TEXT NOT NULL UNIQUE,
    considers_context   BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE SYSTEMS (
    id            INTEGER PRIMARY KEY,
    name          TEXT NOT NULL UNIQUE,
    developer     TEXT,
    release_year  INTEGER,
    license       TEXT,
    url           TEXT,
    description   TEXT
);

CREATE TABLE SYSTEMS_ALGORITHMS (
    system_id     INTEGER NOT NULL,
    algorithm_id  INTEGER NOT NULL,
    PRIMARY KEY (system_id, algorithm_id),
    FOREIGN KEY (system_id)    REFERENCES SYSTEMS(id)     ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (algorithm_id) REFERENCES ALGORITHMS(id)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ALGORITHM_STRUCTURAL_UNITS (
    algorithm_id  INTEGER NOT NULL,
    unit_id       INTEGER NOT NULL,
    PRIMARY KEY (algorithm_id, unit_id),
    FOREIGN KEY (algorithm_id) REFERENCES ALGORITHMS(id)        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (unit_id)      REFERENCES STRUCTURAL_UNITS(id)  ON DELETE CASCADE ON UPDATE CASCADE
);

-- Начальное наполнение (можно переиспользовать или импортировать через data_loader.py)
INSERT INTO STRUCTURAL_UNITS (id, unit, considers_context) VALUES
(1,'фонема',0),(2,'трифон',1),(3,'слово',0),(4,'графема',0),(5,'слог',0),(6,'морфема',0),(7,'токен',0);

INSERT INTO ALGORITHMS (id, name, era, description) VALUES
(1,'HMM','классическая','Скрытые марковские модели для речи.'),
(2,'DNN','гибридная','Глубокие нейросети для акустики/языка.'),
(3,'RNN','современная','Рекуррентные сети для последовательностей.'),
(4,'LSTM','современная','Долгая краткосрочная память (вариант RNN).'),
(5,'Transformer','современная','Архитектура внимания; параллельная обработка.'),
(6,'CTC','современная','Connectionist Temporal Classification.'),
(7,'CNN','гибридная','Свёрточные сети для спектрограмм/признаков.');

INSERT INTO SYSTEMS (id, name, developer, release_year, license, url, description) VALUES
(1,'CMU Sphinx','CMU',2006,'BSD-like','https://cmusphinx.github.io','Открытая классическая ASR.'),
(2,'Kaldi','Community',2011,'Apache-2.0','https://kaldi-asr.org','Исследовательский ASR-фреймворк.'),
(3,'DeepSpeech','Mozilla',2017,'MPL-2.0','https://github.com/mozilla/DeepSpeech','End-to-end RNN+CTC.'),
(4,'wav2vec 2.0','Meta AI',2020,'MIT','https://github.com/pytorch/fairseq','Self-supervised + Transformer.'),
(5,'Whisper','OpenAI',2022,'MIT','https://github.com/openai/whisper','End-to-end Transformer ASR.'),
(6,'Vosk','Alpha Cephei',2020,'Apache-2.0','https://alphacephei.com/vosk','Лёгкая оффлайн ASR.');

INSERT INTO ALGORITHM_STRUCTURAL_UNITS (algorithm_id, unit_id) VALUES
(1,1),(1,2),
(2,1),(2,2),
(3,3),(3,5),(3,7),
(4,3),(4,5),
(5,4),(5,7),(5,3),
(6,4),(6,1),(6,3),
(7,1),(7,4);

INSERT INTO SYSTEMS_ALGORITHMS (system_id, algorithm_id) VALUES
(1,1),
(2,1),(2,2),
(3,3),(3,6),
(4,5),(4,6),
(5,5),
(6,1),(6,2);
