/*
====================================================================================
DAU (Daily Active Users) Dynamics with Smoothing
====================================================================================

Business context:
Understanding the number of daily active users (DAU) is crucial for evaluating
platform engagement. However, single-day fluctuations may obscure meaningful trends.

Objective:
- Calculate DAU for every day in 2022 (based on `userentry` events)
- Apply smoothing to the DAU metric to make trends more visible:
    - Sliding average: running average of DAU including current and previous days
    - Sliding median: running median of DAU including current and previous days

Smoothing helps detect overall trends and filter out short-term noise.

Final columns:
| ymd            | cnt | sliding_average | sliding_median |

Where:
- ymd: the date in 'YYYY-MM-DD' text format
- cnt: DAU (number of unique users on that day)
- sliding_average: average DAU up to and including this date
- sliding_median: median DAU up to and including this date

====================================================================================
*/

WITH cnt AS (
    -- Calculate DAU for each day in 2022
    SELECT 
        TO_CHAR(entry_at, 'YYYY-MM-DD') AS dt,
        COUNT(DISTINCT user_id) AS cnt
    FROM userentry
    WHERE TO_CHAR(entry_at, 'YYYY') = '2022'
    GROUP BY dt
    ORDER BY dt
)
SELECT
    c.dt AS ymd,
    c.cnt,
    -- Sliding average: mean of cnt values from the beginning to the current date
    AVG(cnt) OVER (ORDER BY dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sliding_average,
    
    -- Sliding median: median of cnt values from the beginning to the current date
    (
        SELECT 
            PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY c2.cnt)
        FROM cnt c2
        WHERE c2.dt <= c.dt
    ) AS sliding_median
FROM cnt c;