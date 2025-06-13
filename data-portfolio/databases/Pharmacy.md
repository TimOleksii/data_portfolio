#  Pharmacy Database

This document describes the structure of the **Pharmacy ** database, which contains information on sales, pharmacies, employees, and bonus transactions.

---

##  Entity Relationship Diagram

![Apteka ER Diagram](../img/pharmacy_schema.png)

---

##  Bonus Transactions

### `bonuscheques`

Tracks bonus system usage per transaction.

| Column           | Description                                                                 |
|------------------|-----------------------------------------------------------------------------|
| `datetime`       | Date and time of the transaction                                            |
| `shop`           | Pharmacy name                                                               |
| `card`           | Bonus card number (may be encrypted if offline)                            |
| `bonus_earned`   | Bonuses earned                                                              |
| `bonus_spent`    | Bonuses spent                                                               |
| `summ`           | Total amount of the receipt                                                 |
| `summ_with_disc` | Amount with discounts and applied bonuses                                   |
| `doc_id`         | Document ID                                                                 |

>  If the terminal was offline, the `card` will contain an encrypted string and **cannot be decrypted** to retrieve the real card number.

---

##  Employees

### `employee`

| Column     | Description               |
|------------|---------------------------|
| `emp_tabn` | Employee payroll number   |
| `emp_fio`  | Full name of employee     |

---

##  Pharmacies

### `shops`

| Column | Description        |
|--------|--------------------|
| `id`   | Pharmacy ID        |
| `name` | Pharmacy name      |

---

##  Sales

### `sales`

Each row describes **one item** in a receipt.

| Column        | Description                                                      |
|---------------|------------------------------------------------------------------|
| `DR_Dat`      | Purchase date                                                    |
| `DR_Tim`      | Purchase time                                                    |
| `DR_NChk`     | Receipt number                                                   |
| `DR_NDoc`     | Cash register document number                                    |
| `DR_apt`      | Store ID (FK - shops)                                            |
| `DR_Kkm`      | Cash register number                                             |
| `DR_TDoc`     | Document type                                                    |
| `DR_TPay`     | Payment type (18 = card, 15 = cash)                              |
| `DR_CDrugs`   | Product article number                                           |
| `DR_NDrugs`   | Product name                                                     |
| `DR_Suppl`    | Supplier                                                         |
| `DR_Prod`     | Manufacturer                                                     |
| `DR_Kol`      | Quantity sold                                                    |
| `DR_CZak`     | Purchase price                                                   |
| `DR_CRoz`     | Retail price                                                     |
| `DR_SDisc`    | Discount amount                                                  |
| `DR_CDisc`    | Discount code                                                    |
| `DR_BCDisc`   | Discount barcode                                                 |
| `DR_TabEmpl`  | Employee number (FK - employee)                                  |
| `DR_Pos`      | Item position in receipt                                         |
| `DR_VZak`     | Purchase type (1 = regular, 2 = online order)                    |

###  Notes:

- One receipt may span **multiple rows** — each row is one item.
- To uniquely identify a receipt, use the combination: `DR_apt + DR_NChk + DR_Dat`
- Discount (`DR_SDisc`) is **total**, not per item — do **not** multiply by quantity.

---

>  For the overview of all databases used in the project, see [DATABASES_OVERVIEW.md](../DATABASES_OVERVIEW.md)

>  ER Diagram should be saved as `img/pharmacy_schema.png`