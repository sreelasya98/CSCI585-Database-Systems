-- Database Software used - MySQL Workbench 8.0 for Windows

-- Query to output the sickest floor

SELECT FLOOR_ID, MAX(FLOOR_COUNT) AS NUMBER_OF_CASES_ON_FLOOR FROM
(SELECT FLOOR_ID, COUNT(`covid_contact_tracing`.`employee`.FLOOR_ID) AS FLOOR_COUNT
FROM `covid_contact_tracing`.`employee` JOIN `covid_contact_tracing`.`health_status`
WHERE ( (`covid_contact_tracing`.`employee`.EMP_ID = `covid_contact_tracing`.`health_status`.EMP_ID) AND
(`covid_contact_tracing`.`health_status`.CURRENT_STATUS = 'Sick' OR 
`covid_contact_tracing`.`health_status`.CURRENT_STATUS = 'Hospitalized') AND
REPORT_DATE = '2021-10-14') GROUP BY FLOOR_ID ORDER BY FLOOR_COUNT DESC) AS FLOOR_COUNT_JOIN_TABLE;