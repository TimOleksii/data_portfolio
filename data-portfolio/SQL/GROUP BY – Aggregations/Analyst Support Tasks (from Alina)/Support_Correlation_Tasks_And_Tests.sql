-- Task:
-- Calculate the correlation between the number of task activities
-- (coderun + codesubmit) and test activities (teststart)
-- per day.

-- Output:
-- - cnt_corr → correlation coefficient between task count and test count
--   (rounded to 2 decimal places)

-- Notes:
-- - If there were only tasks or only tests on a given day,
--   the missing value should be treated as 0.
-- - coderun and codesubmit represent tasks (joined via UNION ALL).
-- - Dates must be aligned using FULL OUTER JOIN.

WITH all_task AS (
    SELECT 
        created_at::date AS date, 
        COUNT(*) AS task_cnt
    FROM (
        SELECT created_at FROM coderun
        UNION ALL 
        SELECT created_at FROM codesubmit
    ) AS run_submit
    GROUP BY created_at::date
),   
all_test AS (
    SELECT 
        created_at::date AS date, 
        COUNT(*) AS test_cnt
    FROM teststart 
    GROUP BY created_at::date
),    
final_table AS (
    SELECT 
        COALESCE(all_task.date, all_test.date) AS date, 
        COALESCE(task_cnt, 0) AS task_cnt, 
        COALESCE(test_cnt, 0) AS test_cnt
    FROM all_task 
    FULL OUTER JOIN all_test ON all_task.date = all_test.date
)
SELECT 
    ROUND(CORR(task_cnt, test_cnt)::numeric, 2) AS cnt_corr 
FROM final_table;