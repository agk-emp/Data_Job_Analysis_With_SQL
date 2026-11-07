/*
    I am trying to get the otimal skills: high in damand and well paying
    Goal: to learn skills that will help get into the job market quickly and pays off
*/

WITH optimal_skills_cte AS(
    SELECT 
        sjd.skill_id,
        COUNT(*) AS skills_count,
        ROUND(AVG(jpf.salary_year_avg),2) AS avg_yearly_salary
    FROM
        skills_job_dim AS sjd
        INNER JOIN job_postings_fact AS jpf
        ON sjd.job_id = jpf.job_id
    WHERE
        jpf.job_title_short = 'Data Analyst'
    GROUP BY
        sjd.skill_id
    ORDER BY
        skills_count DESC
    LIMIT 15
)

SELECT 
    skills.skills,
    op_cte.skills_count,
    op_cte.avg_yearly_salary
FROM 
    skills_dim AS skills
    INNER JOIN optimal_skills_cte AS op_cte
    ON skills.skill_id = op_cte.skill_id
ORDER BY 
    op_cte.avg_yearly_salary DESC NULLS LAST;