# Introduction

I'll be honest: I started this project because I was tired of guessing. 😅

Every time I looked into what to learn next, I found a different answer. One list said Python, another said cloud, another said some tool I had never heard of. I didn't want to spend months on a skill and then find out it barely affects what I could earn. ⏳

So I decided to let the data answer instead. 📊

Using SQL and Python, I looked through real job postings to find out:

- 💰 Which skills are linked to the highest pay
- 🔥 Which skills employers ask for the most
- 🎯 Where the two overlap, so I know what to learn first

🔎 Check out the SQL queries here: <a href="project_sql/">project_sql folder</a>

# Background

This project started with a question that kept bugging me: **"What should I actually learn?"** 🤔

When you're starting out, every video and blog post tells you something different. One says learn Python, another says SQL is a must, and someone else swears by a tool you've never heard of. 😵‍💫 I wanted real numbers instead of opinions, so I went to the job market itself. 🌍

I used real job posting data, which shows what companies are asking for and what they are willing to pay. 💼 It's the closest thing to the market telling you directly what it values. 📈

**Questions I wanted to answer:**

1. 💰 What are the top paying jobs for my role?
2. 🧩 What skills do those high-paying jobs require?
3. 🔥 What skills are most in demand right now?
4. 💎 Which skills pay the most?
5. 🎯 Which skills are worth learning first, with both high demand and high pay?

I'm not trying to chase every trend. ⏳ The goal is to put my time into the few skills that really pay off, and to help anyone else who is stuck in the same spot. 🙌

# Tools I Used

I kept my toolkit simple, but each tool did a real job. 🧰

- 🗄️ **SQL:** This is where the real work happened. Every question I had about the job market turned into a query.
- 🐘 **PostgreSQL:** My main database. It held all the job posting data, and it handled the bigger queries without any trouble.
- 🪶 **SQLite:** I used this when I wanted to test an idea quickly. It's small and light, and there's no server to set up.
- 💻 **Visual Studio Code:** My home base. I wrote my queries here, and even this README. 😄
- 🌿 **Git:** My safety net. It let me try things without worrying about breaking something I couldn't undo.
- 🐙 **GitHub:** Where I share the project, so anyone can look at my work or learn from it. 🙌

