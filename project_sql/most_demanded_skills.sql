/*
    - I want to get the most required skills for my role
    - this will help me focus on skills that are high in demand
*/

WITH skills_count_cte AS(
    SELECT 
        sjd.skill_id,
        COUNT(*) skills_count
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
    sc_cte.skills_count
FROM 
    skills_dim AS skills
    INNER JOIN skills_count_cte AS sc_cte
    ON skills.skill_id = sc_cte.skill_id
ORDER BY 
    sc_cte.skills_count DESC
LIMIT 5;