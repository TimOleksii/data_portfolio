-- Tables structure:
-- +----------------------------------------------------------------------+
-- |   analysis                                                           |
-- +----------------------------------------------------------------------+
-- |   id_an       - analysis ID (PK)                                     |
-- |   name        - analysis name                                        |
-- |   id_type     - type of analysis                                     |
-- |   preanalysis - whether preanalysis is required                      |
-- |   id_cat_an   - category ID (FK - category_an.id_cat_an)             |
-- |   cost_price  - cost price                                           |
-- |   selling_price - selling price                                     |
-- |   term        - temperature mode                                     |
-- |   info        - additional info                                      |
-- +----------------------------------------------------------------------+

-- +----------------------------------------------+
-- |   category_an                                |
-- +----------------------------------------------+
-- |   id_cat_an   - category ID (PK)              |
-- |   name        - category name                 |
-- |   description - group description             |
-- +----------------------------------------------+

-- Task:
-- Simulate the behavior of EXCEPT using only JOIN.
--
-- Show categories (from category_an) that have no related analyses 
-- in the analysis table.
--
-- Output:
-- - id_cat_an
--
-- Sort by id_cat_an in descending order.
-- IMPORTANT: use only JOIN (no EXCEPT allowed).
-- IMPORTANT: output column name must be exactly "id_cat_an"

SELECT c.id_cat_an
FROM category_an c
LEFT JOIN analysis a ON c.id_cat_an = a.id_cat_an
WHERE a.id_cat_an IS NULL
ORDER BY c.id_cat_an DESC;