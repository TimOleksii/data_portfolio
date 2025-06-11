/*
====================================================================================
Product Co-occurrence Analysis
====================================================================================

Business context:
To identify frequently co-purchased products, we perform an association analysis 
based on receipt-level transactions in a pharmacy dataset.

This can be used to:
- Build recommendation systems ("customers who bought X also bought Y")
- Optimize product placement in stores
- Inform promotional bundling strategies

Technical description:
We extract all product pairs that were bought together in the same receipt.
Each receipt is identified uniquely by the combination of: dr_apt, dr_nchk, dr_dat.
Duplicate products per receipt are eliminated to avoid skewing the pair counts.

Final output:
| product1 | product2 | cnt |
- product1, product2: product names (dr_ndrugs) that appeared together
- cnt: number of receipts where both products co-occurred

====================================================================================
*/

WITH sales_distinct AS (
    -- Step 1: Remove duplicates of the same product in the same receipt
    SELECT DISTINCT 
        dr_ndrugs,
        dr_apt,
        dr_nchk, 
        dr_dat
    FROM sales
),

product_pairs AS (
    -- Step 2: Create all unique pairs of products in the same receipt
    SELECT 
        a.dr_ndrugs AS product1, 
        b.dr_ndrugs AS product2
    FROM sales_distinct a 
    JOIN sales_distinct b 
        ON a.dr_apt = b.dr_apt 
        AND a.dr_nchk = b.dr_nchk  
        AND a.dr_dat = b.dr_dat
        AND a.dr_ndrugs < b.dr_ndrugs  -- Ensure unique and non-self pairs
)

-- Step 3: Count how often each product pair occurs together
SELECT 
    product1, 
    product2,
    COUNT(*) AS cnt
FROM product_pairs
GROUP BY product1, product2
ORDER BY cnt DESC;