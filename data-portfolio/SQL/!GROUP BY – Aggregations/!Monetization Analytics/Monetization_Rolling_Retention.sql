-- Task:
-- Calculate rolling retention on day N (0, 1, 3, 7, 14, 30, 60, 90)
-- grouped by registration cohort (YYYY-MM).

-- Business context:
-- Rolling retention is more informative than strict N-day retention,
-- because it accounts for users who return after the exact N-th day.
-- It helps understand real user lifecycle and guides subscription planning.

-- Notes:
-- - Use cohorts based on user registration month (from 2022 only)
-- - Difference in days (diff) is calculated using full 24h periods
-- - Denominator for each row = number of users who returned on day 0 or later
-- - Numerator for day N = number of users who returned on day N or later
-- - Values are percentages rounded to 2 decimal places

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
          COUNT(DISTINCT CASE WHEN diff >= 0 THEN user_id END), 2) AS "0 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff >= 1 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff >= 0 THEN user_id END), 2) AS "1 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff >= 3 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff >= 0 THEN user_id END), 2) AS "3 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff >= 7 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff >= 0 THEN user_id END), 2) AS "7 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff >= 14 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff >= 0 THEN user_id END), 2) AS "14 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff >= 30 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff >= 0 THEN user_id END), 2) AS "30 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff >= 60 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff >= 0 THEN user_id END), 2) AS "60 (%)",
    ROUND(COUNT(DISTINCT CASE WHEN diff >= 90 THEN user_id END) * 100.0 /
          COUNT(DISTINCT CASE WHEN diff >= 0 THEN user_id END), 2) AS "90 (%)"
FROM diff
GROUP BY cohort
ORDER BY cohort;