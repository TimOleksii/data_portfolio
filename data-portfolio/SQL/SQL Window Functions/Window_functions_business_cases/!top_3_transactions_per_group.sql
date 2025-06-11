/*
====================================================================================
Top 3 Most Expensive Transactions per MCC Group (by Year)
====================================================================================

Business context:
To analyze purchasing behavior across different MCC (Merchant Category Code) groups,
we want to identify the top transactions per group per year.

Objective:
- For each MCC group and for each year (2019 and 2020), find the top 3 most expensive transactions
- If a group has fewer than 3 transactions in a year, fill the missing rows with `null`
- Output should be ordered by group name, rank, and year — all in ascending order
- Round transaction values to 2 decimal places

Final columns:
| group_name | year | rn | transaction_value |

Where:
- group_name: name of the MCC group
- year: 2019 or 2020
- rn: rank of transaction value (1 = highest)
- transaction_value: rounded to 2 decimals, or null if not enough transactions

====================================================================================
*/

WITH name AS (
    -- Join purchases with MCC codes and groups, within valid date range
    SELECT 
        transaction_date, 
        transaction_value,
        group_name 
    FROM purchases p 
    JOIN mcc_codes mc 
        ON p.mcc_code_id = mc.mcc_code_id
        AND p.transaction_date BETWEEN mc.valid_from AND mc.valid_to
    JOIN mcc_groups mg 
        ON mg.group_id = mc.group_id
),
t AS (
    -- Assign rank per year and group based on transaction value
    SELECT 
        group_name,
        transaction_date, 
        transaction_value,
        ROW_NUMBER() OVER (
            PARTITION BY TO_CHAR(transaction_date, 'YYYY'), group_name 
            ORDER BY transaction_value DESC
        ) AS rn
    FROM name
),
pre AS (
    -- Create all possible combinations of group_name, year, and rank (1–3)
    SELECT 
        year, 
        group_name,
        ROW_NUMBER() OVER (PARTITION BY year, group_name ORDER BY group_name) AS rn
    FROM mcc_groups
    CROSS JOIN generate_series(2019, 2020) AS year
    CROSS JOIN generate_series(1, 3) AS triple
)
-- Combine with actual transaction data, filling in nulls where needed
SELECT 
    p.group_name, 
    p.year, 
    p.rn, 
    ROUND(t.transaction_value, 2) AS transaction_value
FROM pre p
LEFT JOIN t 
    ON p.year = EXTRACT(YEAR FROM t.transaction_date)::int 
    AND p.group_name = t.group_name 
    AND p.rn = t.rn
ORDER BY p.group_name, p.rn, p.year;