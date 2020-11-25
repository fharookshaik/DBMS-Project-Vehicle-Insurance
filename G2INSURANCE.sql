DROP database if exists G2INSURANCE;
CREATE DATABASE G2INSURANCE;
USE G2INSURANCE;

CREATE TABLE G2INCIDENT
(
Incident_Id VARCHAR(20) NOT NULL ,
Incident_Type VARCHAR(100) NULL ,
Incident_Date DATE NOT NULL ,
Incident_description VARCHAR(500) NULL ,
constraint PKINCIDENT PRIMARY KEY (Incident_Id)
);
CREATE UNIQUE INDEX idxg2incident ON G2INCIDENT (Incident_Id ASC); 

CREATE TABLE G2CUSTOMER
(
Cust_Id VARCHAR(20) NOT NULL ,
Cust_FName VARCHAR(50) NOT NULL ,
Cust_LName VARCHAR(50) NOT NULL ,
Cust_DOB DATE NOT NULL ,
Cust_Gender CHAR(2) NOT NULL ,
Cust_Address VARCHAR(50) NOT NULL ,
Cust_MOB_Number BIGINT NOT NULL ,
Cust_Email VARCHAR(30) NULL ,
Cust_Passport_Number VARCHAR(25) NULL ,
Cust_Marital_Status CHAR(10) NULL ,
Cust_PPS_Number INTEGER NULL ,
constraint PKCUSTOMER PRIMARY KEY (Cust_Id)
);
CREATE UNIQUE INDEX idxg2customer ON G2CUSTOMER (cust_Id ASC);

CREATE TABLE G2INCIDENT_REPORT 
(
Incident_Report_Id VARCHAR(20) NOT NULL ,
Incident_Type CHAR(100) NULL ,
Incident_Inspector VARCHAR(50) NULL ,
Incident_Cost INTEGER NULL ,
Incident_Report_Description VARCHAR(500) NULL ,
Incident_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKINCREPORT PRIMARY KEY(Incident_Report_Id,Incident_Id,Cust_Id),
constraint FKINCREPORT_INCIDENT FOREIGN KEY (Incident_Id) REFERENCES G2INCIDENT (Incident_Id),
constraint FKINCREPORT_CUSTOMER FOREIGN KEY (Cust_Id) REFERENCES G2CUSTOMER (Cust_Id)
);
CREATE UNIQUE INDEX idxg2incidentreport ON G2INCIDENT_REPORT
(Incident_Report_Id ASC,Incident_Id ASC,Cust_Id ASC);


CREATE TABLE G2INSURANCE_COMPANY
(
Company_Name VARCHAR(100) NOT NULL ,
Company_Address VARCHAR(400) NULL ,
Company_Contact_Number BIGINT NULL ,
Company_Fax BIGINT NULL ,
Company_Email VARCHAR(50) NULL ,
Company_Website VARCHAR(70) NULL ,
Company_Location VARCHAR(100) NULL,
Company_Department_Name VARCHAR(100) NULL ,
Company_Office_Name VARCHAR(100) NULL ,
constraint PKINSCOMPANY PRIMARY KEY (Company_Name)
);
CREATE UNIQUE INDEX idxg2insurancecompany ON G2INSURANCE_COMPANY (Company_Name ASC);



CREATE TABLE G2DEPARTMENT
(
Department_Name VARCHAR(50) NOT NULL ,
Department_ID VARCHAR(20) NOT NULL ,
Department_Staff VARCHAR(50) NULL ,
Company_Name VARCHAR(200) NOT NULL ,
constraint PKDEPARTMENT PRIMARY KEY (Department_Name,Department_ID,Company_Name),
constraint FKDEPARTMENT FOREIGN KEY (Company_Name) REFERENCES G2INSURANCE_COMPANY (Company_Name)
);
CREATE UNIQUE INDEX idxg2department ON G2DEPARTMENT(Department_Name ASC,Department_ID ASC,Company_Name ASC);


CREATE TABLE G2VEHICLE_SERVICE
(
Department_Name VARCHAR(50) NOT NULL ,
Vehicle_Service_Company_Name VARCHAR(50) NOT NULL ,
Vehicle_Service_Address VARCHAR(40) NULL ,
Vehicle_Service_Contact VARCHAR(20) NULL ,
Vehicle_Service_Incharge VARCHAR(30) NULL ,
Vehicle_Service_Type VARCHAR(30) NULL,
Department_Id VARCHAR(20) NOT NULL ,
Company_Name VARCHAR(200) NOT NULL ,
constraint PKVEHINSURANCE PRIMARY KEY (Vehicle_Service_Company_Name,Department_Name),
constraint FKVEHINSURANCE FOREIGN KEY (Department_Name, Department_Id,Company_Name) REFERENCES G2DEPARTMENT (Department_Name,Department_ID, Company_Name)
);
CREATE UNIQUE INDEX idxg2vehicleservice ON G2VEHICLE_SERVICE(Vehicle_Service_Company_Name ASC,Department_Name ASC);


