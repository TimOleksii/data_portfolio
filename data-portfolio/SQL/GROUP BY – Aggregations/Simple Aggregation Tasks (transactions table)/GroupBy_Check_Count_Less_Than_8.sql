-- Task:
-- Find employees with fewer than 8 unique checks,
-- based on the transactions table.

-- Output columns:
-- - employee
-- - amount (calculated number of unique checks)

-- Note:
-- A single check (doc_id) may appear in multiple rows.

-- Sort the result in descending order by amount.

SELECT 
    employee, 
    COUNT(DISTINCT doc_id) AS amount
FROM transactions
GROUP BY employee
HAVING COUNT(DISTINCT doc_id) < 8
ORDER BY amount DESC;