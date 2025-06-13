-- Task:
-- Evaluate the average and median number of tasks and tests
-- that users solve or attempt on the platform.

-- Business context:
-- This analysis helps decide whether it makes sense to limit
-- the number of free tasks or tests as part of a future subscription model.

-- Output columns:
-- - problems_avg      → average number of problems attempted per user
-- - tests_avg         → average number of tests started per user
-- - problems_median   → median number of problems attempted per user
-- - tests_median      → median number of tests started per user

-- Notes:
-- - Includes only users who had at least one task or test activity
-- - Users with no activity are part of the join, but excluded from
--   average and median calculations due to NULL values
-- - Uses percentile_disc(0.5) for accurate median calculation
-- - Average values are rounded to 2 decimal places

WITH task_run AS (
    SELECT user_id, problem_id
    FROM codesubmit
    UNION ALL
    SELECT user_id, problem_id
    FROM coderun
),
cnt_task_run AS (
    SELECT user_id, COUNT(DISTINCT problem_id) AS cnt_problem
    FROM task_run
    GROUP BY user_id
),
test AS (
    SELECT user_id, COUNT(DISTINCT test_id) AS cnt_test
    FROM teststart
    GROUP BY user_id
),
final_table AS (
    SELECT 
        u.id AS user_id, 
        COALESCE(c.cnt_problem, 0) AS cnt_problem,
        COALESCE(t.cnt_test, 0) AS cnt_test
    FROM users u 
    LEFT JOIN test t ON t.user_id = u.id
    LEFT JOIN cnt_task_run c ON c.user_id = u.id
)
SELECT 
    ROUND(AVG(cnt_problem), 2) AS problems_avg, 
    ROUND(AVG(cnt_test), 2) AS tests_avg,
    PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY cnt_problem) AS problems_median,
    PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY cnt_test) AS tests_median
FROM final_table;