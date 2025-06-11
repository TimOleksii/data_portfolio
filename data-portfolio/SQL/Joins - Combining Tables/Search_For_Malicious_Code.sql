-- Task:
-- Detect potentially malicious code submitted by users, based on language.
--
-- For SQL submissions:
-- - look for use of keywords: drop, delete, truncate, insert, create
-- - must be followed by a space and at least one character
--
-- For Python submissions:
-- - look for use of exec or eval
-- - must be followed by optional whitespace and an opening bracket with content
--
-- Case-insensitive. Check must be precise to avoid false positives.

SELECT 
    c.code, 
    l.name
FROM codesubmit c
JOIN "language" l ON l.id = c.language_id
WHERE (
    l.name = 'SQL' AND 
    LOWER(c.code) SIMILAR TO '%(drop|delete|truncate|insert|create) _+%'
) 
OR (
    l.name = 'Python' AND 
    LOWER(c.code) SIMILAR TO '%(exec|eval)\s*\(.+%'
);