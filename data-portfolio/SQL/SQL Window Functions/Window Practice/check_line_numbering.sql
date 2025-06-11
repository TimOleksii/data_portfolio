/*
====================================================================================
Line Numbering Within Checks
====================================================================================

Task:
For each receipt (check), assign a sequential number to every transaction line
belonging to that receipt.

Business context:
In retail or transaction analysis, this helps track the order in which items 
were registered within each check and analyze transaction structure.

Required output columns:
- doc_id: receipt ID
- date: date of purchase (date only, no time)
- num: row number within each check

Sorting:
The final output should be sorted by:
1. date (ascending)
2. doc_id (ascending)
3. num (ascending)

Note:
Each doc_id (check) can correspond to multiple transaction rows.

====================================================================================
*/

SELECT 
    doc_id,
    DATE(date) AS date,
    ROW_NUMBER() OVER (PARTITION BY doc_id) AS num
FROM transactions
ORDER BY date, doc_id, num;