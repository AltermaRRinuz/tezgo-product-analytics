import sqlite3
from pathlib import Path
import pandas as pd

# Настройка абсолютного пути к БД
PROJECT_ROOT = Path(__file__).resolve().parent.parent  # абсолютный путь к корню проекта
DB_PATH = PROJECT_ROOT / 'data' / 'tezgo_telemetry.db'  # абсолютный путь к БД

# абсолютный путь к файлам SQL
SQL_PATH = PROJECT_ROOT / 'sql'

# Проверка на наличие БД вместо ее создания
if not DB_PATH.exists():
    raise FileNotFoundError(f'База {DB_PATH} не найдена!')

# Подключение к БД
con = sqlite3.connect(DB_PATH)

# Добавление максимального количества строк, чтобы pandas не резал данные
pd.set_option('display.max_rows', 200)


def query(sql: str) -> pd.DataFrame:
    '''
    Выполнить SQL и вернуть DataFrame
    :param sql: str
    :return: pd. DataFrame
    '''
    return pd.read_sql_query(sql, con)


def read_sql_file(file_name: str) -> str:
    return (SQL_PATH / file_name).read_text(encoding='utf-8')