CREATE TABLE G2VEHICLE
(
Vehicle_Id VARCHAR(20) NOT NULL ,
Policy_Id VARCHAR(20) NULL ,
Vehicle_Registration_Number VARCHAR(20) NOT NULL ,
Vehicle_Value INTEGER NULL ,
Vehicle_Type VARCHAR(20) NOT NULL ,
Vehicle_Size INTEGER NULL ,
Vehicle_Number_Of_Seat INTEGER NULL ,
Vehicle_Manufacturer VARCHAR(20) NULL ,
Vehicle_Engine_Number INTEGER NULL ,
Vehicle_Chasis_Number INTEGER NULL ,
Vehicle_Number VARCHAR(20) NULL ,
Vehicle_Model_Number VARCHAR(20) NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKVEHICLE PRIMARY KEY (Vehicle_Id,Cust_Id),
constraint FKVEHICLE FOREIGN KEY (Cust_Id) REFERENCES G2CUSTOMER (Cust_Id)
);
CREATE UNIQUE INDEX idxg2vehicle ON G2VEHICLE (Vehicle_Id ASC,Cust_Id ASC);


CREATE TABLE G2PREMIUM_PAYMENT
(
Premium_Payment_Id VARCHAR(20) NOT NULL ,
Policy_Number VARCHAR(20) NOT NULL ,
Premium_Payment_Amount BIGINT NOT NULL ,
Premium_Payment_Schedule DATE NOT NULL ,
Receipt_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKPREPAYMENT PRIMARY KEY (Premium_Payment_Id,Cust_Id),
constraint FKPREPAYMENT FOREIGN KEY (Cust_Id) REFERENCES G2CUSTOMER (Cust_Id)
);
CREATE UNIQUE INDEX idxg2premiumpayment ON G2PREMIUM_PAYMENT (Premium_Payment_Id ASC,Cust_Id ASC);


CREATE TABLE G2RECEIPT
(
Receipt_Id VARCHAR(20) NOT NULL ,
Time DATE NOT NULL ,
Cost INTEGER NOT NULL ,
Premium_Payment_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKRECEIPT PRIMARY KEY (Receipt_Id,Premium_Payment_Id,Cust_Id),
constraint FKRECEIPT FOREIGN KEY (Premium_Payment_Id, Cust_Id) REFERENCES G2PREMIUM_PAYMENT (Premium_Payment_Id, Cust_Id)
);
CREATE UNIQUE INDEX idxg2receipt ON G2RECEIPT (Receipt_Id ASC,Premium_Payment_Id ASC,Cust_Id ASC);


CREATE TABLE G2APPLICATION
(
Application_Id VARCHAR(20) NOT NULL ,
Vehicle_Id VARCHAR(20) NOT NULL ,
Application_Status CHAR(8) NOT NULL ,
Coverage VARCHAR(50) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKAPPLICATION PRIMARY KEY (Application_Id,Cust_Id),
constraint FKAPPLICATION FOREIGN KEY (Cust_Id) REFERENCES G2CUSTOMER (Cust_Id)
);
CREATE UNIQUE INDEX idxg2application ON G2APPLICATION (Application_Id ASC,Cust_Id ASC);

CREATE TABLE G2INSURANCE_POLICY
(
Agreement_id VARCHAR(20) NOT NULL ,
Department_Name VARCHAR(20) NULL ,
Policy_Number VARCHAR(20) NULL ,
Start_Date DATE NULL ,
Expiry_Date DATE NULL ,
Term_Condition_Description VARCHAR(500) NULL ,
Application_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKINSPOLICY PRIMARY KEY (Agreement_id,Application_Id,Cust_Id),
constraint FKINSPOLICY FOREIGN KEY (Application_Id, Cust_Id) REFERENCES G2APPLICATION (Application_Id, Cust_Id)
);
CREATE UNIQUE INDEX idxg2insurancepolicy ON G2INSURANCE_POLICY (Agreement_id ASC,Application_Id ASC,Cust_Id ASC);


