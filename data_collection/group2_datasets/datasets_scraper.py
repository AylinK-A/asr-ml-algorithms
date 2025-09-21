"""
Заготовка: сбор сведений о датасетах (название, язык, размер, ссылка).
Далее можно использовать для связи систем с доменами/языками (необязательно).
"""
from typing import List, Dict

def collect_datasets() -> List[Dict]:
    return [
        {"name": "LibriSpeech", "lang": "en", "url": "https://www.openslr.org/12/"},
        {"name": "Common Voice", "lang": "multi", "url": "https://commonvoice.mozilla.org/"},
    ]

if __name__ == "__main__":
    for d in collect_datasets():
        print(d)
