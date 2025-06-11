-- Tables structure:
-- +----------------------------------------------------------------------+
-- |   analysis                                                           |
-- +----------------------------------------------------------------------+
-- |   id_an       - analysis ID (PK)                                     |
-- |   name        - analysis name                                        |
-- |   id_type     - type of analysis                                     |
-- |   preanalysis - if special preanalysis is required                   |
-- |   id_cat_an   - category ID (FK - category_an.id_cat_an)             |
-- |   cost_price  - cost price                                           |
-- |   selling_price - retail price                                      |
-- |   term        - temperature control                                  |
-- |   info        - additional info                                      |
-- +----------------------------------------------------------------------+

-- +----------------------------------------------+
-- |   category_an                                |
-- +----------------------------------------------+
-- |   id_cat_an - category ID (PK)               |
-- |   name      - category name                  |
-- |   description - category description         |
-- +----------------------------------------------+

-- +---------------------------------------------------------+
-- |   orderitems                                            |
-- +---------------------------------------------------------+
-- |   id_orders - order ID (PK)                             |
-- |   item_num  - item number                               |
-- |   id_an     - analysis ID (FK - analysis.id_an)         |
-- |   status    - status                                    |
-- +---------------------------------------------------------+

-- Task:
-- Find the names of categories from category_an
-- that have no analyses present in orderitems (i.e. were never ordered).
--
-- Output column:
-- - name (from category_an)
--
-- Sort result by name ascending.
-- Column name must exactly match the requirement.

SELECT 
    c.name
FROM category_an c
LEFT JOIN analysis a ON c.id_cat_an = a.id_cat_an
LEFT JOIN orderitems o ON o.id_an = a.id_an
WHERE o.id_an IS NULL
ORDER BY c.name;