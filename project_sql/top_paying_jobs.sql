/*
    Question: What are the top paying jobs as data analysis?
    Why: I need to know for later focusing on skills thap pay me the most
*/

SELECT 
    jpf.job_id,
    jpf.job_title,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.salary_year_avg,
    jpf.job_posted_date,
    companies.name AS company
FROM 
    job_postings_fact AS jpf
    LEFT JOIN company_dim AS companies
    ON jpf.company_id = companies.company_id
WHERE
    jpf.job_title_short = 'Data Analyst'
ORDER BY
    jpf.salary_year_avg DESC NULLs LAST
LIMIT 10;
