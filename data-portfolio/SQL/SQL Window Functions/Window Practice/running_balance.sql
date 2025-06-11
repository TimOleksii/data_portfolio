/*
====================================================================================
Cumulative Balance Calculation with Window Functions
====================================================================================

Task:
Calculate the transaction-wise balance flow using the transactions table.

Business context:
This type of analysis is useful for tracking a user's or account's cumulative balance
over time – a common pattern in finance, loyalty systems, and internal analytics.

Columns required:
- id_transaction: transaction identifier
- summ: signed transaction amount (positive for accruals, negative for deductions)
- cumsum: cumulative total (running balance)

Rules:
- type = 0 means accrual (positive sum)
- type = 1 means deduction (negative sum)
- Sort the results by id_transaction in ascending order

====================================================================================
*/

SELECT 
    id_transaction,
    
    -- Signed transaction amount: negative for deductions
    CASE 
        WHEN type = 0 THEN sum 
        ELSE -sum 
    END AS summ,

    -- Running balance over time, ordered by transaction
    SUM(
        CASE 
            WHEN type = 0 THEN sum 
            ELSE -sum 
        END
    ) OVER (ORDER BY id_transaction) AS cumsum

FROM transactions
ORDER BY id_transaction;