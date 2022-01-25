-- Database Software used - MySQL Workbench 8.0 for Windows

-- The management would like stats, for a given period (between start, end dates), on the following: 
-- number of scans, number of tests, number of employees who self-reported symptoms, number of positive cases. 
-- Write queries to output these.

-- number of scans

SELECT COUNT(SCAN_ID) AS SCAN_COUNT FROM `covid_contact_tracing`.`scan` WHERE ((SCAN_DATE>='2021-10-09') AND (SCAN_DATE<='2021-10-12'));

-- (Alternate method)

SELECT COUNT(SCAN_ID) AS SCAN_COUNT FROM `covid_contact_tracing`.`scan` WHERE SCAN_DATE BETWEEN '2021-10-09' AND '2021-10-12';

-- number of tests

SELECT COUNT(TEST_ID) AS TEST_COUNT FROM `covid_contact_tracing`.`test` WHERE ((TEST_DATE>='2021-10-09') AND (TEST_DATE<='2021-10-12'));

-- (Alternate method)

SELECT COUNT(TEST_ID) AS TEST_COUNT FROM `covid_contact_tracing`.`test` WHERE TEST_DATE BETWEEN '2021-10-09' AND '2021-10-12';

-- number of employees who self-reported symptoms

SELECT COUNT(DISTINCT(EMP_ID)) AS SELF_REPORT_EMP_COUNT FROM `covid_contact_tracing`.`self_report` WHERE ((REPORT_DATE>='2021-10-09') AND (REPORT_DATE<='2021-10-12'));

-- (Alternate method)

SELECT COUNT(DISTINCT(EMP_ID)) AS SELF_REPORT_EMP_COUNT FROM `covid_contact_tracing`.`self_report` WHERE REPORT_DATE BETWEEN '2021-10-09' AND '2021-10-12';

-- number of positive cases

SELECT COUNT(TEST_ID) AS EMP_TEST_COUNT FROM `covid_contact_tracing`.`test` WHERE ((TEST_DATE>='2021-10-09') AND (TEST_DATE<='2021-10-12')) AND TEST_RESULT=1;

-- (Alternate method)

SELECT COUNT(TEST_ID) AS EMP_TEST_COUNT FROM `covid_contact_tracing`.`test` WHERE (TEST_DATE BETWEEN '2021-10-09' AND '2021-10-12') AND TEST_RESULT=1 ;
