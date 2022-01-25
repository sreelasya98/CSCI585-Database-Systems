-- Database Software used - MySQL Workbench 8.0 for Windows

-- CREATE TABLE Statements for all the entities:

CREATE TABLE `covid_contact_tracing`.`employee` (
  `EMP_ID` INT AUTO_INCREMENT,
  `EMP_NAME` VARCHAR(100) NOT NULL,
  `EMP_OFC_NO` VARCHAR(5) UNIQUE NOT NULL,
  `FLOOR_ID` INT NOT NULL,
  `EMP_PH_NO` VARCHAR(10) UNIQUE NOT NULL,
  `EMP_EMAIL` VARCHAR(100) UNIQUE,
  PRIMARY KEY (`EMP_ID`));
  
CREATE TABLE `covid_contact_tracing`.`meeting` (
  `MEETING_ID` INT AUTO_INCREMENT,
  `MEETING_ROOM_NAME` VARCHAR(20) UNIQUE NOT NULL,
  `FLOOR_ID` INT NOT NULL,
  `MEETING_DATE` DATE NOT NULL,
  `START_TIME` INT NOT NULL,
  `END_TIME` INT NOT NULL,
  CHECK (START_TIME>=8 AND START_TIME<=17),
  CHECK (END_TIME>=9 AND END_TIME<=18),
  CHECK (FLOOR_ID>=1 AND FLOOR_ID<=10),
  PRIMARY KEY (`MEETING_ID`));
  
ALTER TABLE `covid_contact_tracing`.`meeting` 
ADD COLUMN `EMP_ID` INT AFTER `END_TIME`;
ALTER TABLE `covid_contact_tracing`.`meeting` 
ADD CONSTRAINT `EMP_ID` FOREIGN KEY (`EMP_ID`)  REFERENCES `covid_contact_tracing`.`employee` (`EMP_ID`) 
  ON UPDATE CASCADE;

CREATE TABLE `covid_contact_tracing`.`employee_meeting_bridge` (
  `MEETING_ID` INT,
  `EMP_ID` INT,
  PRIMARY KEY (`MEETING_ID`, `EMP_ID`),
  FOREIGN KEY (`MEETING_ID`) REFERENCES meeting(`MEETING_ID`),
  FOREIGN KEY (`EMP_ID`) REFERENCES employee(`EMP_ID`));

CREATE TABLE `covid_contact_tracing`.`notification` (
  `NOTIF_ID` INT,
  `MEETING_ID` INT,
  `EMP_ID` INT,
  `NOTIF_DATE` DATE NOT NULL,
  `NOTIF_TYPE` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`NOTIF_ID`, `EMP_ID`),
  FOREIGN KEY (`MEETING_ID`) REFERENCES meeting(`MEETING_ID`),
  FOREIGN KEY (`EMP_ID`) REFERENCES employee(`EMP_ID`));
  
CREATE TABLE `covid_contact_tracing`.`self_report` (
  `REPORT_ID` INT AUTO_INCREMENT,
  `EMP_ID` INT,
  `REPORT_DATE` DATE NOT NULL,
  `SYMPTOM_ID` INT NOT NULL,
  PRIMARY KEY (`REPORT_ID`),
  FOREIGN KEY (`EMP_ID`) REFERENCES employee(`EMP_ID`),
  CHECK (SYMPTOM_ID>=1 AND SYMPTOM_ID<=5));
  
  
CREATE TABLE `covid_contact_tracing`.`scan` (
  `SCAN_ID` INT AUTO_INCREMENT,
  `EMP_ID` INT NOT NULL,
  `SCAN_DATE` DATE NOT NULL,
  `SCAN_TIME` VARCHAR(8) NOT NULL,
  `TEMPERATURE` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`SCAN_ID`),
  FOREIGN KEY (`EMP_ID`) REFERENCES employee(`EMP_ID`));
  

CREATE TABLE `covid_contact_tracing`.`test` (
  `TEST_ID` INT AUTO_INCREMENT,
  `TEST_DATE` DATE NOT NULL,
  `TEST_TIME` INT,
  `EMP_ID` INT NOT NULL,
  `TEST_LOCATION` VARCHAR(30) NOT NULL,
  `TEST_RESULT` INT NOT NULL,
  PRIMARY KEY (`TEST_ID`),
  FOREIGN KEY (`EMP_ID`) REFERENCES employee(`EMP_ID`));
  
  
