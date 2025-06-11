-- Practice: User Classification Based on Score
-- 
-- Task:
-- The platform uses an internal classification system based on the score users earn 
-- by completing tasks. You need to write a query that returns:
-- 
-- - email
-- - score
-- - class (based on score)
--
-- The classification logic is:
-- - 0 <= score < 20     → class D
-- - 20 <= score < 100   → class C
-- - 100 <= score < 500  → class B
-- - score >= 500        → class A
--
-- This classification helps us offer personalized activities to users.

SELECT 
    email, 
    score,
    CASE
        WHEN score >= 0 AND score < 20 THEN 'D'
        WHEN score >= 20 AND score < 100 THEN 'C'
        WHEN score >= 100 AND score < 500 THEN 'B'
        ELSE 'A'
    END AS class
FROM users;