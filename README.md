# Pewlett Hackard Retirement Analysis

## Project Overview
A human resources team at Pewlett Hackard, a large technology company, has been tasked with preparing the company for a large amount of employees' retirements. After doing some preliminary analysis, they asked for assistance in determining the number of retiring workers per job title, and those who are eligible to participate in a mentorship program and who would be well-suited to transition to the positions left vacant after the large wave of retirements.


## Resources
**Data Sources:** dept_emp.csv, dept_manager.csv, emp_info.csv, employees.csv, salaries.csv, titles.csv

**Software:** Python 3.9.7, Anaconda Navigator 1.9.0, Jupyter Notebook 6.4.5, PostgressSQL 12.0


## Results

* There are close to 72,450 employees retiring in the near future and they are not dispersed evenly among job titles.
* The two job titles with the largest number of upcoming retirements are Senior Engineer and Senior Staff, which make up roughly 70% of number of retiring workers
* The least-impacted role will be that of Manager
* The employees eligible for mentorship will only cover about 2% of the positions currently held by workers that will soon retire.

### Retiring Employees by Job Title
![employees_ret_by_title.png] (https://github.com/saraegregg/Mod7_Pewlett_Hackard_Analysis/blob/main/images/employees_ret_by_title.png)
To find the number of employees retiring by their job title, firstly I joined the employee and title tables in the database into a new table, filtered by the employees of retirement age. To remove the duplicate entries of employees who have had multiple job titles in the company over the years and find those who were still employed, I used the distinct on statement paired with a filter set to only workers currently employed. Finally, I wrote a query that counted and grouped the retiring employees by their current job title, resulting in the preceding table.

### Employees Poised for Mentorship
![mentorship_eligible_employes.png] (https://github.com/saraegregg/Mod7_Pewlett_Hackard_Analysis/blob/main/images/mentorship_eligible_employes.png)
In order to find the workers who would be prime candidates for mentorship, I joined the employees, titles, and department employee tables, filtering by a birthdate in 1965 as well as an active employee status, and finally creating a new table to hold the data. 


## Summary
The results of the additional analysis I performed obviates several conclusions. Firstly, there are several job titles that will be impacted much more than others. Senior Engineers and Senior Staff are on the brink of retiring in massive numbers, so I would recommend that the human resources team and upper management teams immediately begin to plan to address the workforce deficit in these areas. Other job titles
will also retire in large numbers: Engineers, Staff, and Technique Leaders will leave thousands of roles unfilled and should be addressed promptly. The title that is least concerning is the manager position, which will only suffer from two retirements in upcoming years.

Looking to the list of employees eligible for mentorship, it is clear that their numbers are far fewer and that these employees alone are not enough to fill the gaps left by the upcoming retirements. They total XXXXXX. It would be helpful to run additional analysis so that we know what these workers' current job titles are--and which roles they may be best-suited to fill once employees retire. That way the company will know if there are enough employees with each title to  mentor their younger co-workers. Another way to address the alarming difference in numbers between retires and mentees would be for human resources and upper management to consider widening the eligibility criteria for
the mentorship program in order to prepare more workers for more senior positions that will soon need to be filled. For example, instead of using just the birth year of 1965, they might opt for a five-year range, just like I used on the retirement analysis. Additionally, there are workers who are older than those flagged for mentorship, but younger than those retiring--it would be interesting to see how many workers belong to this group and what their current job titles are. There may be a wealth of employees in this group that would be well-suited to the soon-to-be vacant positions of their older coworkers.
