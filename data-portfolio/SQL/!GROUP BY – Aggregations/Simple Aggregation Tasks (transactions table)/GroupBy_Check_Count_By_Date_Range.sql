-- Task:
-- Find the number of unique checks for each date
-- in the period from 2019-10-25 to 2019-11-02 (inclusive).

-- Output columns:
-- - date   → the date of the transaction
-- - amount → calculated number of unique checks on that date

-- Note:
-- A single check (doc_id) may appear in multiple rows of the table.

-- Sorting:
-- Sort the result by amount in descending order.

SELECT 
    DATE(date) AS date, 
    COUNT(DISTINCT tr.doc_id) AS amount
FROM transactions tr
WHERE DATE(date) BETWEEN '2019-10-25' AND '2019-11-02'
GROUP BY DATE(date)
ORDER BY amount DESC;