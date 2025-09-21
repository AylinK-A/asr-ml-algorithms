-- STRUCTURAL_UNITS (7 записей)
INSERT INTO STRUCTURAL_UNITS (unit_id, unit, considers_context) VALUES
(1, 'фонема', 0),
(2, 'трифон', 1),
(3, 'слово', 0),
(4, 'графема', 0),
(5, 'слог', 0),
(6, 'морфема', 0),
(7, 'токен', 0)
ON CONFLICT(unit_id) DO NOTHING;

-- ALGORITHMS (7 записей)
INSERT INTO ALGORITHMS (algorithm_id, name, era, description) VALUES
(1, 'HMM',         'классическая', 'Скрытые марковские модели для моделирования последовательностей.'),
(2, 'DNN',         'гибридная',    'Глубокие нейросети для акустического/языкового моделирования.'),
(3, 'RNN',         'современная',  'Рекуррентные сети для последовательных данных.'),
(4, 'LSTM',        'современная',  'RNN-вариант с долгой краткосрочной памятью.'),
(5, 'Transformer', 'современная',  'Архитектура на механизме внимания.'),
(6, 'CTC',         'современная',  'Connectionist Temporal Classification для выравнивания без разметки по времени.'),
(7, 'CNN',         'гибридная',    'Свёрточные сети для извлечения признаков из акустики.')
ON CONFLICT(algorithm_id) DO NOTHING;

-- SYSTEMS (6–7 записей)
INSERT INTO SYSTEMS (system_id, name, developer, release_year, license, url, description) VALUES
(1, 'CMU Sphinx', 'CMU', 2006, 'BSD-like', 'https://cmusphinx.github.io', 'Ранняя открытая ASR-система (PocketSphinx и др.).'),
(2, 'Kaldi', 'Community', 2011, 'Apache-2.0', 'https://kaldi-asr.org', 'Исследовательский фреймворк ASR.'),
(3, 'DeepSpeech', 'Mozilla', 2017, 'MPL-2.0', 'https://github.com/mozilla/DeepSpeech', 'Энд-ту-энд ASR на RNN+CTC.'),
(4, 'wav2vec 2.0', 'Meta AI', 2020, 'MIT', 'https://github.com/pytorch/fairseq', 'Self-supervised pretraining, Transformer + CTC.'),
(5, 'Whisper', 'OpenAI', 2022, 'MIT', 'https://github.com/openai/whisper', 'Энд-ту-энд Transformer ASR.'),
(6, 'Vosk', 'Alpha Cephei', 2020, 'Apache-2.0', 'https://alphacephei.com/vosk', 'Лёгкие оффлайн модели ASR.')
ON CONFLICT(system_id) DO NOTHING;

-- Связки: ALGORITHM_STRUCTURAL_UNITS (кто с чем работает)
INSERT INTO ALGORITHM_STRUCTURAL_UNITS (algorithm_id, unit_id) VALUES
-- HMM
(1, 1), -- фонема
(1, 2), -- трифон (контекст-зависимые HMM)
-- DNN
(2, 1),
(2, 2),
-- RNN
(3, 3), -- слово
(3, 5), -- слог
(3, 7), -- токен
-- LSTM
(4, 3),
(4, 5),
-- Transformer
(5, 4), -- графема/символы
(5, 7), -- токен
(5, 3), -- слово
-- CTC
(6, 4),
(6, 1),
(6, 3),
-- CNN
(7, 1),
(7, 4)
ON CONFLICT(algorithm_id, unit_id) DO NOTHING;

-- Связки: SYSTEMS_ALGORITHMS (кто что использует)
INSERT INTO SYSTEMS_ALGORITHMS (system_id, algorithm_id) VALUES
(1, 1),         -- CMU Sphinx — HMM
(2, 1), (2, 2), -- Kaldi — HMM + DNN (гибридные акустические модели)
(3, 3), (3, 6), -- DeepSpeech — RNN + CTC
(4, 5), (4, 6), -- wav2vec 2.0 — Transformer + CTC
(5, 5), (5, 6), -- Whisper — Transformer + CTC (де-факто seq2seq без CTC, но для примера оставим)
(6, 1), (6, 2)  -- Vosk — HMM + DNN
ON CONFLICT(system_id, algorithm_id) DO NOTHING;
