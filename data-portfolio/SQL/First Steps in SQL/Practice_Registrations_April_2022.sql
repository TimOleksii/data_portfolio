-- Practice 3: User Registrations During April Campaign
--
-- Task:
-- Display full information about users who registered between 
-- April 1 and April 10, 2022 (inclusive).
--
-- This was the period of an active marketing campaign, 
-- so these users will be handled separately. We are unlikely 
-- to target them with follow-up email promotions for now.

SELECT *
FROM users
WHERE EXTRACT(DAY FROM date_joined) BETWEEN 1 AND 10
  AND EXTRACT(MONTH FROM date_joined) = 4
  AND EXTRACT(YEAR FROM date_joined) = 2022;