Database Systems - CSCI 585 - Assignment 2 - README File

-- Database Software used - MySQL Workbench 8.0 for Windows --

Design Considerations:

* Entities and columns - Barebone structure:

EMPLOYEE - (EMP_ID), EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL

NOTIFICATION - (NOTIF_ID, EMP_ID), NOTIF_DATE, NOTIF_TYPE (mandatory, optional)

Here, I have used a composite key to ensure that the same Notification ID is used for each multicast that serves to mandate testing among fellow employees who were in the same meeting room as the affected employee. Each notification sent to different employees can be uniquely identified using Notification ID, Emp ID.

Also, a notification is sent to every employee who has been in close proximity, has attended the same meetings as an employee who has tested "positive", for the last 3 days (current day, previous day, the day before the previous day).
 
EMPLOYEE_MEETING_BRIDGE - (MEETING_ID, EMP_ID)

MEETING - (MEETING_ID), MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME (int between 8 to 18), END_TIME (int between 9 to 18)

SELF_REPORT - (REPORT_ID), EMP_ID, REPORT_DATE, SYMPTOM_ID (1 to 5) (1-Fever, 2-Sore Throat, 3-Body Aches, 4-Loss of taste/smell, 5-Shortness of Breath)

SCAN - (SCAN_ID), SCAN_DATE, SCAN_TIME (Morning/Evening), EMP_ID, TEMPERATURE

TEST - (TEST_ID), TEST_LOCATION (one among : company, hospital, network clinic) TEST_DATE, TEST_TIME, EMP_ID, TEST_RESULT(positive/negative)(represented by 1 for pos/0 for neg)

CASE - (CASE_ID), EMP_ID, CASE_DATE, CASE_RESOLUTION (one among: back to work, in quarantine, hospitalized, deceased)

HEALTH_STATUS - (STATUS_ID), EMP_ID, REPORT_DATE, STATUS (sick, hospitalized, well)

Question wise-approach:

Q1. Created the tables according to the aforementioned skeleton having check constraints for ensuring correct entry of meeting start/end times, floor ids and so on. Verified the correctness and working of these constraints while loading input data.

Q2. For this question, I have returned the value of the SYMPTOM_ID that has been reported maximum number of times by the employees, and have also returned the correspoding maximum frequency of the so-returned symptom value so as to ensure quick verification of the correctness of my result.

Q3. Sickest floor: I have interpreted the meaning of "Sickest floor" to be the value of the Floor ID of a given floor on a PARTICULAR DATE, when the FLOOR has maximum number of sick employees, who are those employees who have reported their status as "Sick" or "Hospitalized" in the "Health_Status" table on that PARTICULAR GIVEN DATE.

Eg: My query can be interpreted as: which is the sickest floor on "date"?

Q4. I have written separate queries to return the number of scans, tests, employees who self-reported symptoms and positive cases respectively.

For yielding the number of positive cases between 2 given dates, I have utilized the "Test" entity instead of the Case entity as I have designed the Case entity to store only the final resolution of an employee's health condition (back to work, in quarantine, hospitalized, deceased). I have opined that counting the number of employees who got "tested and resulted positive" between the given dates would provide a more accurate response to number of positive cases at a given point, rather than counting "in quarantine/hospitalized" candidates.

Q5. For this question, I have written a query that serves to identify a symptom that has been reported by employees maximum number of times on a given day, and returns the date and the symptom ID of such a symptom.

SELECT REPORT_DATE, SYMPTOM_ID, MAX(SYMPTOM_COUNT) FROM
(SELECT REPORT_DATE, SYMPTOM_ID, count(SYMPTOM_ID) as SYMPTOM_COUNT from `covid_contact_tracing`.`self_report` 
group by SYMPTOM_ID ORDER BY SYMPTOM_COUNT DESC) AS REPORT_SUMMARY GROUP BY REPORT_DATE;

Output: 

2021-10-10	3	8
2021-10-11	5	2
.
.
.
.
.

-- END OF FILE --

