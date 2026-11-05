COPY company_dim FROM
'D:\DataAnalysis\Projects\Data_Job_Analysis_With_SQL\csv_files\company_dim.csv'
WITH(FORMAT csv, HEADER TRUE, DELIMITER ',');

COPY job_postings_fact FROM
'D:\DataAnalysis\Projects\Data_Job_Analysis_With_SQL\csv_files\job_postings_fact.csv'
WITH(FORMAT csv, HEADER TRUE, DELIMITER ',');

COPY skills_dim FROM
'D:\DataAnalysis\Projects\Data_Job_Analysis_With_SQL\csv_files\skills_dim.csv'
WITH(FORMAT csv, HEADER TRUE, DELIMITER ',');

COPY skills_job_dim FROM
'D:\DataAnalysis\Projects\Data_Job_Analysis_With_SQL\csv_files\skills_job_dim.csv'
WITH(FORMAT csv, HEADER TRUE, DELIMITER ',');