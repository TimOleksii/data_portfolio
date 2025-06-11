-- Task:
-- For users with ID > 94, calculate how many days passed from their 
-- registration date until each of their activities.
--
-- Activities include:
-- - code submission (submit)
-- - code run (run)
-- - test start (test)
--
-- Output should include:
-- - email (from users)
-- - username (from users)
-- - activity date (without time)
-- - type of activity: 'submit', 'run', or 'test'
-- - number of days since registration (date difference)
--
-- This query will be useful for future retention analysis.

SELECT 
    u.email, 
    u.username, 
    sub.created_at::date, 
    'submit' AS type,
    DATE(sub.created_at) - DATE(u.date_joined) AS diff
FROM users u
JOIN codesubmit sub ON sub.user_id = u.id
WHERE u.id > 94

UNION ALL

SELECT 
    u.email, 
    u.username, 
    c.created_at::date, 
    'run' AS type,
    DATE(c.created_at) - DATE(u.date_joined) AS diff
FROM users u
JOIN coderun c ON c.user_id = u.id
WHERE u.id > 94

UNION ALL

SELECT 
    u.email, 
    u.username, 
    t.created_at::date, 
    'test' AS type,
    DATE(t.created_at) - DATE(u.date_joined) AS diff
FROM users u
JOIN teststart t ON t.user_id = u.id
WHERE u.id > 94;