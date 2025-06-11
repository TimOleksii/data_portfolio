/*
====================================================================================
Ranking Transactions by Absolute Value per Employee
====================================================================================

Business context:
To analyze employee transaction behavior, we rank each transaction (accrual or deduction)
by the absolute value of its amount. This helps identify which employees process the
largest transactions and how frequently.

Ranking logic:
- Rank is calculated per employee.
- Ranking is based on absolute value of the transaction amount (ABS(sum)), in descending order.
- Ties receive the same rank (RANK), with gaps after duplicates.

Resulting table:
| employee | type | sum  | rnk |
|----------|------|------|-----|

Sorting:
- By employee (descending)
- By rank (ascending) within each employee

====================================================================================
*/

SELECT 
    employee, 
    type, 
    sum,
    RANK() OVER (
        PARTITION BY employee 
        ORDER BY ABS(sum) DESC
    ) AS rnk
FROM transactions
ORDER BY employee DESC, rnk;