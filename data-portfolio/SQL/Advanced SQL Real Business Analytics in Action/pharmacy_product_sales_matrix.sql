/*
====================================================================================
Full Pharmacy-Product Sales Table
====================================================================================

Business context:
To analyze overall product performance across all pharmacy branches, we build a 
comprehensive matrix of sales volumes per product per pharmacy.

This analysis helps to:
- Identify gaps in product availability or demand
- Compare branch-level sales performance for the same product
- Provide structured input for further analysis (e.g., clustering, imputation)

Technical details:
- Rows represent all combinations of pharmacies and products (even if no sales)
- If a product wasn't sold at a specific pharmacy, 'cnt' will be NULL
- Sales count is rounded to two decimal places

Final output:
| apt | drug       | cnt   |
====================================================================================
*/

WITH products AS (
    -- Unique list of products sold
    SELECT DISTINCT dr_ndrugs AS drug
    FROM sales
),

pharmacies AS (
    -- Unique list of pharmacy branches
    SELECT DISTINCT dr_apt AS apt
    FROM sales
)

-- Create full matrix of pharmacies × products, with sales if available
SELECT 
    a.apt, 
    p.drug,
    ROUND(SUM(s.dr_kol)::NUMERIC, 2) AS cnt
FROM pharmacies a
CROSS JOIN products p
LEFT JOIN sales s 
    ON s.dr_apt = a.apt AND s.dr_ndrugs = p.drug
GROUP BY a.apt, p.drug
ORDER BY a.apt, p.drug;