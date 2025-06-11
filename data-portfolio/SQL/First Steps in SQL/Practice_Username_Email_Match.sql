-- Practice: Check if Username Matches Email Prefix
--
-- Task:
-- In many projects, users sometimes leave fake or incorrect email addresses, 
-- making it difficult to contact them. 
-- We want to test a hypothesis: how often does the username match 
-- the beginning of the email (before the "@" symbol)?
--
-- Write a query that:
-- - extracts the part of the email before "@"
-- - compares it with the username (case-insensitive)
--
-- The output should include:
-- - username
-- - email
-- - email_trunc (email prefix before @)
-- - isEqual (true/false if username matches email prefix)

SELECT 
    username, 
    email,
    SPLIT_PART(email, '@', 1) AS email_trunc,
    CASE
        WHEN LOWER(username) = LOWER(SPLIT_PART(email, '@', 1)) THEN true
        ELSE false
    END AS isEqual
FROM users;