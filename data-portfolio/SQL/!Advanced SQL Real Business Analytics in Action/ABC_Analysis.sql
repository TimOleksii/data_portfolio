-- ABC Analysis

-- Task: Perform a multidimensional ABC analysis:
-- based on quantity sold
-- based on profit per product
-- based on revenue

-- Table: sales
-- dr_kol    – quantity sold per receipt line
-- dr_ndrugs – product name
-- dr_dat    – receipt date
-- dr_croz   – retail price
-- dr_czak   – purchase price
-- dr_sdisc  – discount amount per receipt line

-- Formulas:
-- revenue = quantity * retail price - discount
-- profit  = quantity * (retail - purchase) - discount

WITH abc AS (
    SELECT 
        dr_ndrugs AS product,
        SUM(dr_kol) AS amount_abc,
        SUM(dr_kol * (dr_croz - dr_czak)) - SUM(dr_sdisc) AS profit_abc,
        SUM(dr_kol * dr_croz - dr_sdisc) AS revenue_abc
    FROM sales 
    GROUP BY dr_ndrugs
)
SELECT 
    a.product,
    CASE 
        WHEN SUM(amount_abc) OVER (ORDER BY amount_abc DESC) / 
             SUM(amount_abc) OVER () <= 0.8 THEN 'A'
        WHEN SUM(amount_abc) OVER (ORDER BY amount_abc DESC) / 
             SUM(amount_abc) OVER () <= 0.95 THEN 'B' 
        ELSE 'C' 
    END AS amount_abc,
    CASE 
        WHEN SUM(profit_abc) OVER (ORDER BY profit_abc DESC) / 
             SUM(profit_abc) OVER () <= 0.8 THEN 'A' 
        WHEN SUM(profit_abc) OVER (ORDER BY profit_abc DESC) / 
             SUM(profit_abc) OVER () <= 0.95 THEN 'B' 
        ELSE 'C' 
    END AS profit_abc,
    CASE 
        WHEN SUM(revenue_abc) OVER (ORDER BY revenue_abc DESC) / 
             SUM(revenue_abc) OVER () <= 0.8 THEN 'A' 
        WHEN SUM(revenue_abc) OVER (ORDER BY revenue_abc DESC) / 
             SUM(revenue_abc) OVER () <= 0.95 THEN 'B' 
        ELSE 'C' 
    END AS revenue_abc
FROM abc AS a;