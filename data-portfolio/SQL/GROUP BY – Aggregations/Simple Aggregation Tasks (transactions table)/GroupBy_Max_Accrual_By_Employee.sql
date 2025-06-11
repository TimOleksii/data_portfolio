-- Task:
-- Find the employee with the highest total accrual amount
-- based on the transactions table.

-- Output columns:
-- - employee
-- - summ (calculated total accrual amount)

-- Note:
-- If multiple employees have the same maximum accrual,
-- return the one whose name comes first in lexicographic order.

-- Sorting:
-- Sort the result by summ in descending order.

-- Additional condition:
-- The transaction type is defined in the 'types' table.

-- | id | name        |
-- |----|-------------|
-- | 0  | Accrual     |
-- | 1  | Withdrawal  |

-- Only accrual transactions (id = 0) should be included in the calculation.
-- Withdrawal transactions must be excluded.

SELECT 
    tr.employee, 
    SUM(CASE 
        WHEN tr.type = 0 THEN tr.sum
        ELSE 0
    END) AS summ
FROM transactions tr
GROUP BY tr.employee
ORDER BY summ DESC, tr.employee ASC
LIMIT 1;