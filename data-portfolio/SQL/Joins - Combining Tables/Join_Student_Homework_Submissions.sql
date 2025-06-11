-- Task:
-- For students from company with ID = 1, retrieve information about their
-- homework problem submissions only (problems assigned via problem_to_company).
--
-- Return the following fields:
-- - username (user login)
-- - email (user email)
-- - name (problem name)
-- - code (submitted code)
-- - is_false (whether the submission was incorrect)
--
-- Exclude users who did not submit any code.
-- Sort order is not required.

SELECT 
    u.username, 
    u.email, 
    p.name, 
    c.code, 
    c.is_false
FROM codesubmit c  
JOIN users u ON u.id = c.user_id
LEFT JOIN problem p ON c.problem_id = p.id 
JOIN problem_to_company pc ON pc.problem_id = p.id AND u.company_id = pc.company_id
WHERE u.company_id = 1;