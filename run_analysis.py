"""
Пайплайн: создать/инициализировать БД, запустить анализ и визуализацию.
"""
import subprocess
import sys

def run(cmd: list[str]):
    print(">", " ".join(cmd))
    res = subprocess.run(cmd, check=True)
    return res

def main():
    # 1) Инициализация БД (через SQL)
    run([sys.executable, "-m", "database_tools.data_loader"])

    # 2) Аналитика
    run([sys.executable, "-m", "analysis.data_analysis"])

    # 3) Визуализация
    run([sys.executable, "-m", "visualization.visualization"])

if __name__ == "__main__":
    main()
