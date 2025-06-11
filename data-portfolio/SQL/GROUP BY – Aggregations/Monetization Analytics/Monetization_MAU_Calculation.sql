-- Task:
-- Calculate MAU (Monthly Active Users) based on user visits recorded
-- in the UserEntry table.

-- Business context:
-- MAU is one of the core metrics for evaluating platform engagement
-- and determining the health of subscription-based models.

-- Notes:
-- - Use only months with activity on 25 or more distinct days
-- - This avoids bias from partial or inactive months
-- - Result must be a single number: the average MAU across valid months
-- - Round result to the nearest whole number

WITH groupped AS (
    SELECT
        TO_CHAR(entry_at, 'YYYY-MM') AS month,
        COUNT(DISTINCT user_id) AS cnt
    FROM userentry u
    GROUP BY TO_CHAR(entry_at, 'YYYY-MM')
    HAVING COUNT(DISTINCT TO_CHAR(entry_at, 'YYYY-MM-DD')) > 24
)
SELECT 
    ROUND(AVG(cnt), 0) AS mau
FROM groupped;