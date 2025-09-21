"""
Заготовка: сбор ссылок на статьи и кратких описаний архитектур.
"""
from typing import List, Dict

def collect_papers() -> List[Dict]:
    return [
        {"title": "Deep Speech 2", "year": 2016, "algorithms": ["RNN","CTC"]},
        {"title": "Attention Is All You Need", "year": 2017, "algorithms": ["Transformer"]},
    ]

if __name__ == "__main__":
    for p in collect_papers():
        print(p)
