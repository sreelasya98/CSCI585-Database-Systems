-- Database Software used - MySQL Workbench 8.0 for Windows

-- Symptom IDs and their corresponding meanings : 1 - Fever, 2 - Sore Throat, 
-- 3 - Body Aches, 4 - Loss of taste/smell, 5 - Shortness of Breath

SELECT SYMPTOM_ID, MAX(SYMPTOM_COUNT) from 
(SELECT SYMPTOM_ID, count(SYMPTOM_ID) as SYMPTOM_COUNT from `covid_contact_tracing`.`self_report` 
group by SYMPTOM_ID ORDER BY SYMPTOM_COUNT DESC) 
AS REPORT;