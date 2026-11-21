-- Этап 1.
-- Цель: Понять чему в данных можно верить до того, как считать метрики

-- 1.1 Сколько строк в каждой таблице и какой диапазон дат охватывает каждая таблица

SELECT 'sessions start' AS tbl, COUNT(*) AS rows,
MIN(started_at) AS min_date, MAX(started_at) AS max_date
FROM sessions
UNION ALL
SELECT 'sessions end', COUNT(*),
MIN(ended_at), MAX(ended_at)
FROM sessions
UNION ALL
SELECT 'orders create', COUNT(*),
MIN(created_at), MAX(created_at)
FROM orders
UNION ALL
SELECT 'screen_views enter', COUNT(*),
MIN(entered_at), MAX(entered_at)
FROM screen_views
UNION ALL
SELECT 'users registrate', COUNT(*),
MIN(registered_at), MAX(registered_at)
FROM users
UNION ALL
SELECT 'devices first seen', COUNT(*),
MIN(first_seen_at), MAX(first_seen_at)
FROM devices
UNION ALL
SELECT 'app_releases release', COUNT(*),
MIN(released_at), MAX(released_at)
FROM app_releases
UNION ALL
SELECT 'ab_assignments assign', COUNT(*),
MIN(assigned_at), MAX(assigned_at)
FROM ab_assignments
UNION ALL
SELECT 'events client', COUNT(*),
MIN(client_ts), MAX(client_ts)
FROM events
UNION ALL
SELECT 'events server', COUNT(*),
MIN(server_ts), MAX(server_ts)
FROM events
UNION ALL
SELECT 'screens info', COUNT(*),
NULL, NULL
FROM screens;

-- 1.2 Поиск всех строк, где есть NULL и их процентное соотношение

