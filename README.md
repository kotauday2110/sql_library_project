# sql_library_project

This project demonstrates the implementation of a **Library Management System** using **SQL**. It involves creating and managing relational database tables, performing **CRUD operations**, generating **summary reports**, and writing **advanced SQL queries**. The goal is to showcase hands-on skills in **database design**, **data manipulation**, and **querying techniques**.

---

## Objectives

- Design and create tables for managing branches, employees, members, books, issued status, and return status.
- Perform CRUD (Create, Read, Update, Delete) operations on the data.
- Use CTAS (Create Table As Select) to generate new tables based on query results.
- Develop advanced SQL queries for data analysis and business logic.
- Generate reports such as top employees, overdue books, and revenue breakdowns.

---

## SQL Tasks

- **Task 1:** Insert a new book record into the `books` table.
- **Task 2:** Update an existing member’s address.
- **Task 3:** Delete a record from the `issued_status` table (issued_id = 'IS121').
- **Task 4:** Retrieve all books issued by a specific employee (emp_id = 'E101').
- **Task 5:** List members who have issued more than one book using `GROUP BY`.
- **Task 6:** Create a summary table (using CTAS) that shows each book and its total issued count.
- **Task 7:** Retrieve all books in a specific category.
- **Task 8:** Find the total rental income grouped by book category.
- **Task 9:** List members who registered in the last 180 days.
- **Task 10:** List employees along with their branch manager’s name and branch details.
- **Task 11:** Create a table of books where the rental price is above a certain threshold.
- **Task 12:** Retrieve the list of books that have not yet been returned.
- **Task 13:** Identify members who have overdue books (assume a 30-day return period). Display member ID, name, book title, issue date, and days overdue.
- **Task 14:** Generate a performance report for each branch showing:
  - Number of books issued
  - Number of books returned
  - Total revenue from rentals
- **Task 15:** Use CTAS to create a new table `active_members` containing members who issued at least one book in the last 2 months.
- **Task 16:** Identify the top 3 employees who processed the most book issues. Display employee name, number of books processed, and their branch.

---

Feel free to explore, run, and expand upon these queries to strengthen your SQL skills!
