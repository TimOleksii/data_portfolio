-- Task:
-- Find the employees who are in 2nd and 3rd place
-- in terms of total accrual amount based on the transactions table.

-- Output columns:
-- - employee
-- - summ (calculated accrual total)

-- Only transactions with type = 0 (accruals) should be included.

-- Sorting:
-- Sort the result by summ in descending order.

-- Skip the top employee and return the next two.

SELECT 
    employee, 
    SUM(tr.sum) AS summ
FROM transactions tr
WHERE tr.type = 0
GROUP BY tr.employee
ORDER BY summ DESC
OFFSET 1
LIMIT 2;