WITH nulls AS (
      SELECT 'users' AS table_name, 'city' AS column_name,
             ROUND(AVG(city IS NULL) * 100, 1) AS null_pct
      FROM users
      UNION ALL
      SELECT 'users', 'registered_at',
             ROUND(AVG(registered_at IS NULL) * 100, 1)
      FROM users
      UNION ALL
      SELECT 'users', 'birth_year',
             ROUND(AVG(birth_year IS NULL) * 100, 1)
      FROM users
      UNION ALL
      SELECT 'users', 'acquisition_channel',
             ROUND(AVG(acquisition_channel IS NULL) * 100, 1)
      FROM users
      UNION ALL
      SELECT 'devices', 'user_id',
             ROUND(AVG(user_id IS NULL) * 100, 1)
      FROM devices
      UNION ALL
      SELECT 'devices', 'platform',
             ROUND(AVG(platform IS NULL) * 100, 1)
      FROM devices
      UNION ALL
      SELECT 'devices', 'device_model',
             ROUND(AVG(device_model IS NULL) * 100, 1)
      FROM devices
      UNION ALL
      SELECT 'devices', 'os_version',
             ROUND(AVG(os_version IS NULL) * 100, 1)
      FROM devices
      UNION ALL
      SELECT 'sessions', 'user_id',
             ROUND(AVG(user_id IS NULL) * 100, 1)
      FROM sessions
      UNION ALL
      SELECT 'sessions', 'device_id',
             ROUND(AVG(device_id IS NULL) * 100, 1)
      FROM sessions
      UNION ALL
      SELECT 'sessions', 'started_at',
             ROUND(AVG(started_at IS NULL) * 100, 1)
      FROM sessions
      UNION ALL
      SELECT 'sessions', 'ended_at',
             ROUND(AVG(ended_at IS NULL) * 100, 1)
      FROM sessions
      UNION ALL
      SELECT 'sessions', 'app_version',
             ROUND(AVG(app_version IS NULL) * 100, 1)
      FROM sessions
      UNION ALL
      SELECT 'sessions', 'network_type',
             ROUND(AVG(network_type IS NULL) * 100, 1)
      FROM sessions
      UNION ALL
      SELECT 'screen_views', 'session_id',
             ROUND(AVG(session_id IS NULL) * 100, 1)
      FROM screen_views
      UNION ALL
      SELECT 'screen_views', 'screen_name',
             ROUND(AVG(screen_name IS NULL) * 100, 1)
      FROM screen_views
      UNION ALL
      SELECT 'screen_views', 'entered_at',
             ROUND(AVG(entered_at IS NULL) * 100, 1)
      FROM screen_views
      UNION ALL
      SELECT 'screen_views', 'duration_ms',
             ROUND(AVG(duration_ms IS NULL) * 100, 1)
      FROM screen_views
      UNION ALL
      SELECT 'events', 'session_id',
             ROUND(AVG(session_id IS NULL) * 100, 1)
      FROM events
      UNION ALL
      SELECT 'events', 'user_id',
             ROUND(AVG(user_id IS NULL) * 100, 1)
      FROM events
      UNION ALL
      SELECT 'events', 'client_ts',
             ROUND(AVG(client_ts IS NULL) * 100, 1)
      FROM events
      UNION ALL
      SELECT 'events', 'server_ts',
             ROUND(AVG(server_ts IS NULL) * 100, 1)
      FROM events
      UNION ALL
      SELECT 'events', 'event_name',
             ROUND(AVG(event_name IS NULL) * 100, 1)
      FROM events
      UNION ALL
      SELECT 'events', 'screen_name',
             ROUND(AVG(screen_name IS NULL) * 100, 1)
      FROM events
      UNION ALL
      SELECT 'events', 'event_params',
             ROUND(AVG(event_params IS NULL) * 100, 1)
      FROM events
      UNION ALL
      SELECT 'orders', 'service',
             ROUND(AVG(service IS NULL) * 100, 1)
      FROM orders
      UNION ALL
      SELECT 'orders', 'tariff',
             ROUND(AVG(tariff IS NULL) * 100, 1)
      FROM orders
      UNION ALL
      SELECT 'orders', 'status',
             ROUND(AVG(status IS NULL) * 100, 1)
      FROM orders
      UNION ALL
      SELECT 'orders', 'price_uzs',
             ROUND(AVG(price_uzs IS NULL) * 100, 1)
      FROM orders
      UNION ALL
      SELECT 'orders', 'wait_time_sec',
             ROUND(AVG(wait_time_sec IS NULL) * 100, 1)
      FROM orders
      UNION ALL
      SELECT 'orders', 'rating',
             ROUND(AVG(rating IS NULL) * 100, 1)
      FROM orders
      UNION ALL
      SELECT 'orders', 'promo_applied',
             ROUND(AVG(promo_applied IS NULL) * 100, 1)
      FROM orders
      UNION ALL
      SELECT 'ab_assignments', 'variant',
             ROUND(AVG(variant IS NULL) * 100, 1)
      FROM ab_assignments
      UNION ALL
      SELECT 'ab_assignments', 'assigned_at',
             ROUND(AVG(assigned_at IS NULL) * 100, 1)
      FROM ab_assignments
      UNION ALL
      SELECT 'app_releases', 'released_at',
             ROUND(AVG(released_at IS NULL) * 100, 1)
      FROM app_releases
      UNION ALL
      SELECT 'app_releases', 'notes',
             ROUND(AVG(notes IS NULL) * 100, 1)
      FROM app_releases
      UNION ALL
      SELECT 'screens', 'service',
             ROUND(AVG(service IS NULL) * 100, 1)
      FROM screens
      UNION ALL
      SELECT 'screens', 'description',
             ROUND(AVG(description IS NULL) * 100, 1)
      FROM screens
)
SELECT table_name, column_name, null_pct
FROM nulls
WHERE null_pct > 0
ORDER BY table_name, null_pct DESC;

-- Анализ пропусков по events.event_params
WITH events_params_null AS (
      SELECT ev.event_name AS event_name,
            COUNT(*) AS event_count,
            ROUND(AVG(ev.event_params IS NULL) * 100, 1) AS params_null_pct
      FROM events ev
      GROUP BY ev.event_name
)
SELECT event_name, event_count, params_null_pct
FROM events_params_null
WHERE params_null_pct > 0
ORDER BY params_null_pct DESC;

