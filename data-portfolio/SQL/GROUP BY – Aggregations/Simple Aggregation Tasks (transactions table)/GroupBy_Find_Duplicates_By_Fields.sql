-- Task:
-- In the transactions table, identify a duplicate row using GROUP BY.

-- Output:
-- All fields except for 'id', which is an auto-incrementing primary key
-- and not used for comparing duplicates.

-- Two rows are considered duplicates if all fields except 'id' are equal.

-- Output columns:
-- - id_transaction
-- - card_id
-- - maincard_id
-- - date
-- - sum
-- - type
-- - employee
-- - doc_id
-- - cash_id
-- - shop_id
-- - doc_type
-- - disc_id
-- - disc_source

-- Sorting:
-- Sort by id_transaction in ascending order.

SELECT 
    id_transaction, 
    card_id, 
    maincard_id, 
    date, 
    sum, 
    type, 
    employee, 
    doc_id, 
    cash_id, 
    shop_id, 
    doc_type, 
    disc_id, 
    disc_source
FROM transactions
GROUP BY 
    id_transaction, 
    card_id, 
    maincard_id, 
    date, 
    sum, 
    type, 
    employee, 
    doc_id, 
    cash_id, 
    shop_id, 
    doc_type, 
    disc_id, 
    disc_source
HAVING COUNT(*) > 1
ORDER BY id_transaction ASC;