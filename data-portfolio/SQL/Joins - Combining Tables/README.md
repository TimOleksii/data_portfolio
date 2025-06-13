# Joins – Combining Tables

This folder contains SQL tasks that practice combining multiple tables using different types of JOIN operations, based on real-world data from an educational platform.

---

## Data Source

All SQL tasks in this folder are based on the following:

### Simulative Database

The Simulative database includes real data from an interactive educational platform and features:

- `users`, `user_entry`, `test_result`, `code_submit`, `problem`, `company`, `page`, and others.
- These tables are used to simulate business-relevant use cases such as user engagement, test performance, problem-solving statistics, and company-specific assignments.

---

## File Overview

| File Name                                          | Description                                                   |
|---------------------------------------------------|---------------------------------------------------------------|
| `Generate_Gradebook_Structure.sql`                | Build a virtual gradebook by joining user and task data       |
| `Join_All_Student_Submissions_With_Inactive.sql`  | Join user activity with submission status                     |
| `Join_Analysis_Categories_Not_Used.sql`           | Identify unused analysis categories via left join             |
| `Join_Clients_Ordered_Microelements.sql`          | Join product orders with user health data (simulated case)    |
| `Join_Problems_Without_Submits.sql`               | Detect problems that no users have solved                     |
| `Join_Student_Homework_Submissions.sql`           | Combine students and homework tables                          |
| `Join_Students_Task_Only_No_Tests.sql`            | Users who solved tasks but never took tests                   |
| `Join_Students_With_No_Code_Submission.sql`       | Users who never submitted any code                            |
| `Join_Test_Result_Statistics.sql`                 | Aggregate and join test results for deeper analysis           |
| `Join_Unordered_Categories.sql`                   | Practice joins with unordered or loosely grouped categories   |
| `Min_Lexicographic_Analysis_Type.sql`             | Find minimum lexicographic entries across join results        |
| `Prepare_Problem_Titles_For_New_Clients.sql`      | Personalize problem titles for new corporate clients          |
| `Search_For_Malicious_Code.sql`                   | Use joins to identify users submitting suspicious code        |
| `Union_Activity_Days_Since_Registration.sql`      | Join and union login and registration dates                   |
| `Union_Filter_By_Markup_Or_Category.sql`          | Combine filters by markup/category across problems            |

---

## Related Resources

- `../../databases/Simulative.md` — Full Simulative database schema
- `../../DATABASES_OVERVIEW.md` — Overview of all databases used in the project