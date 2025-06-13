-- Task:
-- Calculate classic n-day retention (0, 1, 3, 7, 14, 30, 60, 90)
-- grouped by user cohort (month of registration) based on activity dates.

-- Business context:
-- Helps assess user engagement during early lifecycle.
-- Supports product decisions about free trial periods and subscription timing.

-- Notes:
-- - Cohorts are grouped by month of user registration (from 2022 onward)
-- - Retention is calculated as % of users active on day N
--   relative to those active on day 0
-- - Dates are calculated in true 24-hour days (not just date boundaries)
-- - The result contains one row per cohort, with percentage columns for each N

WITH diff AS (
    SELECT 
        TO_CHAR(u.date_joined, 'YYYY-MM') AS cohort,
        DATE(e.entry_at) AS entry_at,
        DATE(u.date_joined) AS date_joined,
        e.user_id,
        EXTRACT(DAYS FROM e.entry_at - u.date_joined) AS diff
    FROM userentry e
    JOIN users u ON e.user_id = u.id
    WHERE TO_CHAR(u.date_joined, 'YYYY') = '2022'
)
SELECT
    cohort,
    ROUND(COUNT(DISTINCT CASE WHEN diff = 0 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff = 0 THEN user_id END), 2) AS "0 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff = 1 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff = 0 THEN user_id END), 2) AS "1 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff = 3 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff = 0 THEN user_id END), 2) AS "3 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff = 7 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff = 0 THEN user_id END), 2) AS "7 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff = 14 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff = 0 THEN user_id END), 2) AS "14 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff = 30 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff = 0 THEN user_id END), 2) AS "30 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff = 60 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff = 0 THEN user_id END), 2) AS "60 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff = 90 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff = 0 THEN user_id END), 2) AS "90 (%)"
FROM diff
GROUP BY cohort
ORDER BY cohort;