"""
Заготовка: скрейп (или ручной импорт) метаданных моделей с Hugging Face.
Интернет-запросы можно реализовать через requests к HF Hub API.
На учебных стендах можно просто вернуть подготовленные json-ы.
"""
from typing import List, Dict

def collect_hf_models() -> List[Dict]:
    # Пример фиктивных данных
    return [
        {"system": "Whisper", "developer": "OpenAI", "license": "MIT",
         "url": "https://github.com/openai/whisper", "algorithms": ["Transformer"]},
        {"system": "wav2vec 2.0", "developer": "Meta AI", "license": "MIT",
         "url": "https://github.com/pytorch/fairseq", "algorithms": ["Transformer","CTC"]},
    ]

if __name__ == "__main__":
    for row in collect_hf_models():
        print(row)
