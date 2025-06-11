-- Task:
-- Generate a draft table structure for a corporate client to use as a gradebook.
--
-- The table should include:
-- - num: the month number (1 through 12)
-- - problem: the ID of the problem
--
-- This will allow them to record scores and activity for each student, 
-- for each problem, in each month.
--
-- Hint: use generate_series to produce the month numbers.

SELECT 
    num, 
    problem.id AS problem
FROM generate_series(1, 12) AS num
CROSS JOIN problem;