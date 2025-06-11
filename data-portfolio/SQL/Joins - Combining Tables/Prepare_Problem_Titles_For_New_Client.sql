-- Task:
-- Prepare task titles for a new corporate client (company_id = 11)
-- based on the task list of company_id = 3.
--
-- Rules:
-- - If a custom name already exists in problem_to_company → use it
-- - If the name is NULL → use problem.name with a "NEW!" prefix
-- - Always set company_id as 11 in the result
--
-- This result will later be used for an INSERT into problem_to_company
-- for the new client.

SELECT 
    CASE
        WHEN ptc.name IS NULL THEN 'NEW! ' || p.name 
        ELSE ptc.name
    END AS name,
    11 AS company_id
FROM problem_to_company ptc 
JOIN problem p ON ptc.problem_id = p.id
WHERE ptc.company_id = 3;