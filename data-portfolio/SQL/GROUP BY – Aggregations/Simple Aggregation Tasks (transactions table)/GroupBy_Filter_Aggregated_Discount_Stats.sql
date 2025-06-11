-- Task:
-- For each client (card_id), calculate the following based on accrual transactions (type = 0):
-- - max_perc: the maximum discount percentage (from discounts.value)
-- - summ: total accrual amount (sum of transactions.sum)
-- - amount: number of purchase records (number of rows)

-- Output only those clients who meet at least one of the following conditions:
-- - max discount percentage is 7
-- - OR total accruals exceed 20 AND number of purchases is less than 5

-- Output columns:
-- - card_id
-- - max_perc
-- - summ
-- - amount

-- Sort the result by card_id in ascending order.

-- Table: discounts
-- +------------------------------+
-- | id   - discount ID (PK)      |
-- | value - discount percentage  |
-- +------------------------------+

-- Sample values:
-- id                                  | value
-- -----------------------------------|-------
-- e5701814-e943-4a82-9091-457a2de9eed0 | 3
-- 71eaa6f7-848c-467c-bbca-74586bcc8dbe | 5
-- 91c63672-f27d-46be-bdb2-f638ceb816f7 | 7
-- b7ae715f-ebbb-4fed-8dce-b132ee769fb0 | 10
-- NULL                                 | 100

SELECT 
    tr.card_id, 
    MAX(d.value) AS max_perc, 
    SUM(tr.sum) AS summ, 
    COUNT(tr.sum) AS amount
FROM transactions tr
JOIN discounts d ON tr.disc_id = d.id
WHERE tr.type = 0
GROUP BY tr.card_id
HAVING 
    max(d.value) = 7 
    OR (sum(tr.sum) > 20 AND count(tr.sum) < 5)
ORDER BY tr.card_id;