-- Анализ пропусков по events.event_screens
WITH events_screen_null AS (
      SELECT ev.event_name AS event_name,
            COUNT(*) AS event_count,
            ROUND(AVG(ev.screen_name IS NULL) * 100, 1) AS screen_null_pct
      FROM events ev
      GROUP BY ev.event_name
)
SELECT event_name, event_count, screen_null_pct
FROM events_screen_null
WHERE screen_null_pct > 0
ORDER BY screen_null_pct DESC;

-- Анализ пропусков по orders
SELECT o.service,
       o.status,
       COUNT(*) AS orders_cnt,
       ROUND(AVG(o.tariff IS NULL) * 100, 1)        AS tariff_null_pct,
       ROUND(AVG(o.wait_time_sec IS NULL) * 100, 1) AS wait_null_pct,
       ROUND(AVG(o.rating IS NULL) * 100, 1)        AS rating_null_pct
FROM orders AS o
GROUP BY o.service, o.status
ORDER BY o.service, o.status;

-- Анализ оставшихся пропусков

SELECT
      (SELECT ROUND(AVG(birth_year IS NULL) * 100, 1) FROM users)
        AS user_birth_year_null,
      (SELECT ROUND(AVG(ended_at IS NULL) * 100, 1) FROM sessions)
        AS sessions_ended_at_null,
      (SELECT ROUND(AVG(user_id IS NULL) * 100, 1) FROM events)
        AS events_user_id_null,
      (SELECT ROUND(AVG(price_uzs IS NULL) * 100, 1) FROM orders)
        AS orders_price_uzs_null,
      (SELECT ROUND(AVG(price_uzs IS NULL) * 100, 1) FROM orders WHERE status = 'completed')
        AS completed_price_uzs_null;

-- 1.3 Проверка связности таблиц

-- использую LEFT JOIN, так как он сохраняет все строки левой таблицы,
-- если пары нет - будет NULL
SELECT
      -- заказы без сессии:
      (SELECT COUNT(*)
      FROM orders o
      LEFT JOIN sessions s ON s.session_id = o.session_id
      WHERE s.session_id IS NULL) AS orders_without_sessions,
      -- сессии без пользователя:
      (SELECT COUNT(*)
      FROM sessions s
      LEFT JOIN users u ON u.user_id = s.user_id
      WHERE u.user_id IS NULL) AS sessions_without_user,
      -- события без сессии:
      (SELECT COUNT(*)
      FROM events e
      LEFT JOIN sessions s ON s.session_id = e.session_id
      WHERE s.session_id IS NULL) AS events_without_sessions,
      -- просмотры экранов без сессии:
      (SELECT COUNT(*)
      FROM screen_views sv
      LEFT JOIN sessions s ON s.session_id = sv.session_id
      WHERE s.session_id IS NULL) AS screen_views_without_sessions,
      -- пользователи без устройств
      (SELECT COUNT(*)
      FROM users u
      LEFT JOIN devices d ON d.user_id = u.user_id
      WHERE d.user_id IS NULL) AS users_without_devices;

-- 1.4 Дубликаты событий
-- поиск по группам событий
SELECT
       COUNT(*) AS dup_groups,
       SUM(n - 1) AS extra_rows,
       ROUND(100.0 * SUM(n - 1) / (SELECT COUNT(*) FROM events), 2) AS extra_pct
FROM (
      SELECT event_name, COUNT(*) AS n
      FROM events
      GROUP BY session_id, event_name, client_ts, COALESCE(event_params, '')
      HAVING COUNT(*) > 1
      )

-- поиск и группировка по именам событий
SELECT d.event_name,
       COUNT(*) AS dup_groups,
       SUM(n - 1) AS extra_rows,
       ROUND(100.0 * SUM(n - 1) / (SELECT COUNT(*) FROM events), 2) AS extra_pct
