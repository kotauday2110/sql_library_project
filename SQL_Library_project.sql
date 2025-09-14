--library project

--creating books table
drop table if exists books;
create table books(
isbn varchar(50) primary key,
book_title varchar(80),
category varchar(30),
rental_price decimal(10,2),
status varchar(10),
author varchar(30),
publisher varchar(30));

--creating branch table 
drop table if exists branch;
create table branch(
branch_id varchar(10) primary key,
manager_id varchar(10),
branch_address varchar(30),
contact_no varchar(15));

--why not use int:
--mobile numbers are not numbers for calculation — you won’t add, subtract, or multiply them.
--loss of leading zeros — numbers like 0987654321 would be stored as 987654321.
--int(12) is misleading — the 12 in int is not length, it's a display width (only relevant with zerofill, which is deprecated).
--limited range — int can’t store numbers longer than 10 digits without overflowing.

drop table if exists employees;
create table employees(
emp_id varchar(10) primary key,
emp_name varchar(30),
position varchar(30),
salary decimal(10,2),
branch_id varchar(8),
foreign key (branch_id) references branch(branch_id));

drop table if exists members;
create table members(
member_id varchar(10) primary key,
member_name varchar(30),
member_address varchar(30),
reg_date date);

drop table if exists issued_status;
create table issued_status(
issued_id varchar(30) primary key,
issued_member_id varchar(30),
issued_book_name varchar(80),
issued_date date,
issued_book_isbn varchar(50),
issued_emp_id varchar(10),
foreign key (issued_member_id) references members(member_id),
foreign key (issued_emp_id) references employees(emp_id),
foreign key (issued_book_isbn) references books(isbn));

drop table if exists return_status;
create table return_status(
return_id varchar(10) primary key,
issued_id varchar(30),
return_book_name varchar(80),
return_date date,
return_book_isbn varchar(50),
foreign key (return_book_isbn) references books(isbn));

--another method of adding foreign key
alter table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);


-- data base created 
-- project tasks ----crud operations

--question -1 :insert into books values('978-1-60129-456-2','to kill a mockingbird','classic',6.00,'yes','harper lee','j.b. lippincott & co.');
select * from books
insert into books 
(isbn ,	book_title,	category,rental_price,status,author,publisher)
values
('978-1-60129-456-2','to kill a mockingbird','classic',6.00,'yes','harper lee','j.b. lippincott & co.');


--question-2 :update an existing member address 
select * from members

 update  members 
 set member_address= '124 Main st'
 where member_id ='C101';

--question -3 : Delete the record with issued_id = 'IS121' from the issued_status table 
select * from issued_status
delete from issued_status 
where issued_id='IS121'

--question -4: Select all books issued by the employee with emp_id = 'E101'.     
select * from issued_status 
where issued_emp_id = 'E101'

--question -5:Use GROUP BY to find members who have issued more than one book.
select issued_emp_id , count(*) 
from issued_status 
group by issued_emp_id 
having count(*) >1


--QUESTION 6 :CTAS (Create Table As Select) operations
--Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

create table book_count as
select b.isbn ,count(i.issued_book_isbn) as issued_count,b.book_title from books as b
join issued_status as i
on b.isbn = i.issued_book_isbn 
group by b.isbn,3

select * from book_count

--QUESTION 7 : Retrieve All Books in a Specific Category:

select * from books where category='History'

--QUESTION 8 : Find Total Rental Income by Category:

select*from issued_status
select b.category, sum(b.rental_price) 
from books b 
join issued_status i 
on b.isbn= i.issued_book_isbn
group by 1

--QUESTION 9 : List Members Who Registered in the Last 1000 Days
select * from members

select * from members 
where current_date - reg_date <='1000'

--QUESTION 10 :List Employees with Their Branch Manager's Name and their branch details:
select e1.*,b.manager_id ,e2.emp_name as manager_name
from employees as e1
join branch as b
on b.branch_id=e1.branch_id
join employees as e2
on b.manager_id= e2.emp_id

--QUESTION 11 :Create a Table of Books with Rental Price Above a Certain Threshold:
create table lower_rent as 
select * from books 
where rental_price<'4.5'

select * from lower_rent

--QUESTION 12 :Retrieve the List of Books Not Yet Returned

select * from issued_status 
select * from return_status

select * from issued_status i
left join return_status r 
on i.issued_id = r.issued_id
where r.issued_id is null 

--question 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period).
--Display the member's_id, member's name, book title, issue date, and days overdue.

SELECT 
 ist.issued_member_id,
m.member_name,
bk.book_title,
ist.issued_date,
CURRENT_DATE - ist.issued_date as over_dues_days
FROM issued_status as ist
JOIN members as m
ON m.member_id = ist.issued_member_id
JOIN books as bk
ON bk.isbn = ist.issued_book_isbn
LEFT JOIN return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_date IS NULL AND
(CURRENT_DATE - ist.issued_date) > 30
ORDER BY 1

select * from books 
select * from issued_status;
select * from return_status ;


--QUESTION -14 Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

select * from  branch
select * from books 
select * from issued_status;
select * from return_status ;
select * from employees
CREATE TABLE branch_reports AS
SELECT 
   b.branch_id, b.manager_id, COUNT(ist.issued_id) AS number_book_issued, COUNT(rs.return_id) AS number_of_book_return,
SUM(bk.rental_price) AS total_revenue
 FROM issued_status AS ist
JOIN employees AS e ON e.emp_id = ist.issued_emp_id
JOIN branch AS b ON e.branch_id = b.branch_id
LEFT JOIN return_status AS rs ON rs.issued_id = ist.issued_id
JOIN books AS bk ON ist.issued_book_isbn = bk.isbn
GROUP BY b.branch_id, b.manager_id;

SELECT * FROM branch_reports;


QUESTION 15--CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

create table active_members as
select * from members
where member_id in (
    select distinct issued_member_id
    from issued_status
    where issued_date >= current_date - interval '2 month'
);

select * from active_members


--QUESTION -16 :Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

select 
    e.emp_name,
    b.*,
    count(ist.issued_id) as no_book_issued
from issued_status as ist
join employees as e on e.emp_id = ist.issued_emp_id
join branch as b on e.branch_id = b.branch_id
group by 1, 2;




