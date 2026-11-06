/*
    - After I got the top paying jobs
    - I want to get tet the top skills I need to focus on
    - This will help avoid wasting time on not well-paying skills
*/

WITH top_paying_jobs_cte AS(
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
LIMIT 10)


SELECT
    skills.skills,
    tjs.job_title,
    tjs.salary_year_avg
FROM
    skills_dim AS skills
    INNER JOIN skills_job_dim AS sjd
    ON skills.skill_id = sjd.skill_id
    INNER JOIN top_paying_jobs_cte AS tjs
    ON sjd.job_id = tjs.job_id
ORDER BY 
    tjs.salary_year_avg DESC

/*
Insights

Python leads. It’s the only skill in more than half the postings, and it appears in every role with “Analyst” or “Analytics” in the title except the infrastructure-focused one.
The core stack is Python/R, SQL, and a BI tool. The Head of Data Analytics role lists SQL, Python, R, Tableau, and Power BI together, which makes it the closest match to the typical profile.
Excel is still present in high-paying roles. It shows up in three postings, including a $375K senior analyst role paired with VBA. Spreadsheet skills haven’t been replaced at senior levels.
Visualization tools matter. Tableau and Power BI appear in four of the seven postings, and the Director and Head of Analytics roles list both.
Cloud data warehouses and engineering tools appear only in the most senior roles. Snowflake, BigQuery, Looker, Spark, and Airflow show up in the Director and Head-level postings, which suggests they separate leadership roles from individual contributor roles.
The data has outliers. The $400K “Data base administrator” role (Oracle, Kafka, Linux, SVN) is an engineering job, not analysis, and the Research Scientist row has only one skill. Dropping both leaves a cleaner picture of five analyst-type roles, where Python, SQL, R, Excel, and Tableau dominate.

###########################################################################################################################################################################################################################################################################################################################

Actual data (json)

[
  {
    "skills": "oracle",
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0"
  },
  {
    "skills": "kafka",
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0"
  },
  {
    "skills": "linux",
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0"
  },
  {
    "skills": "git",
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0"
  },
  {
    "skills": "svn",
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0"
  },
  {
    "skills": "excel",
    "job_title": "Head of Infrastructure Management & Data Analytics - Financial...",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "word",
    "job_title": "Head of Infrastructure Management & Data Analytics - Financial...",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "python",
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "r",
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "vba",
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "excel",
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "tableau",
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "sql",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "python",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "r",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "sas",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "matlab",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "spark",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "airflow",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "excel",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "tableau",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "power bi",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "sas",
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0"
  },
  {
    "skills": "sql",
    "job_title": "Data Analyst",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "python",
    "job_title": "Data Analyst",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "sql",
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "python",
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "r",
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "bigquery",
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "snowflake",
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "tableau",
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "power bi",
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "looker",
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0"
  },
  {
    "skills": "github",
    "job_title": "Research Scientist",
    "salary_year_avg": "285000.0"
  }
]
*/