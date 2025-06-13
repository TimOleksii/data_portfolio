-- Task:
-- Analyze platform activity distribution by hour of the day.

-- Business context:
-- Helps identify low-activity time windows suitable for safe deployment
-- of platform updates or maintenance.

-- Notes:
-- - Includes all records from CodeRun, CodeSubmit, and TestStart
-- - Hours are extracted in 24-hour format (0 to 23)
-- - Output is sorted by hour in ascending order

WITH activities AS (
    SELECT created_at FROM coderun
    UNION ALL
    SELECT created_at FROM codesubmit
    UNION ALL
    SELECT created_at FROM teststart
)
SELECT 
    EXTRACT(HOUR FROM created_at) AS hour,
    COUNT(*) AS cnt
FROM activities
GROUP BY EXTRACT(HOUR FROM created_at)
ORDER BY hour;
