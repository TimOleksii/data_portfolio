-- Task:
-- Calculate the distribution of user CodeCoin balances by percentiles
-- to understand how "loaded" users are and whether many users
-- have large balances that reduce their motivation to purchase more coins.

-- Business context:
-- Users may accumulate a large balance over time through in-platform rewards.
-- If too many users have high balances, the subscription or coin package model
-- may be ineffective without stricter coin usage or expiration.

-- Output columns:
-- - perc     → percentile value (from 0.1 to 1.0)
-- - balance  → corresponding user balance at that percentile

-- Notes:
-- - Use the `transaction` table for all coin activity
-- - Types considered:
--     - Write-off types: 1, 23 to 28 (values are subtracted)
--     - Accrual types: 2 to 22, and 29 (values are added)
--     - Type 30 (real-money purchase) is ignored
-- - Ignore all transactions with value >= 500 (beta tester artifacts)
-- - Exclude users with company_id = 1 (university students)

WITH final_table AS (
    SELECT 
        t.user_id, 
        SUM(CASE 
            WHEN t.type_id = 1 OR t.type_id BETWEEN 23 AND 28 THEN -t.value
            WHEN t.type_id = 29 OR t.type_id BETWEEN 2 AND 22 THEN t.value
        END) AS balance
    FROM transaction t
    JOIN users u ON t.user_id = u.id
    WHERE t.value < 500
      AND COALESCE(u.company_id, 0) != 1
    GROUP BY t.user_id
)
SELECT 
    perc,
    PERCENTILE_DISC(perc) WITHIN GROUP (ORDER BY balance) AS balance
FROM final_table
CROSS JOIN generate_series(0.1, 1, 0.1) AS perc
GROUP BY perc;