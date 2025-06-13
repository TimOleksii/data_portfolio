#  Window Functions – Business Case Scenarios

This folder contains real-world analytical SQL use cases that leverage **window functions** to solve problems from two different domains: platform analytics and transaction categorization.

---

##  Data Sources

This folder uses **two databases**, depending on the task:

###  [Simulative Database](../../databases/Simulative.md)

Used in platform user activity and behavior tasks:

- `daily_peak_registration_analysis.sql`
- `cumulative_unique_active_users.sql`
- `dau_smoothed_time_series.sql`

###  [Merchant Database](../../databases/Merchant.md)

Used in retail and banking analysis with MCC codes:

- `monthly_top_mcc_groups_2019.sql`
- `top_3_transactions_per_group.sql`

---

##  File Overview

| File Name                             | Description                                                   | Database      |
|--------------------------------------|---------------------------------------------------------------|---------------|
| `dau_smoothed_time_series.sql`       | Compute and smooth daily active users (DAU)                   | Simulative    |
| `monthly_top_mcc_groups_2019.sql`    | Get monthly top MCC groups by total transaction value         | Merchant      |
| `top_3_transactions_per_group.sql`   | For each MCC group, show top 3 largest transactions           | Merchant      |
| `cumulative_unique_active_users.sql` | Count cumulative unique users over time                       | Simulative    |
| `daily_peak_registration_analysis.sql`| Detect peak registration times and rank them                  | Simulative    |

---

##  Key Techniques

- `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` for ranking
- `SUM() OVER`, `COUNT() OVER`, and cumulative windows
- `PARTITION BY` and `ORDER BY` clauses in analytical queries

---

##  Folder Structure

