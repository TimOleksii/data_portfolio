-- Practice: Filter Users by Company
--
-- Task:
-- Write a query that displays:
-- - username
-- - registration date formatted as DD.MM.YYYY (e.g. 25.12.2020)
--
-- Only include users whose company ID is not equal to 2.
-- Users with no company (NULL) should also be included.

SELECT 
    username,
    TO_CHAR(date_joined, 'DD.MM.YYYY') AS date_joined
FROM users
WHERE COALESCE(company_id, -1) != 2;