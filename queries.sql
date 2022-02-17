--To search for employees born on certain years
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

--To search for employees born and hired in certain time frames
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--To find the number of employees returned from the search
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--To put the returned data into a new table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Mod 7 through 7.3.1, starting 7.3.2
--drop the previous retirement_info table, because it did not include emp_no for joins
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--7.3.3 Joins in action
--inner join of departments table and department manager table
-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

--left join of retirement_info table and department employee table
-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

--left join for reitrement_info and dept_emp tables so we know if they are still employed
--so reuse previous code, but create "current_emp" table, and filter with WHERE
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
    de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--7.3.4 Count, Group By, and Order By
--In Postgres, GROUP BY is used when we want to group rows of identical data together in a table.

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--To make the employee count by dept number into a new table
SELECT COUNT(ce.emp_no), de.dept_no
INTO employee_count_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--7.3.5 Create additional lists: 1-employee info, 2-management info, 3-department retirees
--List 1 needs: emp#, first name, last name, gender, to_date, salary

--Create an employee info table with some of the items we need in the final table by sorting
--the employees table BUT don't run--we will make changes...
SELECT emp_no,
	   first_name,
	   last_name, 
	   gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--since we have to add salary and to-date, we need to join with other tables in the DB
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       e.gender,
       s.salary,
       de.to_date
--INTO emp_info
FROM employees as e
INNER JOIN salaries as salaries
ON (e.emp_no = s.emp_no)
--second join goes right after first
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--make sure we are only looking at currently active employees
AND (de.to_date = '9999-01-01');

--List 2 Management: dept#, dept_name, emp_no, first name, last name, starting date, ending_date
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

--List 3 Department Retirees needs: emp_no, first_name, last_name, dept_name
--We are only taking the columns we need from 2 tables, but they are joined by their
--primary/foreign keys, so we have to join 3
SELECT ce.emp_no,
       ce.first_name,
       ce.last_name,
       d.dept_name
--INTO department_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)


--7.3.6 Create a tailored list
--Create a query that will return only the information relevant to the Sales team. 
--The requested list includes: emp#, first name, last name, dept name
SELECT emp_no,
       first_name,
       last_name,
       dept_name
FROM department_info
WHERE dept_name = 'Sales';

--2nd list for emp in sales OR development
SELECT emp_no,
       first_name,
       last_name,
       dept_name
FROM department_info
WHERE dept_name IN ('Sales', 'Development');