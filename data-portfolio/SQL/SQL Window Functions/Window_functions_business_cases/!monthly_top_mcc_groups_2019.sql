/*
====================================================================================
Top MCC Groups by Transaction Sum (Monthly, 2019)
====================================================================================

Business context:
We want to understand which MCC groups dominate monthly user spending. This helps 
identify seasonal leaders and outliers by comparing them to the next best group.

Objective:
- For each month of 2019, determine the MCC group with the highest total transaction value
- Also calculate:
    - `abs_diff`: absolute difference in total spend between 1st and 2nd place
    - `rel_diff`: relative difference as a ratio between 1st and 2nd place
- If a month has no transactions: return nulls for all fields except `month`
- If a month has only 1 group: `abs_diff` and `rel_diff` = null
- If groups are tied by amount: sort alphabetically by group_name

Final columns:
| group_name | month | tr_sum | abs_diff | rel_diff |

All monetary values rounded to 2 decimal places. Final result ordered by month (1–12).

====================================================================================
*/

WITH rank AS (
    -- Rank MCC groups by monthly total transaction value in 2019
    SELECT 
        g.group_name,
        EXTRACT(MONTH FROM p.transaction_date) AS month,
        SUM(p.transaction_value) AS tr_sum,
        ROW_NUMBER() OVER (
            PARTITION BY EXTRACT(MONTH FROM p.transaction_date)
            ORDER BY SUM(p.transaction_value) DESC, g.group_name
        ) AS rn
    FROM purchases p
    JOIN mcc_codes c 
        ON p.mcc_code_id = c.mcc_code_id 
        AND p.transaction_date BETWEEN c.valid_from AND c.valid_to
    JOIN mcc_groups g 
        ON g.group_id = c.group_id
    WHERE p.transaction_date BETWEEN DATE '2019-01-01' AND DATE '2019-12-31'
    GROUP BY EXTRACT(MONTH FROM p.transaction_date), g.group_name
),
top2 AS (
    -- Select top-1 and top-2 tr_sum values per month
    SELECT 
        *,
        LEAD(tr_sum) OVER (PARTITION BY month ORDER BY rn) AS ld
    FROM rank
),
calendar AS (
    -- Full calendar for 12 months (even if no data)
    SELECT generate_series(1, 12) AS month
)
SELECT
    t.group_name,
    c.month,
    ROUND(t.tr_sum, 2) AS tr_sum,
    ROUND(t.tr_sum - t.ld, 2) AS abs_diff,
    ROUND(1 - t.ld * 1.0 / t.tr_sum, 2) AS rel_diff
FROM calendar c
LEFT JOIN top2 t 
    ON c.month = t.month AND t.rn = 1
ORDER BY c.month;