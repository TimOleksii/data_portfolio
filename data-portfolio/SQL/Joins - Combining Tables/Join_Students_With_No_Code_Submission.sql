-- Task:
-- Find students from company with ID = 1 who never submitted 
-- any code for checking (problem-solving only, not code runs).
--
-- Return:
-- - username (login)
-- - email
-- - date_joined (as date only, no time)
--
-- This will help measure how many students are completely inactive.

SELECT 
    u.username, 
    u.email, 
    u.date_joined::date
FROM users u
LEFT JOIN codesubmit c ON u.id = c.user_id
WHERE u.company_id = 1 
  AND c.problem_id IS NULL;