/*
====================================================================================
Cumulative Unique Active Users Over Time
====================================================================================

Business context:
While registrations are important, we also want to analyze real platform usage.
Some users register but never engage. Others may be very active.
To get a clearer picture of user adoption, we track the *first day of actual activity* 
(i.e., solving or submitting a task).

Objective:
- Merge activity data from 'coderun' and 'codesubmit' tables
- Track how many unique users became active up to each day (cumulatively)
- Only count a user once, on the date of their first activity

Final columns:
| dt        | unique_cnt |

Where:
- dt: date when users became active
- unique_cnt: number of unique users who became active from 01.01.2022 up to and including this day

====================================================================================
*/

WITH merge AS (
    -- Combine all user activity from both coderun and codesubmit
    SELECT created_at, user_id FROM coderun
    UNION ALL
    SELECT created_at, user_id FROM codesubmit
),
merge_unique AS (
    -- Get each user's first activity date, starting from 01.01.2022
    SELECT 
        MIN(created_at)::date AS dt,
        user_id
    FROM merge
    WHERE created_at::date >= DATE '2022-01-01'
    GROUP BY user_id
),
final_table AS (
    -- Count how many users became active for the first time on each date
    SELECT 
        dt,
        COUNT(user_id) AS cnt
    FROM merge_unique
    GROUP BY dt
)
-- Compute running total of unique active users over time
SELECT
    dt AS ymd,
    SUM(cnt) OVER (ORDER BY dt) AS unique_cnt
FROM final_table
ORDER BY dt;