-- Table structure:
-- +---------------------------------------------------------+
-- |   analysis                                              |
-- +---------------------------------------------------------+
-- |   id_an        - analysis ID (PK)                       |
-- |   name         - analysis name                          |
-- |   id_type      - type ID (FK - types_an.id_type)        |
-- |   preanalysis  - if special preanalysis is required     |
-- |   id_cat_an    - category ID                            |
-- |   cost_price   - cost price                             |
-- |   selling_price- selling price                          |
-- |   term         - temperature mode                       |
-- |   info         - additional info                        |
-- +---------------------------------------------------------+

-- +---------------------------------------+
-- |   types_an                            |
-- +---------------------------------------+
-- |   id_type     - type ID (PK)          |
-- |   name        - type name             |
-- |   description - type description      |
-- +---------------------------------------+

-- Task:
-- From the types used in the analysis table, find the lexicographically 
-- smallest type name (case-sensitive).
--
-- Output:
-- - name (from types_an)
--
-- Only one row should be returned.
-- No specific sort order required.

SELECT 
    MIN(t.name) AS name
FROM types_an t
JOIN analysis a ON a.id_type = t.id_type;