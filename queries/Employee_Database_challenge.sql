--Chalenge 7, deliverable 1
-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
-- Retrieve the title, from_date, and to_date columns from the Titles table.
-- Create a new table using the INTO clause.
-- Join both tables on the primary key.
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
-- Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
-- Before you export your table, confirm that it looks like this image:
SELECT e.emp_no, 
    e.first_name, 
    e.last_name, 
    t.title,
    t.from_date,
    t.to_date
--INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
--INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;


--Find the number of employees by their most recent job title who are about to retire.
SELECT COUNT(title), title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;



--Deliverable 2,  write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e. first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
--INTO mentorship_eligibility
FROM employee AS e
JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
