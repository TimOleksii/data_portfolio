-- Task:
-- Analyze total platform activity distribution by day of the week.

-- Business context:
-- Helps identify low-traffic weekdays for scheduling feature deployments.

-- Notes:
-- - Includes all actions from CodeRun, CodeSubmit, and TestStart
-- - Weekday numbering: 1 = Monday, 7 = Sunday (ISO standard)
-- - Output is grouped and sorted by weekday number

WITH activities AS (
    SELECT created_at FROM coderun
    UNION ALL
    SELECT created_at FROM codesubmit
    UNION ALL
    SELECT created_at FROM teststart
)
SELECT 
    TO_CHAR(created_at, 'ID') AS day,
    COUNT(*) AS cnt
FROM activities
GROUP BY TO_CHAR(created_at, 'ID')
ORDER BY day;