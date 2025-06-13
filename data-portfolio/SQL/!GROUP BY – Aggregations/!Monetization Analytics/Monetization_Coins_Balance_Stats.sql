-- Task:
-- Analyze the average number of CodeCoins users earn, spend, and retain
-- over their full lifetime on the platform.

-- Business context:
-- This analysis helps support pricing decisions for a future subscription model.
-- By knowing how many coins are "produced" and spent on average,
-- we can determine appropriate pricing tiers and evaluate user engagement.

-- Output columns:
-- - write_off → average number of coins spent (negative values)
-- - accruals  → average number of coins earned
-- - balance   → average net difference (earned - spent)

-- Rules:
-- - Only consider transactions with value < 500
--   (ignore bulk rewards to beta testers)
-- - Ignore type_id = 30 (purchases for real money)
-- - Spend types: type_id = 1 and 23 to 28
-- - Accrual types: type_id = 2 to 22 and 29

-- All values are rounded to 2 decimal places.

WITH final_table AS (
    SELECT 
        t.user_id, 
        SUM(CASE 
            WHEN t.type_id = 1 OR t.type_id BETWEEN 23 AND 28 THEN -t.value 
        END) AS write_off,
        SUM(CASE 
            WHEN t.type_id = 29 OR t.type_id BETWEEN 2 AND 22 THEN t.value 
        END) AS accruals,
        SUM(CASE 
            WHEN t.type_id = 1 OR t.type_id BETWEEN 23 AND 28 THEN -t.value
            WHEN t.type_id = 29 OR t.type_id BETWEEN 2 AND 22 THEN t.value 
        END) AS balance
    FROM transaction t
    WHERE t.value < 500
    GROUP BY t.user_id
)
SELECT 
    ROUND(AVG(write_off), 2) AS write_off, 
    ROUND(AVG(accruals), 2) AS accruals, 
    ROUND(AVG(balance), 2) AS balance
FROM final_table;