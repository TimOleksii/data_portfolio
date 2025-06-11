-- Table structure:
-- +----------------------------------------------------------------------+
-- |   analysis                                                           |
-- +----------------------------------------------------------------------+
-- |   id_an        - analysis ID (PK)                                    |
-- |   name         - analysis name                                       |
-- |   id_type      - type of analysis                                    |
-- |   preanalysis  - whether preanalysis is required                     |
-- |   id_cat_an    - category ID                                         |
-- |   cost_price   - cost price                                          |
-- |   selling_price- selling price                                       |
-- |   term         - temperature mode                                    |
-- |   info         - additional info                                     |
-- +----------------------------------------------------------------------+

-- Task:
-- Using the UNION operator, find all analyses that either:
-- - have a markup greater than 35%, OR
-- - belong to category 7
--
-- Columns required in result:
-- - name
-- - id_cat_an
-- - markup (markup percentage, rounded to 3 decimals)
--
-- Notes:
-- - Markup should be calculated as a percentage, not a fraction
-- - Use UNION or UNION ALL (duplicates should be kept)
-- - Sort results by markup in descending order

SELECT 
    name, 
    id_cat_an, 
    ROUND((selling_price - cost_price) / cost_price * 100, 3) AS markup
FROM analysis
WHERE ROUND((selling_price - cost_price) / cost_price * 100, 3) > 35

UNION ALL

SELECT 
    name, 
    id_cat_an, 
    ROUND((selling_price - cost_price) / cost_price * 100, 3) AS markup
FROM analysis
WHERE id_cat_an = 7

ORDER BY markup DESC;