-- Table structure:
-- +----------------------------------------------------------------------+
-- |   analysis                                                           |
-- +----------------------------------------------------------------------+
-- |   id_an        - analysis ID (PK)                                    |
-- |   name         - analysis name                                       |
-- |   id_type      - analysis type                                       |
-- |   preanalysis  - requires preanalysis                                |
-- |   id_cat_an    - category ID (FK - category_an)                      |
-- |   cost_price   - cost price                                          |
-- |   selling_price- selling price                                       |
-- |   term         - temperature mode                                    |
-- |   info         - additional info                                     |
-- +----------------------------------------------------------------------+

-- +--------------------------------------------+
-- |   clients                                  |
-- +--------------------------------------------+
-- |   id_cl     - client ID (PK)               |
-- |   fio       - full name                    |
-- |   birthday  - birth date                   |
-- |   phone     - phone number                 |
-- |   email     - email                        |
-- |   notice    - notes                        |
-- |   discount  - discount availability        |
-- +--------------------------------------------+

-- +--------------------------------------------------+
-- |   orders                                         |
-- +--------------------------------------------------+
-- |   id_orders - order ID (PK)                      |
-- |   order_num - order number                       |
-- |   order_date - date of order                     |
-- |   id_man     - employee ID                       |
-- |   id_cl      - client ID (FK - clients)          |
-- |   status     - order status                      |
-- +--------------------------------------------------+

-- +---------------------------------------------------+
-- |   orderitems                                      |
-- +---------------------------------------------------+
-- |   id_orders - order ID                            |
-- |   item_num  - item number                         |
-- |   id_an     - analysis ID (FK - analysis)         |
-- |   status    - item status                         |
-- +---------------------------------------------------+

-- +----------------------------------------------+
-- |   category_an                                |
-- +----------------------------------------------+
-- |   id_cat_an - category ID (PK)               |
-- |   name      - category name                  |
-- |   description - group description            |
-- +----------------------------------------------+

-- Task:
-- Retrieve the full names (fio) of clients who have ever ordered
-- analyses belonging to the category "Trace elements".
--
-- Output:
-- - fio (from table clients)
--
-- Sort results in ascending order by fio.

SELECT 
    fio
FROM clients c
JOIN orders o ON c.id_cl = o.id_cl
JOIN orderitems oi ON o.id_orders = oi.id_orders
JOIN analysis a ON oi.id_an = a.id_an
JOIN category_an cat ON a.id_cat_an = cat.id_cat_an
WHERE cat.name = 'Trace elements'
ORDER BY fio;