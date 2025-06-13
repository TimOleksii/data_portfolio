-- Task:
-- Calculate the percentage of user sessions (daily visits)
-- that had no activity on the platform.

-- Business context:
-- This metric helps assess user engagement. A high percentage of
-- inactive sessions may indicate usability issues or weak onboarding.

-- Definitions:
-- - A session is recorded in the UserEntry table (one record per user per day)
-- - Activity is defined as at least one action in:
--     CodeRun, CodeSubmit, or TestStart

-- Output:
-- - entries_without_activities → percentage of sessions without activity (0–100),
--                                rounded to 2 decimal places

WITH entry AS (
    SELECT 
        DATE(entry_at) AS date, 
        user_id 
    FROM userentry 
    GROUP BY DATE(entry_at), user_id
),
run AS (
    SELECT 
        DATE(created_at) AS date, 
        user_id 
    FROM coderun 
    GROUP BY DATE(created_at), user_id
),
submit AS (
    SELECT 
        DATE(created_at) AS date, 
        user_id 
    FROM codesubmit 
    GROUP BY DATE(created_at), user_id
),
test AS (
    SELECT 
        DATE(created_at) AS date, 
        user_id 
    FROM teststart 
    GROUP BY DATE(created_at), user_id
)
SELECT 
    ROUND(
        100.0 * SUM(CASE
            WHEN r.date IS NULL AND s.date IS NULL AND t.date IS NULL THEN 1
            ELSE 0
        END) / COUNT(e.date),
        2
    ) AS entries_without_activities
FROM entry e
LEFT JOIN run r     ON r.date = e.date AND r.user_id = e.user_id
LEFT JOIN submit s  ON s.date = e.date AND s.user_id = e.user_id
LEFT JOIN test t    ON t.date = e.date AND t.user_id = e.user_id;