FROM (
      SELECT event_name, COUNT(*) AS n
      FROM events
      GROUP BY session_id, event_name, client_ts, COALESCE(event_params, '')
      HAVING COUNT(*) > 1
      ) AS d
GROUP BY d.event_name
ORDER BY extra_rows DESC;

-- 1.5 Время телефона против времени сервера

-- julianday() - превращает дату в число дней
SELECT device_id,
       AVG(julianday(server_ts) - julianday(client_ts)) AS avg_diff_days
FROM events
GROUP BY device_id;

WITH device_diff AS (
      SELECT device_id,
             AVG(julianday(server_ts) - julianday(client_ts)) AS avg_diff_days
      FROM events
      GROUP BY device_id
)
SELECT COUNT(*) AS bugged_devices,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM device_diff), 2) AS bad_pct,
       ROUND(MIN(ABS(avg_diff_days)), 0) AS min_days,
       ROUND(MAX(ABS(avg_diff_days)), 0) AS max_days,
       SUM(avg_diff_days < 0)            AS clock_faster,
       SUM(avg_diff_days > 0)            AS clock_slower
FROM device_diff
WHERE ABS(avg_diff_days) > 1;

-- 1.6 Невозможная длительность экранов
SELECT
      SUM(duration_ms < 0)          AS negative,
      SUM(duration_ms > 86400000)   AS over_24h,
      MAX(duration_ms) / 3600000.0    AS max_hours
FROM screen_views;

-- 1.7 Справочные поля и аномальные пользователи

-- 1.7.a Справочные поля: город, год рождения, канал привлечения
SELECT 'city' AS field, city AS value, COUNT(*) AS users_cnt
FROM users
GROUP BY city
UNION ALL
SELECT 'channel', acquisition_channel, COUNT(*)
FROM users
GROUP BY acquisition_channel
ORDER BY field, users_cnt DESC;

SELECT birth_year, COUNT(*) as users_cnt
FROM users
WHERE birth_year < 1930 OR birth_year > 2012
GROUP BY birth_year;

-- 1.7.b Аномальные пользователи
SELECT s.user_id, u.acquisition_channel, d.device_model,
       COUNT(*) AS sessions_cnt,
       COUNT(DISTINCT date(s.started_at, '+5 hours')) AS active_days,
       (SELECT ROUND(AVG(o.status = 'cancelled_user') * 100, 1)
       FROM orders o
       WHERE o.user_id = s.user_id) AS cancelled_pct
FROM sessions s
JOIN users u ON u.user_id = s.user_id
JOIN devices d ON d.device_id = s.device_id
GROUP BY s.user_id, u.acquisition_channel, d.device_model
ORDER BY sessions_cnt DESC
LIMIT 10;

-- 1.8 Очистка данных

-- 1. Пользователи: без тестировщиков, города нормализованы, 1900 -> NULL, время UTC+5
DROP TABLE IF EXISTS temp.users_c;
CREATE TEMP TABLE users_c AS
SELECT user_id,
       datetime(registered_at, '+5 hours') AS registered_at,
       CASE
            WHEN city IN ('Ташкент', 'Tashkent', 'г. Ташкент', 'ташкент') THEN 'Ташкент'
            WHEN city IN ('Самарканд', 'Samarkand')                       THEN 'Самарканд'
            WHEN city IN ('Фергана', 'Fergana')                           THEN 'Фергана'
            WHEN city IN ('Андижан', 'Andijan')                           THEN 'Андижан'
            WHEN city IN ('Бухара', 'Bukhara')                            THEN 'Бухара'
            ELSE city
       END AS city,
       CASE
            WHEN birth_year BETWEEN 1930 AND 2012 THEN birth_year
       END AS birth_year,
       acquisition_channel AS channel
FROM users
WHERE acquisition_channel <> 'internal_qa';

-- 2. Устройства только "чистых" пользователей
DROP TABLE IF EXISTS temp.devices_c;
CREATE TEMP TABLE devices_c AS
SELECT device_id, d.user_id, d.platform, d.device_model, d.os_version,
       datetime(d.first_seen_at, '+5 hours') AS first_seen_at
