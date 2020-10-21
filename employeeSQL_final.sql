-- Create tables

CREATE TABLE departments(
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR NOT NULL
);

SELECT * FROM departments;

CREATE TABLE departments_employee(
	emp_no INT NOT NULL PRIMARY KEY,
	dept_no VARCHAR NOT NULL
);

SELECT * FROM departments_employee;


CREATE TABLE departments_manager(
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	emp_no INT NOT NULL
);

SELECT * FROM departments_manager;

CREATE TABLE employees(
	emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR NOT NULL,
	birth_date VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date VARCHAR NOT NULL
);

SELECT * FROM employees;

CREATE TABLE salaries(
	emp_no INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL
);

SELECT * FROM salaries;

CREATE TABLE titles(
	title_id VARCHAR PRIMARY KEY,
	title VARCHAR NOT NULL
);


-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
LEFT JOIN salaries s
ON e.emp_no = s.emp_no; 


-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986';
-- if the data type of hire_date is "date", I can do as 
-- WHERE hire_date BETWEEN '01/01/1986' AND '12/31/1986';


-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
CREATE TABLE Manager_Department AS
SELECT d.dept_no, d.dept_name, m.emp_no
FROM departments d
LEFT JOIN departments_manager m
ON d.dept_no = m.dept_no;

SELECT md.dept_no, md.dept_name, md.emp_no, e.last_name, e.first_name
FROM Manager_Department AS md
LEFT JOIN employees e
ON md.emp_no = e.emp_no;

-- INNER JOIN
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM departments d
    INNER JOIN departments_manager m
    ON d.dept_no = m.dept_no
    INNER JOIN employees e
    ON m.emp_no = e.emp_no;


-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
CREATE TABLE employee_departments AS
SELECT e.emp_no, e.last_name, e.first_name, de.dept_no
FROM employees AS e
LEFT JOIN departments_employee AS de
ON e.emp_no = de.emp_no;

SELECT ed.emp_no, ed.last_name, ed.first_name, d.dept_name
FROM employee_departments AS ed
LEFT JOIN departments AS d
ON ed.dept_no = d.dept_no;

-- INNER JOIN
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
    INNER JOIN departments_employee de
    ON e.emp_no = de.emp_no
    INNER JOIN departments d
    ON de.dept_no = d.dept_no;


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name='Hercules' AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name.
SELECT  e.emp_no, e.last_name, e.first_name,d.dept_name
FROM employees AS e
    INNER JOIN departments_employee AS de
        ON e.emp_no = de.emp_no
    INNER JOIN departments AS d
        ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY e.emp_no;     


-- 7. List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
    INNER JOIN departments_employee de
        ON e.emp_no = de.emp_no
    INNER JOIN departments d
        ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
ORDER BY e.emp_no;  



-- 8. In descending order, list the frequency count of employee last names, i.e., 
-- how many employees share each last name.

SELECT last_name, COUNT(last_name) AS "last_name_count"
FROM employees
GROUP BY last_name
ORDER BY last_name_count DESC;