CREATE TABLE G2POLICY_RENEWABLE
(
Policy_Renewable_Id VARCHAR(20) NOT NULL ,
Date_Of_Renewal DATE NOT NULL ,
Type_Of_Renewal CHAR(15) NOT NULL ,
Agreement_id VARCHAR(20) NOT NULL ,
Application_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKPOLRENEWABLE PRIMARY KEY (Policy_Renewable_Id,Agreement_id,Application_Id,Cust_Id),
constraint FKPOLRENEWABLE FOREIGN KEY (Agreement_id, Application_Id, Cust_Id) REFERENCES G2INSURANCE_POLICY (Agreement_id, Application_Id, Cust_Id)
);
CREATE UNIQUE INDEX idxg2policyrenewable ON G2POLICY_RENEWABLE (Policy_Renewable_Id ASC,Agreement_id ASC,Application_Id ASC,Cust_Id ASC);

CREATE TABLE G2MEMBERSHIP
(
Membership_Id VARCHAR(20) NOT NULL ,
Membership_Type CHAR(15) NOT NULL ,
Organisation_Contact VARCHAR(20) NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKMEMBERSHIP PRIMARY KEY (Membership_Id,Cust_Id),
constraint FKMEMBERSHIP FOREIGN KEY (Cust_Id) REFERENCES G2CUSTOMER (Cust_Id)
);
CREATE UNIQUE INDEX idxg2membership ON G2MEMBERSHIP (Membership_Id ASC,Cust_Id ASC);


CREATE table G2QUOTE
(
Quote_Id VARCHAR(20) NOT NULL ,
Issue_Date DATE NOT NULL ,
Valid_From_Date DATE NOT NULL ,
Valid_Till_Date DATE NOT NULL ,
Quote_Description VARCHAR(500) NULL ,
Product_Id VARCHAR(20) NOT NULL ,
Coverage_Level VARCHAR(20) NOT NULL ,
Application_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKQUOTE PRIMARY KEY(Quote_Id,Application_Id,Cust_Id),
constraint FKQUOTE FOREIGN KEY (Application_Id, Cust_Id) REFERENCES G2APPLICATION (Application_Id, Cust_Id)
);
CREATE UNIQUE INDEX idxg2quota ON G2QUOTE
(Quote_Id ASC,Application_Id ASC,Cust_Id ASC);

CREATE TABLE G2STAFF
(
Staff_Id VARCHAR(20) NOT NULL ,
Staff_Fname VARCHAR(50) NULL ,
Staff_LName VARCHAR(50) NULL ,
Staff_Adress VARCHAR(50) NULL ,
Staff_Contact BIGINT NULL ,
Staff_Gender CHAR(2) NULL ,
Staff_Marital_Status CHAR(8) NULL ,
Staff_Nationality CHAR(15) NULL ,
Staff_Qualification VARCHAR(20) NULL ,
Staff_Allowance INTEGER NULL ,
Staff_PPS_Number INTEGER NULL ,
Company_Name VARCHAR(200) NOT NULL ,
constraint PKSTAFF PRIMARY KEY (Staff_Id,Company_Name),
constraint FKSTAFF FOREIGN KEY (Company_Name) REFERENCES G2INSURANCE_COMPANY (Company_Name)
);
CREATE UNIQUE INDEX idxg2staff ON G2STAFF (Staff_Id ASC,Company_Name ASC);

CREATE TABLE G2NOK
(
Nok_Id VARCHAR(20) NOT NULL ,
Nok_Name VARCHAR(30) NULL ,
Nok_Address VARCHAR(20) NULL ,
Nok_Phone_Number BIGINT NULL ,
Nok_Gender CHAR(2) NULL ,
Nok_Marital_Status CHAR(8) NULL ,
Agreement_id VARCHAR(20) NOT NULL ,
Application_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
PRIMARY KEY (Nok_Id,Agreement_id,Application_Id,Cust_Id),
FOREIGN KEY (Agreement_id, Application_Id, Cust_Id) REFERENCES G2INSURANCE_POLICY (Agreement_id, Application_Id, Cust_Id)
);
CREATE UNIQUE INDEX idxg2nok ON G2NOK (Nok_Id ASC,Agreement_id ASC,Application_Id ASC);


CREATE TABLE G2PRODUCT
(
Product_Price INTEGER NULL ,
Product_Type CHAR(15) NULL ,
Product_Number VARCHAR(50) NOT NULL ,
Company_Name VARCHAR(200) NOT NULL ,
constraint PKPRODUCT PRIMARY KEY (Product_Number,Company_Name),
constraint FKPRODUCT FOREIGN KEY (Company_Name) REFERENCES G2INSURANCE_COMPANY (Company_Name)
);
CREATE UNIQUE INDEX idxg2product ON G2PRODUCT(Product_Number ASC,Company_Name ASC);

