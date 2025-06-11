-- Task:
-- Display total accruals grouped by employee and discount value,
-- based on the transactions table.

-- Output columns:
-- - employee
-- - value (discount value from the discounts table)
-- - accruals (calculated total of accruals)

-- Only transactions of type = 0 (Accrual) should be included.

-- Sorting:
-- Sort by employee (ascending), then by accruals (descending).

-- Additional table used:

-- +------------------------------+
-- | discounts                    |
-- +------------------------------+
-- | id    - discount ID (PK)     |
-- | value - discount value       |
-- +------------------------------+

-- Sample values from discounts:
-- id (UUID)                              | value
-- ------------------------------------- | ------
-- e5701814-e943-4a82-9091-457a2de9eed0  | 3
-- 71eaa6f7-848c-467c-bbca-74586bcc8dbe  | 5
-- 91c63672-f27d-46be-bdb2-f638ceb816f7  | 7
-- b7ae715f-ebbb-4fed-8dce-b132ee769fb0  | 10
-- NULL                                  | 100

SELECT 
    tr.employee, 
    d.value, 
    SUM(tr.sum) AS accruals
FROM transactions tr
JOIN discounts d ON tr.disc_id = d.id
WHERE tr.type = 0
GROUP BY tr.employee, d.value
ORDER BY tr.employee ASC, accruals DESC;