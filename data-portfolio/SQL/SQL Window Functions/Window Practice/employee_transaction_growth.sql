/*
====================================================================================
Calculation of Accrual Growth per Employee Transaction
====================================================================================

Business context:
To monitor how individual employees are accumulating transactions over time, 
we analyze the *growth* of accrual amounts per transaction. Each transaction is 
aggregated by exact timestamp (since multiple entries with the same datetime 
may represent one transaction with different product lines).

Key definitions:
- Only accruals (type = 0) are considered.
- Each transaction is a sum of all accruals by employee and exact datetime.
- Growth (inc) is calculated as percentage change from previous transaction:
    (current - previous) / previous
- Result is rounded to 2 decimal places.

Resulting columns:
| employee | dt (timestamp) | lg (previous sum) | sm (current sum) | inc (growth ratio) |

Sorting:
- By employee, then datetime ascending.

====================================================================================
*/

SELECT 
    t.employee,
    t.dt,
    LAG(t.sm) OVER (PARTITION BY t.employee ORDER BY t.dt) AS lg,
    t.sm,
    ROUND(t.sm * 1.0 / LAG(t.sm) OVER (PARTITION BY t.employee ORDER BY t.dt) - 1, 2) AS inc 
FROM (
    SELECT
        employee, 
        date AS dt, 
        SUM(sum) AS sm        
    FROM transactions
    WHERE type = 0  -- Only accruals
    GROUP BY employee, date
) t
ORDER BY employee, dt;