CREATE TABLE G2OFFICE
(
Office_Name VARCHAR(20) NOT NULL ,
Office_Leader VARCHAR(20) NOT NULL ,
Contact_Information VARCHAR(20) NOT NULL ,
Address VARCHAR(20) NOT NULL ,
Admin_Cost INTEGER NULL ,
Department_Name VARCHAR(200) NOT NULL ,
Department_ID VARCHAR(200) NOT NULL,
Company_Name VARCHAR(200) NOT NULL ,
constraint PKOFFICE PRIMARY KEY (Office_Name,Department_Name,Company_Name),
constraint FKOFFICE FOREIGN KEY (Department_Name,Department_ID,Company_Name) REFERENCES G2DEPARTMENT (Department_Name,Department_ID,Company_Name)
);
CREATE UNIQUE INDEX idxg2office ON G2OFFICE(Office_Name ASC,Department_Name ASC,Company_Name ASC);


CREATE TABLE G2COVERAGE
(
Coverage_Id VARCHAR(20) NOT NULL ,
Coverage_Amount INTEGER NOT NULL ,
Coverage_Type CHAR(10) NOT NULL ,
Coverage_Level CHAR(15) NOT NULL ,
Product_Id VARCHAR(20) NOT NULL ,
Covearge_Terms VARCHAR(500) NULL ,
Company_Name VARCHAR(200) NOT NULL ,
PRIMARY KEY (Coverage_Id,Company_Name),
FOREIGN KEY (Company_Name) REFERENCES G2INSURANCE_COMPANY (Company_Name)
);
CREATE UNIQUE INDEX idxg2coverage ON G2COVERAGE (Coverage_Id ASC,Company_Name ASC);


CREATE TABLE G2INSURANCE_POLICY_COVERAGE
(
Agreement_id VARCHAR(20) NOT NULL ,
Application_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
Coverage_Id VARCHAR(20) NOT NULL ,
Company_Name VARCHAR(200) NOT NULL ,
constraint PKINSPOLCOVER PRIMARY KEY (Agreement_id,Application_Id,Cust_Id,Coverage_Id,Company_Name),
constraint FKINSPOLCOVER_1 FOREIGN KEY (Agreement_id, Application_Id, Cust_Id) REFERENCES G2INSURANCE_POLICY (Agreement_id, Application_Id, Cust_Id),
constraint FKINSPOLCOVER_2 FOREIGN KEY (Coverage_Id, Company_Name) REFERENCES G2COVERAGE (Coverage_Id, Company_Name)
);
CREATE UNIQUE INDEX idxg2insurancepolicycoverage ON G2INSURANCE_POLICY_COVERAGE
(Agreement_id ASC,Application_Id ASC,Cust_Id ASC,Coverage_Id ASC,Company_Name ASC);


CREATE TABLE G2CLAIM
(
Claim_Id VARCHAR(20) NOT NULL ,
Agreement_Id VARCHAR(20) NOT NULL ,
Claim_Amount INTEGER NOT NULL ,
Incident_Id VARCHAR(20) NOT NULL ,
Damage_Type VARCHAR(200) NOT NULL ,
Date_Of_Claim DATE NOT NULL ,
Claim_Status CHAR(100) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKCLAIM PRIMARY KEY (Claim_Id,Cust_Id),
constraint FKCLAIM FOREIGN KEY (Cust_Id) REFERENCES G2CUSTOMER (Cust_Id)
);
CREATE UNIQUE INDEX idxg2claim ON G2CLAIM (Claim_Id ASC,Cust_Id ASC);


CREATE TABLE G2CLAIM_SETTLEMENT
(
Claim_Settlement_Id VARCHAR(20) NOT NULL ,
Vehicle_Id VARCHAR(20) NOT NULL ,
Date_Settled DATE NOT NULL ,
Amount_Paid INTEGER NOT NULL ,
Coverage_Id VARCHAR(20) NOT NULL ,
Claim_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
constraint PKSETTLEMENT PRIMARY KEY (Claim_Settlement_Id,Claim_Id,Cust_Id),
constraint FKSETTLEMENT FOREIGN KEY (Claim_Id, Cust_Id) REFERENCES G2CLAIM (Claim_Id, Cust_Id)
);
CREATE UNIQUE INDEX idxg2claimsettlement ON G2CLAIM_SETTLEMENT
(Claim_Settlement_Id ASC,Claim_Id ASC,Cust_Id ASC);