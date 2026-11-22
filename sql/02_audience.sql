-- Этап 2. Аудитория и активность

-- 2.1 DAU, WAU, MAU
WITH ud AS (
      -- пары "пользователь - день" без повторов
      SELECT DISTINCT user_id, date(started_at) AS day
      FROM sessions_c
),
days AS (
    SELECT DISTINCT day FROM ud
)
SELECT d.day,
       COUNT(DISTINCT CASE WHEN ud.day = d.day THEN ud.user_id END) AS dau,
       COUNT(DISTINCT CASE WHEN ud.day > date(d.day, '-7 day') THEN ud.user_id END) AS wau,
       COUNT(DISTINCT ud.user_id ) AS mau
FROM days d
-- JOIN по промежутку ("скользящее окно") 30 дней от проверяемой даты
JOIN ud ON ud.day BETWEEN date(d.day, '-29 day') AND d.day
GROUP BY d.day
ORDER BY d.day

-- 2.2 Когда пользуются приложением
SELECT service,
       -- CAST - преобразование типа
       -- strftime('%w', ...) - возвращает день недели в INT, но 0 = воскресенье
       -- (+ 6) % 7 - сдвигает так, чтобы 0 - был понедельником
       -- strftime('%H', ...) - возвращает час суток
       (CAST(strftime('%w', created_at) AS INTEGER) + 6) % 7 AS dow,
       CAST(strftime('%H', created_at) AS INTEGER)           AS hour,
       COUNT(*)                                              AS orders_cnt
FROM orders_c
GROUP BY service, dow, hour;