CREATE TABLE `covid_contact_tracing`.`case` (
  `CASE_ID` INT AUTO_INCREMENT,
  `EMP_ID` INT NOT NULL,
  `CASE_DATE` DATE NOT NULL,
  `CASE_RESOLUTION` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`CASE_ID`),
  FOREIGN KEY (`EMP_ID`) REFERENCES employee(`EMP_ID`));
  

CREATE TABLE `covid_contact_tracing`.`health_status` (
  `STATUS_ID` INT AUTO_INCREMENT,
  `EMP_ID` INT NOT NULL,
  `REPORT_DATE` DATE NOT NULL,
  `CURRENT_STATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`STATUS_ID`),
  FOREIGN KEY (`EMP_ID`) REFERENCES employee(`EMP_ID`));







-- Sample Insert Statement for each entity:

INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Ozgur Atasoy', '5A221', 5, 9876543210, 'ozgur@mysql.com');

INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Colorado', 7, '2021-10-10', 9, 10, 14);

INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (2, 21);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-09', 'Morning', 98.30);

INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (28, '2021-10-10', 2);

INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-11', 12, 28, 'Network Clinic', 0);

INSERT INTO `covid_contact_tracing`.`case` (EMP_ID, CASE_DATE, CASE_RESOLUTION)
SELECT EMP_ID, TEST_DATE, 'In Quarantine' from `covid_contact_tracing`.`test` where TEST_RESULT=1;

INSERT INTO `covid_contact_tracing`.`case` (EMP_ID, CASE_DATE, CASE_RESOLUTION)
VALUES (26, '2021-09-15', 'Back to Work');

INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (25, '2021-10-12', 'Sick');

INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (1, 4, 13, '2021-10-12', 'Mandatory');





-- Complete Insert Statements Collection:

-- EMPLOYEE TABLE:
  
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Ozgur Atasoy', '5A221', 5, 9876543210, 'ozgur@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Ezgi Inal', '5A230', 5, 6549873210, 'ezgi@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Ozan Dincer', '4A230', 4, 3216549870, 'ozan@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Deniz Koparan', '4A229', 4, 4567891230, 'deniz@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Serder Osturk', '9A275', 9, 7894561230, 'serder@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Tolga Mendi', '10210', 10, 1234567890, 'tolga@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Serra Emaar', '6A150', 6, 1478523690, 'serra@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Levant', '6A230', 6, 8965320147, 'levant@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Cansu', '6B210', 6, 9638527410, 'cansu@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Yesim Osturk', '6B220', 6, 7418529630, 'yesim@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Burak Berhemis', '7A270', 7, 9865327410, 'burak@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Biricik Volde', '7B220', 7, 9764318520, 'biricik@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Asena Kutlusay', '8A250', 8, 7964130258, 'asena@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Esme Kutlusay', '8B110', 8, 5421369870, 'esme@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Sanem Aydin', '6A160', 6, 2165498730, 'sanem@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Leyla Bakkar', '6A240', 6, 9856320147, 'leyla@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Emre Divit', '7B266', 7, 5123987460, 'emre@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Can Divit', '8B224', 8, 8754219630, 'candivit@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Mevkibe Aydin', '9B222', 9, 9845632107, 'mevkibe@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Polen Aslam', '6B232', 6, 7598461230, 'polen@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Ehsan Kutlusay', '2A222', 2, 1425369870, 'ehsan@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Zeynep', '1B111', 1, 1634259870, 'zeynep@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Arthuro Capello', '3A313', 3, 1937256480, 'arthuro@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Zeyda Tomar', '1A102', 1, 4967582013, 'zeyda@mysql.com');
INSERT INTO `covid_contact_tracing`.`employee` (EMP_NAME, EMP_OFC_NO, FLOOR_ID, EMP_PH_NO, EMP_EMAIL) 
VALUES ('Mereban Aziz', '7B111', 7, 1598753460, 'mereban@mysql.com');

-- MEETING TABLE:

INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Colorado', 7, '2021-10-10', 9, 10, 14);
INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Connecticut', 7, '2021-10-10', 10, 12, 21);
INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Chicago', 8, '2021-10-11', 14, 15, 22);
INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Cleveland', 6, '2021-10-12', 12, 14, 24);
INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Claremont', 6, '2021-10-12', 11, 12, 11);
INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Bursa', 5, '2021-10-13', 12, 16, 25);
INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Gocek', 4, '2021-10-12', 10, 11, 5);
INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Copenhagen', 7, '2021-10-12', 11, 12, 29);
INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Dubai', 3, '2021-10-13', 9, 10, 27);
INSERT INTO `covid_contact_tracing`.`meeting` (MEETING_ROOM_NAME, FLOOR_ID, MEETING_DATE, START_TIME, END_TIME, EMP_ID) 
VALUES ('Istanbul', 6, '2021-10-14', 9, 10, 19);

-- EMPLOYEE_MEETING_BRIDGE:

INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (2, 21);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (2, 29);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (2, 14);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (2, 15);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (3, 22);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (3, 16);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (3, 18);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (4, 24);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (4, 20);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (4, 19);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (4, 13);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (4, 10);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (5, 11);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (5, 10);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (5, 12);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (5, 13);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (5, 19);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (5, 20);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (5, 24);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (7, 5);
INSERT INTO `covid_contact_tracing`.`employee_meeting_bridge` (MEETING_ID, EMP_ID) 
VALUES (7, 6);

-- SCAN TABLE:

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-09', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-09', 'Morning', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-09', 'Morning', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-09', 'Morning', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-09', 'Morning', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-09', 'Morning', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-09', 'Morning', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-09', 'Morning', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-09', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-09', 'Morning', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-09', 'Morning', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-09', 'Morning', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-09', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-09', 'Morning', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-09', 'Morning', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-09', 'Morning', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-09', 'Morning', 98.33);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-09', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-09', 'Evening', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-09', 'Evening', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-09', 'Evening', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-09', 'Evening', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-09', 'Evening', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-09', 'Evening', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-09', 'Evening', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-09', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-09', 'Evening', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-09', 'Evening', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-09', 'Evening', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-09', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-09', 'Evening', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-09', 'Evening', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-09', 'Evening', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-09', 'Evening', 98.33);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-10', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-10', 'Morning', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-10', 'Morning', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-10', 'Morning', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-10', 'Morning', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-10', 'Morning', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-10', 'Morning', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-10', 'Morning', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-10', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-10', 'Morning', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-10', 'Morning', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-10', 'Morning', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-10', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-10', 'Morning', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-10', 'Morning', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-10', 'Morning', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-10', 'Morning', 98.33);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-10', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-10', 'Evening', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-10', 'Evening', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-10', 'Evening', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-10', 'Evening', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-10', 'Evening', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-10', 'Evening', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-10', 'Evening', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-10', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-10', 'Evening', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-10', 'Evening', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-10', 'Evening', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-10', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-10', 'Evening', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-10', 'Evening', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-10', 'Evening', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-10', 'Evening', 98.33);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-11', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-11', 'Morning', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-11', 'Morning', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-11', 'Morning', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-11', 'Morning', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-11', 'Morning', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-11', 'Morning', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-11', 'Morning', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-11', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-11', 'Morning', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-11', 'Morning', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-11', 'Morning', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-11', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-11', 'Morning', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-11', 'Morning', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-11', 'Morning', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-11', 'Morning', 98.33);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-11', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-11', 'Evening', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-11', 'Evening', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-11', 'Evening', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-11', 'Evening', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-11', 'Evening', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-11', 'Evening', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-11', 'Evening', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-11', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-11', 'Evening', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-11', 'Evening', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-11', 'Evening', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-11', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-11', 'Evening', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-11', 'Evening', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-11', 'Evening', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-11', 'Evening', 98.33);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-12', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-12', 'Morning', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-12', 'Morning', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-12', 'Morning', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-12', 'Morning', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-12', 'Morning', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-12', 'Morning', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-12', 'Morning', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-12', 'Morning', 101.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-12', 'Morning', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-12', 'Morning', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-12', 'Morning', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-12', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-12', 'Morning', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-12', 'Morning', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-12', 'Morning', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-12', 'Morning', 98.33);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-12', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-12', 'Evening', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-12', 'Evening', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-12', 'Evening', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-12', 'Evening', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-12', 'Evening', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-12', 'Evening', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-12', 'Evening', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-12', 'Evening', 101.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-12', 'Evening', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-12', 'Evening', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-12', 'Evening', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-12', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-12', 'Evening', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-12', 'Evening', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-12', 'Evening', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-12', 'Evening', 98.33);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-13', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-13', 'Morning', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-13', 'Morning', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-13', 'Morning', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-13', 'Morning', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-13', 'Morning', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-13', 'Morning', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-13', 'Morning', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-13', 'Morning', 101.55);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-13', 'Morning', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-13', 'Morning', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-13', 'Morning', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-13', 'Morning', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-13', 'Morning', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-13', 'Morning', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-13', 'Morning', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-13', 'Morning', 98.33);

INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (14, '2021-10-13', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (15, '2021-10-13', 'Evening', 98.35);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (21, '2021-10-13', 'Evening', 98.37);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (29, '2021-10-13', 'Evening', 98.25);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (16, '2021-10-13', 'Evening', 98.38);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (18, '2021-10-13', 'Evening', 98.45);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (22, '2021-10-13', 'Evening', 98.00);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (10, '2021-10-13', 'Evening', 99.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (13, '2021-10-13', 'Evening', 101.62);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-13', 'Evening', 98.26);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (20, '2021-10-13', 'Evening', 99.27);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (24, '2021-10-13', 'Evening', 98.56);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (11, '2021-10-13', 'Evening', 98.30);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (12, '2021-10-13', 'Evening', 98.50);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (19, '2021-10-13', 'Evening', 98.36);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (5, '2021-10-13', 'Evening', 98.20);
INSERT INTO `covid_contact_tracing`.`scan` (EMP_ID, SCAN_DATE, SCAN_TIME, TEMPERATURE) 
VALUES (6, '2021-10-13', 'Evening', 98.33);


-- SELF_REPORT:

INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (28, '2021-10-10', 2);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (28, '2021-10-10', 3);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (25, '2021-10-10', 1);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (7, '2021-10-10', 3);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (7, '2021-10-10', 4);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (25, '2021-10-10', 3);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (25, '2021-10-10', 4);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (10, '2021-10-11', 1);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (10, '2021-10-11', 2);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (10, '2021-10-11', 3);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (20, '2021-10-11', 2);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (20, '2021-10-11', 3);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (20, '2021-10-11', 4);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (15, '2021-10-11', 1);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (15, '2021-10-11', 2);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (15, '2021-10-11', 5);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (13, '2021-10-12', 1);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (13, '2021-10-12', 2);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (13, '2021-10-12', 5);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (18, '2021-10-12', 2);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (18, '2021-10-12', 3);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (18, '2021-10-12', 4);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (24, '2021-10-13', 2);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (24, '2021-10-13', 3);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (24, '2021-10-13', 4);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (10, '2021-10-11', 3);
INSERT INTO `covid_contact_tracing`.`self_report` (EMP_ID, REPORT_DATE, SYMPTOM_ID) 
VALUES (15, '2021-10-11', 3);

-- TEST TABLE:

INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-11', 12, 28, 'Network Clinic', 0);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-11', 15, 25, 'Hospital', 0);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-11', 14, 7, 'Network Clinic', 0);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-12', 12, 25, 'Hospital', 1);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-12', 13, 10, 'Network Clinic', 1);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-12', 14, 20, 'Hospital', 0);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-12', 12, 29, 'Company', 1);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-12', 13, 6, 'Company', 1);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-13', 16, 13, 'Network Clinic', 1);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-13', 14, 18, 'Company', 1);
INSERT INTO `covid_contact_tracing`.`test` (TEST_DATE, TEST_TIME, EMP_ID, TEST_LOCATION, TEST_RESULT) 
VALUES ('2021-10-14', 13, 24, 'Company', 1);

-- CASE TABLE:

INSERT INTO `covid_contact_tracing`.`case` (EMP_ID, CASE_DATE, CASE_RESOLUTION)
SELECT EMP_ID, TEST_DATE, 'In Quarantine' from `covid_contact_tracing`.`test` where TEST_RESULT=1;

INSERT INTO `covid_contact_tracing`.`case` (EMP_ID, CASE_DATE, CASE_RESOLUTION)
VALUES (26, '2021-09-15', 'Back to Work');
INSERT INTO `covid_contact_tracing`.`case` (EMP_ID, CASE_DATE, CASE_RESOLUTION)
VALUES (16, '2021-07-12', 'Back to Work');
INSERT INTO `covid_contact_tracing`.`case` (EMP_ID, CASE_DATE, CASE_RESOLUTION)
VALUES (25, '2021-09-13', 'Hospitalized');
INSERT INTO `covid_contact_tracing`.`case` (EMP_ID, CASE_DATE, CASE_RESOLUTION)
VALUES (9, '2021-09-06', 'Deceased');


-- HEALTH_STATUS TABLE:

INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (25, '2021-10-12', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (10, '2021-10-12', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (29, '2021-10-12', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (6, '2021-10-12', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (25, '2021-10-13', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (10, '2021-10-13', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (29, '2021-10-13', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (6, '2021-10-13', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (13, '2021-10-13', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (18, '2021-10-13', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (25, '2021-10-14', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (10, '2021-10-14', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (29, '2021-10-14', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (6, '2021-10-14', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (13, '2021-10-14', 'Hospitalized');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (18, '2021-10-14', 'Sick');
INSERT INTO `covid_contact_tracing`.`health_status` (EMP_ID, REPORT_DATE, CURRENT_STATUS)
VALUES (24, '2021-10-14', 'Sick');

-- NOTIFICATION TABLE:

INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (1, 4, 13, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (1, 4, 19, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (1, 4, 20, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (1, 4, 24, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (2, 5, 13, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (2, 5, 19, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (2, 5, 20, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (2, 5, 24, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (2, 5, 11, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (2, 5, 12, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (3, 5, 13, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (3, 5, 19, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (3, 5, 20, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (3, 5, 24, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (3, 5, 11, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (3, 5, 12, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (4, 2, 14, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (4, 2, 15, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (4, 2, 21, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (5, 2, 14, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (5, 2, 15, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (5, 2, 21, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (6, 7, 5, '2021-10-12', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (7, 7, 5, '2021-10-12', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (8, 4, 10, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (8, 4, 19, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (8, 4, 20, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (8, 4, 24, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (9, 4, 10, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (9, 4, 11, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (9, 4, 19, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (9, 4, 20, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (9, 4, 24, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (9, 4, 12, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (10, 4, 10, '2021-10-13', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (10, 4, 11, '2021-10-13', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (10, 4, 19, '2021-10-13', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (10, 4, 20, '2021-10-13', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (10, 4, 24, '2021-10-13', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (10, 4, 12, '2021-10-13', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (10, 3, 16, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (10, 3, 22, '2021-10-13', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (11, 3, 16, '2021-10-13', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (11, 3, 22, '2021-10-13', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (12, 4, 10, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (12, 4, 13, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (12, 4, 19, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (12, 4, 20, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (13, 5, 10, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (13, 5, 13, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (13, 5, 19, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (13, 5, 20, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (13, 5, 12, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (13, 5, 11, '2021-10-14', 'Mandatory');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (14, 5, 10, '2021-10-14', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (14, 5, 13, '2021-10-14', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (14, 5, 19, '2021-10-14', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (14, 5, 20, '2021-10-14', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (14, 5, 12, '2021-10-14', 'Optional');
INSERT INTO `covid_contact_tracing`.`notification` (NOTIF_ID, MEETING_ID, EMP_ID, NOTIF_DATE, NOTIF_TYPE)
VALUES (14, 5, 11, '2021-10-14', 'Optional');



  


 
  
