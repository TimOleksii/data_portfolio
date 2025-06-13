/*
====================================================================================
ABC + XYZ Analysis of Product Sales
====================================================================================

Business context:
To optimize inventory management and better understand demand dynamics,
we perform a combined ABC and XYZ classification of products sold by a pharmacy chain.

ABC classification:
- Based on total sales quantity, profit, and revenue.
- Helps identify the most impactful products by sales volume and financial contribution.

XYZ classification:
- Based on sales consistency (per week) to capture demand variability.
- Products sold in at least 4 distinct weeks are analyzed for weekly demand stability.

Final output groups products as:
- A/B/C: impact tiers (high → low)
- X/Y/Z: demand predictability (stable → volatile)

Resulting table:
| product | amount_abc | profit_abc | revenue_abc | xyz_sales |

====================================================================================
*/

-- Step 1: Aggregate total quantity, profit, and revenue per product
WITH cnt_abc AS (
    SELECT 
        dr_ndrugs AS product,
        SUM(dr_kol) AS amount_abc,
        SUM(dr_kol * (dr_croz - dr_czak)) - SUM(dr_sdisc) AS profit_abc,
        SUM(dr_kol * dr_croz - dr_sdisc) AS revenue_abc
    FROM sales 
    GROUP BY dr_ndrugs
),

-- Step 2: ABC classification based on cumulative contribution
abc AS (
    SELECT 
        a.product,
        CASE 
            WHEN SUM(amount_abc) OVER (ORDER BY amount_abc DESC) / SUM(amount_abc) OVER () <= 0.8 THEN 'A'
            WHEN SUM(amount_abc) OVER (ORDER BY amount_abc DESC) / SUM(amount_abc) OVER () <= 0.95 THEN 'B'
            ELSE 'C'
        END AS amount_abc,
        CASE 
            WHEN SUM(profit_abc) OVER (ORDER BY profit_abc DESC) / SUM(profit_abc) OVER () <= 0.8 THEN 'A'
            WHEN SUM(profit_abc) OVER (ORDER BY profit_abc DESC) / SUM(profit_abc) OVER () <= 0.95 THEN 'B'
            ELSE 'C'
        END AS profit_abc,
        CASE 
            WHEN SUM(revenue_abc) OVER (ORDER BY revenue_abc DESC) / SUM(revenue_abc) OVER () <= 0.8 THEN 'A'
            WHEN SUM(revenue_abc) OVER (ORDER BY revenue_abc DESC) / SUM(revenue_abc) OVER () <= 0.95 THEN 'B'
            ELSE 'C'
        END AS revenue_abc
    FROM cnt_abc AS a
),

-- Step 3: Weekly sales count for XYZ analysis (only products with >3 distinct weeks)
weeks_cnt_xyz AS (
    SELECT 
        dr_ndrugs AS product,
        TO_CHAR(dr_dat, 'YYYY-WW') AS week,
        SUM(dr_kol) AS cnt
    FROM sales
    WHERE dr_ndrugs IN (
        SELECT dr_ndrugs
        FROM sales
        GROUP BY dr_ndrugs
        HAVING COUNT(DISTINCT TO_CHAR(dr_dat, 'YYYY-WW')) > 3
    )
    GROUP BY dr_ndrugs, TO_CHAR(dr_dat, 'YYYY-WW')
),

-- Step 4: Calculate average and standard deviation of weekly sales
xyz AS (
    SELECT 
        product, 
        AVG(cnt) AS avg, 
        STDDEV_SAMP(cnt) AS std
    FROM weeks_cnt_xyz
    GROUP BY product
),

-- Step 5: Join ABC with XYZ coefficients
final AS (
    SELECT 
        a.product,
        amount_abc,
        profit_abc,
        revenue_abc,
        CASE
            WHEN x.product IS NOT NULL THEN std / avg
            ELSE NULL
        END AS coef
    FROM abc a
    LEFT JOIN xyz x ON a.product = x.product
)

-- Step 6: Final classification into X/Y/Z based on demand volatility
SELECT     
    product,
    amount_abc,
    profit_abc,
    revenue_abc,
    CASE
        WHEN coef <= 0.1 THEN 'X'
        WHEN coef <= 0.25 THEN 'Y'
        WHEN coef > 0.25 THEN 'Z'
        ELSE NULL
    END AS xyz_sales
FROM final;