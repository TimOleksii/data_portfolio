# 🪟 Window Functions – Practice Tasks

This folder contains focused SQL practice tasks using **window functions** such as `ROW_NUMBER()`, `RANK()`, `LAG()`, `LEAD()`, `SUM() OVER`, and others.

All tasks are built on top of a single table: `transactions`, which simulates purchase operations in a retail environment.

---

## 🗃️ Table Used: `transactions`

| Column         | Description                                      |
|----------------|--------------------------------------------------|
| `id`           | Record ID (primary key)                          |
| `id_transaction`| Transaction identifier                          |
| `card_id`      | Card number                                      |
| `maincard_id`  | Master card ID                                   |
| `date`         | Date and time of transaction                     |
| `sum`          | Transaction amount                               |
| `type`         | Transaction type                                 |
| `employee`     | Employee involved                                |
| `doc_id`       | Document (receipt) identifier                    |
| `cash_id`      | Cash register ID                                 |
| `shop_id`      | Store ID                                         |
| `doc_type`     | Document type                                    |
| `disc_id`      | Discount ID                                      |
| `disc_source`  | Source of the discount                           |

---

## 📄 File Overview

| File Name                                | Description                                                     |
|------------------------------------------|-----------------------------------------------------------------|
| `check_line_numbering.sql`               | Use `ROW_NUMBER()` to add unique row IDs to transactions        |
| `employee_transaction_growth.sql`        | Calculate % growth of transactions per employee over time       |
| `prev_next_sum_per_doc.sql`              | Use `LAG()` and `LEAD()` to compare neighbor rows within docs   |
| `ranking_abs_sum_by_employee.sql`        | Rank employees by total transaction sum (absolute)              |
| `running_balance.sql`                    | Use cumulative sum (`SUM() OVER`) to compute running balance    |
| `sliding_avg_transaction_total.sql`      | Use windowed `AVG()` over date ranges to smooth transaction sums|

---

## 🔗 Related Topics

- [Window Functions Guide](https://www.sqltutorial.org/sql-window-functions/)
- [Analytic Functions Cheat Sheet](https://mode.com/sql-tutorial/sql-window-functions/)

---

## 📁 Folder Structure

