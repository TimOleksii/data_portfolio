/*
====================================================================================
Previous and Next Transaction Values within Each Document
====================================================================================

Business context:
To analyze the flow of transactions within each document (doc_id), 
we retrieve the previous and next transaction amounts for every entry.
This helps in identifying changes and spotting irregularities in transaction patterns.

Logic:
- For each row, get:
  • previous sum (lag)
  • next sum (lead)
- Calculated within each doc_id partition.
- Ordered by id (transaction sequence).

Resulting columns:
| id | doc_id | sum | ld (next sum) | lg (previous sum) |

Sorting:
- Final result sorted by id (ascending)

====================================================================================
*/

SELECT
    id,
    doc_id,
    sum,
    LEAD(sum) OVER (PARTITION BY doc_id ORDER BY id) AS ld,
    LAG(sum) OVER (PARTITION BY doc_id ORDER BY id) AS lg
FROM transactions
ORDER BY id;