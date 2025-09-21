"""
Заготовка: сбор бенчмарков/лидербордов (WER/CER).
"""
from typing import List, Dict

def collect_benchmarks() -> List[Dict]:
    return [
        {"system": "Whisper", "dataset": "LibriSpeech test-clean", "metric": "WER", "value": 3.6},
        {"system": "wav2vec 2.0", "dataset": "LibriSpeech test-other", "metric": "WER", "value": 6.1},
    ]

if __name__ == "__main__":
    for b in collect_benchmarks():
        print(b)