FROM devices d
WHERE d.user_id IN (SELECT user_id FROM users_c);

-- 3. Сессии: время UTC+5, оборванные (ended_at = NULL) оставляю
DROP TABLE IF EXISTS temp.sessions_c;
CREATE TEMP TABLE sessions_c AS
SELECT s.session_id, s.user_id, s.device_id,
       datetime(s.started_at, '+5 hours') AS started_at,
       datetime(s.ended_at, '+5 hours') AS ended_at,
       s.app_version, s.network_type
FROM sessions s
WHERE s.user_id IN (SELECT user_id FROM users_c);

-- создаю индекс, то есть "оглавление" для быстрого поиска по колонке `session_id`
 CREATE INDEX temp.ix_sessions_c_session ON sessions_c(session_id);

 -- 4. Просмотры экранов: невозможная длительность -> NULL, строки сохраняю
 DROP TABLE IF EXISTS temp.screen_views_c;
 CREATE TEMP TABLE screen_views_c AS
 SELECT sv.view_id, sv.session_id, sv.screen_name,
        datetime(sv.entered_at, '+5 hours') AS entered_at,
        CASE
            WHEN sv.duration_ms BETWEEN 0 AND 86400000 THEN sv.duration_ms
        END AS duration_ms
 FROM screen_views sv
 WHERE sv.session_id IN (SELECT session_id FROM sessions_c);
 CREATE INDEX temp.ix_screen_views_c_session ON screen_views_c(session_id);

 -- 5. События: без дублей, время сервера (не телефона), UTC+5
 DROP TABLE IF EXISTS temp.events_c;
 CREATE TEMP TABLE events_c AS
 SELECT event_id, session_id, user_id, device_id,
        datetime(server_ts, '+5 hours') AS event_ts,
        event_name, screen_name, event_params
 FROM(
      SELECT e.*,
             ROW_NUMBER() OVER (
                  PARTITION BY e.session_id, e.event_name, e.client_ts,
                  COALESCE(e.event_params, '')
                  ORDER BY e.server_ts, e.event_id
             ) AS rn
      FROM events e
 ) AS numbered
 WHERE rn = 1 AND session_id IN (SELECT session_id FROM sessions_c);
 CREATE INDEX temp.ix_events_c_session ON events_c(session_id);

 -- 6. Заказы "чистых" сессий, UTC+5
 DROP TABLE IF EXISTS temp.orders_c;
 CREATE TEMP TABLE orders_c AS
 SELECT o.order_id, o.user_id, o.session_id, o.service, o.tariff,
       datetime(o.created_at, '+5 hours') AS created_at,
       o.status, o.price_uzs, o.distance_km, o.wait_time_sec,
       o.payment_method, o.promo_applied, o.rating
FROM orders o
WHERE o.session_id IN (SELECT session_id FROM sessions_c);

-- 7. A/B-назначения без тестировщиков, UTC+5
DROP TABLE IF EXISTS temp.ab_c;
CREATE TEMP TABLE ab_c AS
SELECT a.user_id, a.experiment, a.variant,
       datetime(a.assigned_at, '+5 hours') AS assigned_at
FROM ab_assignments a
WHERE a.user_id IN (SELECT user_id FROM users_c);

-- Вывод таблицы сравнения после очистки данных
SELECT 'users'                    AS tbl,
(SELECT COUNT(*) FROM users)      AS before_cnt,
(SELECT COUNT(*) FROM users_c)    AS after_cnt
UNION ALL
SELECT 'sessions',
(SELECT COUNT(*) FROM sessions),
(SELECT COUNT(*) FROM sessions_c)
UNION ALL
SELECT 'events',
(SELECT COUNT(*) FROM events),
(SELECT COUNT(*) FROM events_c)
UNION ALL
SELECT 'orders',
(SELECT COUNT(*) FROM orders),
(SELECT COUNT(*) FROM orders_c)
UNION ALL
SELECT 'screen_views',
(SELECT COUNT(*) FROM screen_views),
(SELECT COUNT(*) FROM screen_views_c)