![SQL](https://img.shields.io/badge/SQL-4479A1?logo=mysql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-003B57?logo=sqlite&logoColor=white)
![VS Code](https://img.shields.io/badge/VS_Code-007ACC?logo=visualstudiocode&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?logo=github&logoColor=white)

## The Analysis

I took this one question at a time, and every answer showed me what to ask next. 🧩

### 1. 💼 What are the top paying Data Analyst jobs?

I wanted to start at the top and see what the best salaries actually look like. Once I knew that, I could figure out which skills were behind them. 🎯

```sql
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
    jpf.salary_year_avg DESC NULLS LAST
LIMIT 10;
```

![Top paying Data Analyst jobs](assets\1_top_paying_jobs.png)

| Job title | Company | Location | Average yearly salary |
|-----------|---------|----------|----------------------:|
| Data Analyst | Mantys | Anywhere | $650,000 |
| Data base administrator | ЛАНИТ | Belarus | $400,000 |
| HC Data Analyst, Senior | Illuminate Mission Solutions | Bethesda, MD | $375,000 |
| Sr Data Analyst | Illuminate Mission Solutions | Bethesda, MD | $375,000 |
| Head of Infrastructure Management & Data Analytics | Citigroup, Inc | Jacksonville, FL | $375,000 |
| Director of Safety Data Analysis | Torc Robotics | Austin, TX | $375,000 |
| Data Analyst | Anthropic | San Francisco, CA | $350,000 |
| Head of Data Analytics | Care.com | Austin, TX | $350,000 |
| Director of Analytics | Meta | Anywhere | $336,500 |
| Research Scientist | OpenAI | San Francisco, CA | $285,000 |

💡 **What stood out to me:**

- 💸 **One job is in a league of its own.** A $650K Data Analyst role at Mantys sits way above everything else. I treated it as an outlier, since the other nine land between $285K and $400K.
- 👔 **Seniority matters a lot.** Titles like Director and Head of show up again and again, so the top of the pay scale is about experience as much as skills.
- 🤔 **Not every title is a real analyst role.** The Database Administrator and Research Scientist jobs lean toward engineering and research, so I kept that in mind going forward.
- 🌍 **Remote work is in the mix.** Two of the ten jobs are open to "Anywhere", and all ten are full-time.

### 2. 🧩 What skills do those top paying jobs ask for?

Now that I knew the best jobs, I wanted to peek inside them and see what skills they ask for. This is the step that stops me from wasting time. ⏳

```sql
WITH top_paying_jobs_cte AS (
    SELECT 
        jpf.job_id,
        jpf.job_title,
        jpf.salary_year_avg
    FROM 
        job_postings_fact AS jpf
    WHERE
        jpf.job_title_short = 'Data Analyst'
    ORDER BY
        jpf.salary_year_avg DESC NULLS LAST
    LIMIT 10
)

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
    tjs.salary_year_avg DESC;
```

![Skills in the top paying jobs](assets\2_skills_for_top_paying_jobs.png)

| Skill | Postings (out of 7 that list skills) |
|-------|:---:|
| 🐍 Python | 4 |
| 🗄️ SQL | 3 |
| 📐 R | 3 |
| 📗 Excel | 3 |
| 📊 Tableau | 3 |
| 📈 Power BI | 2 |

💡 **What stood out to me:**

- 🐍 **Python is the star.** It appears in more than half of the postings that list skills.
- 🧱 **The same stack keeps showing up.** Python or R, SQL, and a BI tool. The Head of Data Analytics role lists SQL, Python, R, Tableau and Power BI all together.
- 📗 **Excel is still alive and well.** It appears in three high paying roles, including a $375K senior analyst job paired with VBA. Spreadsheets are not going anywhere. 😄
- ☁️ **The fancy tools sit at the top.** Snowflake, BigQuery, Looker, Spark and Airflow only appear in the Director and Head level roles.
- ⚠️ **A couple of rows are misleading.** The $400K "Data base administrator" job (Oracle, Kafka, Linux, SVN) is really an engineering role, and the Research Scientist row lists only one skill. Without those two, the picture is much cleaner: Python, SQL, R, Excel and Tableau lead.

### 3. 🔥 What skills are most in demand?

High pay sounds great, but a skill that nobody asks for won't get me hired. So I counted how often each skill appears in Data Analyst job postings. 📊

```sql
WITH skills_count_cte AS (
    SELECT 
        sjd.skill_id,
        COUNT(*) AS skills_count
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
```

![Most in-demand skills](assets\3_most_demanded_skills.png)

| Skill | Number of postings |
|-------|-------------------:|
| SQL | 92,628 |
| Excel | 67,031 |
| Python | 57,326 |
| Tableau | 46,554 |
| Power BI | 39,468 |

💡 **What stood out to me:**

- 🗄️ **SQL wins by a mile.** Employers ask for it about 1.6 times as often as Python.
- 📗 **Excel beats Python on demand.** It is the second most requested skill, so I won't be skipping it.
- 📊 **BI tools fill the rest of the list.** Tableau and Power BI each appear in tens of thousands of postings, so showing data clearly really matters.

### 4. 💰 Which skills pay the most?

Now for the question that started this whole project: which skills pay the most on average? 🤑

```sql
WITH skills_salary_cte AS (
    SELECT
        sjd.skill_id,
        ROUND(AVG(jpf.salary_year_avg), 2) AS avg_yearly_salary
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
    ss_cte.avg_yearly_salary
FROM 
    skills_dim AS skills
    INNER JOIN skills_salary_cte AS ss_cte
    ON skills.skill_id = ss_cte.skill_id
ORDER BY 
    ss_cte.avg_yearly_salary DESC NULLS LAST
LIMIT 10;
```

![Top paying skills](assets\4_top_paying_skills.png)

| Skill | Average yearly salary |
|-------|----------------------:|
| SVN | $400,000 |
| Solidity | $179,000 |
| Couchbase | $160,515 |
| DataRobot | $155,486 |
| Golang | $155,000 |
| MXNet | $149,000 |
| dplyr | $147,633 |
| VMware | $147,500 |
| Terraform | $146,734 |
| Twilio | $138,500 |

💡 **What stood out to me:** SVN towers over everything else, but it matches the single $400K Database Administrator posting from question 2, so I counted it as an outlier. 🤔 Most of the other skills are specialized tools, which means a high average doesn't always mean lots of jobs.

### 5. 🎯 What are the optimal skills to learn?

Finally, I put demand and pay together. I took the 15 most requested skills and sorted them by salary. This is my shortcut to skills that can get me hired quickly and still pay off. 🚀

```sql
WITH optimal_skills_cte AS (
    SELECT 
        sjd.skill_id,
        COUNT(*) AS skills_count,
        ROUND(AVG(jpf.salary_year_avg), 2) AS avg_yearly_salary
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
```

![Demand vs pay for the most requested skills](assets\5_optimal_skills.png)

| Skill | Number of postings | Average yearly salary |
|-------|-------------------:|----------------------:|
| AWS | 9,063 | $106,440 |
| Azure | 10,942 | $105,400 |
| Python | 57,326 | $101,512 |
| Oracle | 10,410 | $100,964 |
| R | 30,075 | $98,708 |
| Tableau | 46,554 | $97,978 |
| SQL | 92,628 | $96,435 |
| SQL Server | 8,304 | $96,191 |
| SAS | 14,034 | $93,707 |
| SAP | 11,297 | $92,446 |
| Power BI | 39,468 | $92,324 |
| PowerPoint | 13,848 | $88,316 |
| Excel | 67,031 | $86,419 |
| Word | 13,591 | $82,941 |

💡 **What stood out to me:**

- 🐍 **Python is the sweet spot.** It has the third highest pay ($101.5K) and the third highest demand, with over 57,000 postings.
- ☁️ **Cloud skills pay the most.** AWS and Azure lead on salary, but only about 9,000 to 11,000 postings ask for them, so they feel like a great second step rather than a first one.
- 🗄️ **SQL is the safest bet.** It has by far the most postings and still pays around $96K.
- 📊 **Tableau and R are solid middle ground.** Both pay close to $98K and have plenty of demand.
- 📉 **Office tools pay the least.** Excel, PowerPoint and Word sit at the bottom on salary. Excel is still worth knowing since so many jobs ask for it, but it won't be what sets you apart.

### 🧠 Final Thoughts

Overall, these results show that getting really good at a specific technology can help your earning potential. 📈 But I don't think salary should be the only thing that decides what to learn. How often companies ask for a skill, and whether it will still matter in a few years, count just as much. ⏳

Personally, I'd pay more attention to skills like **Golang** and **Terraform**. They're useful across many areas of tech, not just one narrow job, and that matters more to me than chasing the biggest salary number. 🌍

# What I Learned

This project taught me more than I expected. 🎓

- 🧩 **CTEs make messy queries readable.** Breaking a big query into small named steps, instead of nesting everything inside each other, made my SQL so much easier to follow.
- 🔗 **Joins are the heart of SQL.** Connecting jobs, skills and companies across different tables finally clicked for me. 💡
- 📊 **Averages can be misleading.** The $400K SVN result looked amazing until I saw it came from a single posting. Now I always check how much data sits behind a number. 👀
- 🧹 **Real data is messy.** I ran into outliers, odd job titles and even a duplicated skill in my results. Questioning the data is half the job. 😅
- 🌿 **Git and GitHub are worth the effort.** Saving my progress and putting it online made this feel like a real project, not just files on my laptop.
- ✍️ **Explaining results is its own skill.** Turning numbers into a story that someone else can follow was harder than writing the queries. 🙌
- 🎯 **Asking the right question comes first.** Every query started as a simple question, and a clear question made the SQL much easier to write.
````

# Conclusions

So, what should you actually learn? 🤔 Here is what the data told me:

1. 🗄️ **Start with SQL.** It is the most requested skill by a big margin, with over 92,000 postings, and it still pays around $96K a year.
2. 🐍 **Add Python next.** It is the sweet spot: high demand (over 57,000 postings) and one of the best salaries ($101.5K).
3. 📊 **Learn one BI tool.** Tableau and Power BI show up in tens of thousands of postings, and Tableau pays close to $98K.
4. ☁️ **Cloud skills come after that.** AWS and Azure pay the most among the common skills, but fewer jobs ask for them, so they make a great second step.
5. 📗 **Don't skip Excel.** It pays the least of this group, but it is still everywhere, so it is worth knowing.

⚠️ **One caution:** the highest salaries I found belong to senior and leadership roles, and a few of them are outliers. The numbers show where the money is, but they don't promise a job. Experience still matters. 😄

**What I'd do next:** 🚀

- Compare these results for other roles, like Data Scientist and Data Engineer
- Look at how skill demand changes over time
- Check which skills matter most for remote jobs

My goal was to stop wasting time on skills that don't pay off. 🎯 Now I have a clear order: **SQL, then Python, then a BI tool, then the cloud.**


