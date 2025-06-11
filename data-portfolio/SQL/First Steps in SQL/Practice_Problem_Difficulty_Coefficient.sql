-- Practice: Task Difficulty Coefficient
--
-- Task:
-- In the "problem" table, calculate how the task's complexity relates 
-- to the bonus awarded for solving it.
--
-- The output should include:
-- - id of the task
-- - coef: complexity divided by bonus, rounded to 2 decimal places
--
-- If the bonus is 0, return NULL instead of a coefficient.

SELECT 
    id, 
    ROUND(complexity * 1.0 / NULLIF(bonus, 0), 2) AS coef
FROM problem;