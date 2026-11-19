import sqlite3
from pathlib import Path
import pandas as pd

# Настройка абсолютного пути к БД
PROJECT_ROOT = Path(__file__).resolve().parent.parent # абсолютный путь к корню проекта
DB_PATH = PROJECT_ROOT / 'data' / 'tezgo_telemetry.db' # абсолютный путь к БД

# Проверка на наличие БД вместо ее создания
if not DB_PATH.exists():
    raise FileNotFoundError(f'База {DB_PATH} не найдена!')

# Подключение к БД
con = sqlite3.connect(DB_PATH)

def query(sql: str) -> pd.DataFrame:
    '''
    Выполнить SQL и вернуть DataFrame
    :param sql: str
    :return: pd. DataFrame
    '''
    return pd.read_sql_query(sql, con)

test = query(
    'SELECT * FROM users;'
)
print(test)
