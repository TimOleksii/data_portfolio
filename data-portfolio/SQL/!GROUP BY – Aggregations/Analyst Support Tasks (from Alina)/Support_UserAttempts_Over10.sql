-- Task:
-- Retrieve all users who performed more than 10 code check attempts
-- on the platform (from the codesubmit table).

-- Output columns:
-- - user_id → user identifier
-- - cnt     → number of check attempts

-- Only include users with more than 10 attempts.

SELECT 
    c.user_id, 
    COUNT(c.id) AS cnt
FROM codesubmit c
GROUP BY c.user_id
HAVING COUNT(c.id) > 10;