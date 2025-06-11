/*
====================================================================================
Sliding Average of Transaction Totals (Accruals - Withdrawals)
====================================================================================

Business context:
To analyze the behavior of individual transactions over time, we calculate a 
transaction-level net total (accruals - withdrawals) and then compute a *sliding average* 
that smooths fluctuations by taking the average of three consecutive transactions 
(previous, current, and next).

Key rules:
- Only the field `sum` is used.
- Accruals have type = 0 → positive sum
- Withdrawals have type = 1 → negative sum
- The sliding average is calculated only when both previous and next transactions exist.

Final columns:
| id_transaction | dt (timestamp) | total (accrual - withdrawal) | sliding (avg of 3 tx) |

Sorting:
- Ordered by `id_transaction` ascending, as required.

====================================================================================
*/

WITH t AS (
    SELECT 
        id_transaction,
        MAX(date) AS dt, 
        SUM(CASE WHEN type = 0 THEN sum ELSE -sum END) AS total
    FROM transactions
    GROUP BY id_transaction
),
t1 AS (
    SELECT 
        id_transaction,
        dt,
        total,
        LAG(total) OVER (ORDER BY dt) AS lg,
        LEAD(total) OVER (ORDER BY dt) AS ld
    FROM t
)
SELECT 
    id_transaction,
    dt,
    total,
    CASE
        WHEN lg IS NULL OR ld IS NULL THEN NULL 
        ELSE ROUND((total + lg + ld) * 1.0 / 3, 2)
    END AS sliding
FROM t1
ORDER BY id_transaction;