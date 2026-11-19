-- Этап 1.
-- Цель: Понять чему в данных можно верить до того, как считать метрики

-- 1.1 Сколько строк в каждой таблице и какой диапазон дат охватывает каждая таблица

SELECT "sessions start" AS tbl, COUNT(*) AS rows,
MIN(started_at) AS min_date, MAX(started_at) AS max_date
FROM sessions
UNION ALL
SELECT "sessions end", COUNT(*),
MIN(ended_at), MAX(ended_at)
FROM sessions
UNION ALL
SELECT "orders create", COUNT(*),
MIN(created_at), MAX(created_at)
FROM orders
UNION ALL
SELECT "screen_views enter", COUNT(*),
MIN(entered_at), MAX(entered_at)
FROM screen_views
UNION ALL
SELECT "users registrate", COUNT(*),
MIN(registered_at), MAX(registered_at)
FROM users
UNION ALL
SELECT "devices first seen", COUNT(*),
MIN(first_seen_at), MAX(first_seen_at)
FROM devices
UNION ALL
SELECT "app_releases release", COUNT(*),
MIN(released_at), MAX(released_at)
FROM app_releases
UNION ALL
SELECT "ab_assignments assign", COUNT(*),
MIN(assigned_at), MAX(assigned_at)
FROM ab_assignments
UNION ALL
SELECT "events client", COUNT(*),
MIN(client_ts), MAX(client_ts)
FROM events
UNION ALL
SELECT "events server", COUNT(*),
MIN(server_ts), MAX(server_ts)
FROM events
UNION ALL
SELECT "screens info", COUNT(*),
NULL, NULL
FROM screens;