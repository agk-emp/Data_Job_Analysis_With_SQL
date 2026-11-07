/*
    Filter the top-paying-skills that pays the most
    Goal: to avoid wasting my time on not well-paying skills because there are many.
*/

WITH skills_count_cte AS(
    SELECT
        sjd.skill_id,
        ROUND(AVG(jpf.salary_year_avg),2) AS avg_yearly_salary
    FROM
        skills_job_dim AS sjd
        INNER JOIN job_postings_fact AS jpf
        ON sjd.job_id = jpf.job_id
    WHERE 
        jpf.job_title_short = 'Data Analyst'
    GROUP BY
        sjd.skill_id
)

SELECT 
    skills.skills,
    sc_cte.avg_yearly_salary
FROM 
    skills_dim AS skills
    INNER JOIN skills_count_cte AS sc_cte
    ON skills.skill_id = sc_cte.skill_id
ORDER BY 
   sc_cte.avg_yearly_salary DESC NULLS LAST
LIMIT 10;


/*
Final thoughts
Overall, I think these results show that developing expertise in a specific technology can have a positive impact on earning potential. However, salary shouldn't be the only factor when choosing what to learn. It's also important to consider how often companies are looking for that skill and whether it has good long-term career opportunities.

Personally, I would pay more attention to skills like Golang and Terraform because they have practical applications across different areas of the tech industry, rather than focusing only on the highest salary figures.
##########################################################################################################################################################################################################################################################################################################################################################


[
  {
    "skills": "svn",
    "avg_yearly_salary": "400000.00"
  },
  {
    "skills": "solidity",
    "avg_yearly_salary": "179000.00"
  },
  {
    "skills": "couchbase",
    "avg_yearly_salary": "160515.00"
  },
  {
    "skills": "datarobot",
    "avg_yearly_salary": "155485.50"
  },
  {
    "skills": "golang",
    "avg_yearly_salary": "155000.00"
  },
  {
    "skills": "mxnet",
    "avg_yearly_salary": "149000.00"
  },
  {
    "skills": "dplyr",
    "avg_yearly_salary": "147633.33"
  },
  {
    "skills": "vmware",
    "avg_yearly_salary": "147500.00"
  },
  {
    "skills": "terraform",
    "avg_yearly_salary": "146733.83"
  },
  {
    "skills": "twilio",
    "avg_yearly_salary": "138500.00"
  }
]
*/