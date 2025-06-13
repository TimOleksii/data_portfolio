/*
====================================================================================
Daily Peak Registration Tracking (Sliding Maximum)
====================================================================================

Business context:
We want to analyze the progression of user registrations on the platform by identifying
the daily number of registrations and tracking how the daily peak changes over time.

Objective:
- Analyze a 111-day period starting from 01.01.2022 (inclusive)
- Include days with zero registrations
- For each day, compute:
    - dt: the day (timestamp without time)
    - cnt: how many users registered on that day
    - max_cnt: the cumulative maximum number of daily registrations up to that day
    - diff: the difference between today's count and the cumulative max

This helps identify days that set a new registration record and how each day compares 
to the peak performance so far.

Final columns:
| dt        | cnt | max_cnt | diff |

====================================================================================
*/

WITH t AS (
    -- Generate one row per day from 01.01.2022 to 21.04.2022 (inclusive)
    SELECT
        generate_series(
            DATE '2022-01-01',
            DATE '2022-01-01' + INTERVAL '110 days',
            INTERVAL '1 day'
        ) AS date
),
t1 AS (
    -- Count user registrations per day (including 0 for days without registrations)
    SELECT
        DATE(t.date) AS dt,
        COUNT(u.id) AS cnt
    FROM t
    LEFT JOIN users u ON DATE(u.date_joined) = t.date
    GROUP BY DATE(t.date)
)
-- Calculate the cumulative maximum and difference from current day's count
SELECT 
    dt,
    cnt,
    MAX(cnt) OVER (ORDER BY dt) AS max_cnt,
    cnt - MAX(cnt) OVER (ORDER BY dt) AS diff
FROM t1;