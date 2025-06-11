-- Practice: Build Email Contact List
--
-- Task:
-- Generate a list of users for email campaigns. 
-- Each user has an email, but not all have a first and/or last name.
--
-- Return two fields:
-- - email: user’s email address
-- - full_name: first_name + space + last_name (if both exist),
--              otherwise "Dear friend" (default greeting)
SELECT 
    email,
    COALESCE(first_name || ' ' || last_name, 'Dear friend') AS full_name
FROM users;