-- Task:
-- Return students from company with ID = 1 who submitted at least one 
-- code solution (problem check), but never started any tests.
--
-- Output columns:
-- - username (user login)
-- - email
--
-- These are task lovers who skipped test assessments.

SELECT DISTINCT 
    u.username, 
    u.email
FROM codesubmit c
JOIN users u ON c.user_id = u.id
LEFT JOIN teststart t ON t.user_id = u.id
WHERE u.company_id = 1 
  AND t.user_id IS NULL;