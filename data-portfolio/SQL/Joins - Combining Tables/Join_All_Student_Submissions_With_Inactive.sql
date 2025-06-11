-- Task:
-- Get detailed information about how students from company with ID = 1 
-- work with coding problems — including those who never submitted anything.
--
-- Output should include:
-- - username         → user login
-- - email            → user email
-- - name             → name of the problem
-- - code             → the submitted code (if any)
-- - is_false         → whether the submission was incorrect (if any)
--
-- This helps assess overall engagement, including inactive students.

SELECT 
    u.username, 
    u.email, 
    p.name, 
    c.code, 
    c.is_false
FROM users u
LEFT JOIN codesubmit c ON c.user_id = u.id
LEFT JOIN problem p ON c.problem_id = p.id
WHERE u.company_id = 1;