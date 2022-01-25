-- Database Software used - MySQL Workbench 8.0 for Windows

--  Create your own query! 

-- Write a query that returns the most self-reported symptom and its corresponding frequency, date-wise.

SELECT REPORT_DATE, SYMPTOM_ID, MAX(SYMPTOM_COUNT) FROM
(SELECT REPORT_DATE, SYMPTOM_ID, count(SYMPTOM_ID) as SYMPTOM_COUNT from `covid_contact_tracing`.`self_report` 
group by SYMPTOM_ID ORDER BY SYMPTOM_COUNT DESC) AS REPORT_SUMMARY GROUP BY REPORT_DATE;

