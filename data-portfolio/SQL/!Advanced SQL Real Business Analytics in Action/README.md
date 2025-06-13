#  Advanced SQL – Real Business Analytics in Action

This folder contains advanced SQL tasks and case studies modeled on real-world business scenarios. These tasks involve product sales, co-occurrence analysis, ABC-XYZ classification, and transaction data aggregation.

---

##  Data Source

All tasks in this folder are based on the following dataset:

###  [Pharmacy Database](../../databases/Pharmacy.md)

A transactional database of a retail pharmacy network, which includes:

- Product-level sales (`sales`)
- Employee metadata (`employee`)
- Shop/branch metadata (`shops`)
- Bonus card system and redemption logs (`bonuscheques`)

You can explore its structure and entity relationships in the file above.

---

##  File Overview

| File Name                              | Description                                                                 |
|----------------------------------------|-----------------------------------------------------------------------------|
| `abc_xyz_analysis.sql`                 | ABC/XYZ classification of products based on revenue stability and volume   |
| `pharmacy_product_sales_matrix.sql`   | Generates a product × date sales matrix for multivariate trend analysis    |
| `product_cococurrence_analysis.sql`   | Identifies products frequently bought together in the same receipt         |
| `ABC_Analysis.sql`                    | Performs ABC analysis by cumulative contribution to revenue                |

---

##  Related

- [`Pharmacy.md`](../../databases/Pharmacy.md) – full schema and data description
- [`DATABASES_OVERVIEW.md`](../../DATABASES_OVERVIEW.md)
