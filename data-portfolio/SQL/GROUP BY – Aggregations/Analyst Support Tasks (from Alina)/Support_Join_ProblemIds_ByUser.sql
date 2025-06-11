-- Task:
-- For each user, return a string of unique problem IDs they submitted,
-- joined by the delimiter ' - ' and sorted in descending order.

-- Output columns:
-- - user_id → user identifier
-- - list    → string of problem IDs (e.g. "12 - 9 - 4")

-- The order of IDs must be from highest to lowest.
-- The delimiter must be: space-dash-space (' - ')

SELECT 
    user_id,
    ARRAY_TO_STRING(
        ARRAY_AGG(DISTINCT problem_id ORDER BY problem_id DESC),
        ' - '
    ) AS list
FROM codesubmit c
GROUP BY user_id;