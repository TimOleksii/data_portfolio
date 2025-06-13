-- Task:
-- Alina is trying to write a query that counts how many problems
-- each student solved correctly.
-- But her query doesn’t work — it either returns errors or gives incorrect results.

-- Here's what she wrote (incorrect logic):
-- It counts incorrect attempts instead of correct ones.

-- Alina’s original query:
-- Counts wrong submissions (is_false = 1), not correct ones.

-- SELECT
--     user_id,
--     SUM(CASE WHEN is_false = 1 THEN 1 ELSE 0) AS cnt
-- FROM codesubmit c
-- GROUP BY user_id;

-- My corrected query:
-- For each user, count how many unique problems were solved correctly (is_false = 0).
-- This includes only submissions marked as correct and ensures that each problem
-- is counted once per user — regardless of how many correct submissions they made.

-- Output:
-- - user_id → student identifier
-- - cnt     → number of correctly solved problems

SELECT
    user_id,
    COUNT(DISTINCT CASE WHEN is_false = 0 THEN problem_id END) AS cnt
FROM codesubmit c
GROUP BY user_id;