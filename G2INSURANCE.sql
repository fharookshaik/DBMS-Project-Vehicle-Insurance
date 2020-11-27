DROP database if exists G2INSURANCE;
CREATE DATABASE G2INSURANCE;
USE G2INSURANCE;

CREATE TABLE G2INCIDENT
(
G2Incident_Id VARCHAR(20) NOT NULL ,
G2Incident_Type VARCHAR(100) NULL ,
G2Incident_Date DATE NOT NULL ,
G2Incident_description VARCHAR(500) NULL ,
constraint PKINCIDENT PRIMARY KEY (G2Incident_Id)
);
CREATE UNIQUE INDEX idxg2incident ON G2INCIDENT (G2Incident_Id ASC); 

CREATE TABLE G2CUSTOMER
(
G2Cust_Id VARCHAR(20) NOT NULL ,
G2Cust_FName VARCHAR(50) NOT NULL ,
G2Cust_LName VARCHAR(50) NOT NULL ,
G2Cust_DOB DATE NOT NULL ,
G2Cust_Gender CHAR(2) NOT NULL ,
G2Cust_G2Address VARCHAR(50) NOT NULL ,
G2Cust_MOB_Number BIGINT NOT NULL ,
G2Cust_Email VARCHAR(30) NULL ,
G2Cust_Passport_Number VARCHAR(25) NULL ,
G2Cust_Marital_Status CHAR(10) NULL ,
G2Cust_PPS_Number INTEGER NULL ,
constraint PKCUSTOMER PRIMARY KEY (G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2customer ON G2CUSTOMER (G2Cust_Id ASC);

CREATE TABLE G2Incident_REPORT 
(
G2Incident_Report_Id VARCHAR(20) NOT NULL ,
G2Incident_Type CHAR(100) NULL ,
G2Incident_Inspector VARCHAR(50) NULL ,
G2Incident_Cost INTEGER NULL ,
G2Incident_Report_Description VARCHAR(500) NULL ,
G2Incident_Id VARCHAR(20) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKINCREPORT PRIMARY KEY(G2Incident_Report_Id,G2Incident_Id,G2Cust_Id),
constraint FKINCREPORT_INCIDENT FOREIGN KEY (G2Incident_Id) REFERENCES G2INCIDENT (G2Incident_Id),
constraint FKINCREPORT_CUSTOMER FOREIGN KEY (G2Cust_Id) REFERENCES G2CUSTOMER (G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2incidentreport ON G2Incident_REPORT
(G2Incident_Report_Id ASC,G2Incident_Id ASC,G2Cust_Id ASC);


CREATE TABLE G2INSURANCE_COMPANY
(
G2Company_Name VARCHAR(100) NOT NULL ,
G2Company_Address VARCHAR(400) NULL ,
G2Company_Contact_Number BIGINT NULL ,
G2Company_Fax BIGINT NULL ,
G2Company_Email VARCHAR(50) NULL ,
G2Company_Website VARCHAR(70) NULL ,
G2Company_Location VARCHAR(100) NULL,
G2Company_Department_Name VARCHAR(100) NULL ,
G2Company_Office_Name VARCHAR(100) NULL ,
constraint PKINSCOMPANY PRIMARY KEY (G2Company_Name)
);
CREATE UNIQUE INDEX idxg2insurancecompany ON G2INSURANCE_COMPANY (G2Company_Name ASC);



CREATE TABLE G2DEPARTMENT
(
G2Department_Name VARCHAR(50) NOT NULL ,
G2Department_ID VARCHAR(20) NOT NULL ,
G2Department_Staff VARCHAR(50) NULL ,
G2Company_Name VARCHAR(200) NOT NULL ,
constraint PKDEPARTMENT PRIMARY KEY (G2Department_Name,G2Department_ID,G2Company_Name),
constraint FKDEPARTMENT FOREIGN KEY (G2Company_Name) REFERENCES G2INSURANCE_COMPANY (G2Company_Name)
);
CREATE UNIQUE INDEX idxg2department ON G2DEPARTMENT(G2Department_Name ASC,G2Department_ID ASC,G2Company_Name ASC);


CREATE TABLE G2Vehicle_SERVICE
(
G2Department_Name VARCHAR(50) NOT NULL ,
G2Vehicle_Service_Company_Name VARCHAR(50) NOT NULL ,
G2Vehicle_Service_Address VARCHAR(40) NULL ,
G2Vehicle_Service_Contact VARCHAR(20) NULL ,
G2Vehicle_Service_Incharge VARCHAR(30) NULL ,
G2Vehicle_Service_Type VARCHAR(30) NULL,
G2Department_Id VARCHAR(20) NOT NULL ,
G2Company_Name VARCHAR(200) NOT NULL ,
constraint PKVEHINSURANCE PRIMARY KEY (G2Vehicle_Service_Company_Name,G2Department_Name),
constraint FKVEHINSURANCE FOREIGN KEY (G2Department_Name, G2Department_Id,G2Company_Name) REFERENCES G2DEPARTMENT (G2Department_Name,G2Department_ID, G2Company_Name)
);
CREATE UNIQUE INDEX idxg2vehicleservice ON G2Vehicle_SERVICE(G2Vehicle_Service_Company_Name ASC,G2Department_Name ASC);


CREATE TABLE G2VEHICLE
(
G2Vehicle_Id VARCHAR(20) NOT NULL ,
G2Policy_Id VARCHAR(20) NULL ,
G2Vehicle_Registration_Number VARCHAR(20) NOT NULL ,
G2Vehicle_Value INTEGER NULL ,
G2Vehicle_Type VARCHAR(20) NOT NULL ,
G2Vehicle_Size INTEGER NULL ,
G2Vehicle_Number_Of_Seat INTEGER NULL ,
G2Vehicle_Manufacturer VARCHAR(20) NULL ,
G2Vehicle_Engine_Number INTEGER NULL ,
G2Vehicle_Chasis_Number INTEGER NULL ,
G2Vehicle_Number VARCHAR(20) NULL ,
G2Vehicle_Model_Number VARCHAR(20) NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKVEHICLE PRIMARY KEY (G2Vehicle_Id,G2Cust_Id),
constraint FKVEHICLE FOREIGN KEY (G2Cust_Id) REFERENCES G2CUSTOMER (G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2vehicle ON G2VEHICLE (G2Vehicle_Id ASC,G2Cust_Id ASC);


CREATE TABLE G2PREMIUM_PAYMENT
(
G2Premium_Payment_Id VARCHAR(20) NOT NULL ,
G2Policy_Number VARCHAR(20) NOT NULL ,
G2Premium_Payment_Amount BIGINT NOT NULL ,
G2Premium_Payment_Schedule DATE NOT NULL ,
G2Receipt_Id VARCHAR(20) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKPREPAYMENT PRIMARY KEY (G2Premium_Payment_Id,G2Cust_Id),
constraint FKPREPAYMENT FOREIGN KEY (G2Cust_Id) REFERENCES G2CUSTOMER (G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2premiumpayment ON G2PREMIUM_PAYMENT (G2Premium_Payment_Id ASC,G2Cust_Id ASC);


CREATE TABLE G2RECEIPT
(
G2Receipt_Id VARCHAR(20) NOT NULL ,
G2Time DATE NOT NULL ,
G2Cost INTEGER NOT NULL ,
G2Premium_Payment_Id VARCHAR(20) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKRECEIPT PRIMARY KEY (G2Receipt_Id,G2Premium_Payment_Id,G2Cust_Id),
constraint FKRECEIPT FOREIGN KEY (G2Premium_Payment_Id, G2Cust_Id) REFERENCES G2PREMIUM_PAYMENT (G2Premium_Payment_Id, G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2receipt ON G2RECEIPT (G2Receipt_Id ASC,G2Premium_Payment_Id ASC,G2Cust_Id ASC);


CREATE TABLE G2APPLICATION
(
G2Application_Id VARCHAR(20) NOT NULL ,
G2Vehicle_Id VARCHAR(20) NOT NULL ,
G2Application_Status CHAR(8) NOT NULL ,
G2Coverage VARCHAR(50) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKAPPLICATION PRIMARY KEY (G2Application_Id,G2Cust_Id),
constraint FKAPPLICATION FOREIGN KEY (G2Cust_Id) REFERENCES G2CUSTOMER (G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2application ON G2APPLICATION (G2Application_Id ASC,G2Cust_Id ASC);

CREATE TABLE G2INSURANCE_POLICY
(
G2Agreement_id VARCHAR(20) NOT NULL ,
G2Department_Name VARCHAR(20) NULL ,
G2Policy_Number VARCHAR(20) NULL ,
G2Start_Date DATE NULL ,
G2Expiry_Date DATE NULL ,
G2Term_Condition_Description VARCHAR(500) NULL ,
G2Application_Id VARCHAR(20) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKINSPOLICY PRIMARY KEY (G2Agreement_id,G2Application_Id,G2Cust_Id),
constraint FKINSPOLICY FOREIGN KEY (G2Application_Id, G2Cust_Id) REFERENCES G2APPLICATION (G2Application_Id, G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2insurancepolicy ON G2INSURANCE_POLICY (G2Agreement_id ASC,G2Application_Id ASC,G2Cust_Id ASC);


CREATE TABLE G2Policy_RENEWABLE
(
G2Policy_Renewable_Id VARCHAR(20) NOT NULL ,
G2Date_Of_Renewal DATE NOT NULL ,
G2Type_Of_Renewal CHAR(15) NOT NULL ,
G2Agreement_id VARCHAR(20) NOT NULL ,
G2Application_Id VARCHAR(20) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKPOLRENEWABLE PRIMARY KEY (G2Policy_Renewable_Id,G2Agreement_id,G2Application_Id,G2Cust_Id),
constraint FKPOLRENEWABLE FOREIGN KEY (G2Agreement_id, G2Application_Id, G2Cust_Id) REFERENCES G2INSURANCE_POLICY (G2Agreement_id, G2Application_Id, G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2policyrenewable ON G2Policy_RENEWABLE (G2Policy_Renewable_Id ASC,G2Agreement_id ASC,G2Application_Id ASC,G2Cust_Id ASC);

CREATE TABLE G2MEMBERSHIP
(
G2Membership_Id VARCHAR(20) NOT NULL ,
G2Membership_Type CHAR(15) NOT NULL ,
G2Organisation_Contact VARCHAR(20) NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKMEMBERSHIP PRIMARY KEY (G2Membership_Id,G2Cust_Id),
constraint FKMEMBERSHIP FOREIGN KEY (G2Cust_Id) REFERENCES G2CUSTOMER (G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2membership ON G2MEMBERSHIP (G2Membership_Id ASC,G2Cust_Id ASC);


CREATE table G2QUOTE
(
G2Quote_Id VARCHAR(20) NOT NULL ,
G2Issue_Date DATE NOT NULL ,
G2Valid_From_Date DATE NOT NULL ,
G2Valid_Till_Date DATE NOT NULL ,
G2Quote_Description VARCHAR(500) NULL ,
G2Product_Id VARCHAR(20) NOT NULL ,
G2Coverage_Level VARCHAR(20) NOT NULL ,
G2Application_Id VARCHAR(20) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKQUOTE PRIMARY KEY(G2Quote_Id,G2Application_Id,G2Cust_Id),
constraint FKQUOTE FOREIGN KEY (G2Application_Id, G2Cust_Id) REFERENCES G2APPLICATION (G2Application_Id, G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2quota ON G2QUOTE
(G2Quote_Id ASC,G2Application_Id ASC,G2Cust_Id ASC);

CREATE TABLE G2STAFF
(
G2Staff_Id VARCHAR(20) NOT NULL ,
G2Staff_Fname VARCHAR(50) NULL ,
G2Staff_LName VARCHAR(50) NULL ,
G2Staff_Adress VARCHAR(50) NULL ,
G2Staff_Contact BIGINT NULL ,
G2Staff_Gender CHAR(2) NULL ,
G2Staff_Marital_Status CHAR(8) NULL ,
G2Staff_Nationality CHAR(15) NULL ,
G2Staff_Qualification VARCHAR(20) NULL ,
G2Staff_Allowance INTEGER NULL ,
G2Staff_PPS_Number INTEGER NULL ,
G2Company_Name VARCHAR(200) NOT NULL ,
constraint PKSTAFF PRIMARY KEY (G2Staff_Id,G2Company_Name),
constraint FKSTAFF FOREIGN KEY (G2Company_Name) REFERENCES G2INSURANCE_COMPANY (G2Company_Name)
);
CREATE UNIQUE INDEX idxg2staff ON G2STAFF (G2Staff_Id ASC,G2Company_Name ASC);

CREATE TABLE G2NOK
(
G2Nok_Id VARCHAR(20) NOT NULL ,
G2Nok_Name VARCHAR(30) NULL ,
G2Nok_Address VARCHAR(20) NULL ,
G2Nok_Phone_Number BIGINT NULL ,
G2Nok_Gender CHAR(2) NULL ,
G2Nok_Marital_Status CHAR(8) NULL ,
G2Agreement_id VARCHAR(20) NOT NULL ,
G2Application_Id VARCHAR(20) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
PRIMARY KEY (G2Nok_Id,G2Agreement_id,G2Application_Id,G2Cust_Id),
FOREIGN KEY (G2Agreement_id, G2Application_Id, G2Cust_Id) REFERENCES G2INSURANCE_POLICY (G2Agreement_id, G2Application_Id, G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2nok ON G2NOK (G2Nok_Id ASC,G2Agreement_id ASC,G2Application_Id ASC);


CREATE TABLE G2PRODUCT
(
G2Product_Price INTEGER NULL ,
G2Product_Type CHAR(15) NULL ,
G2Product_Number VARCHAR(50) NOT NULL ,
G2Company_Name VARCHAR(200) NOT NULL ,
constraint PKPRODUCT PRIMARY KEY (G2Product_Number,G2Company_Name),
constraint FKPRODUCT FOREIGN KEY (G2Company_Name) REFERENCES G2INSURANCE_COMPANY (G2Company_Name)
);
CREATE UNIQUE INDEX idxg2product ON G2PRODUCT(G2Product_Number ASC,G2Company_Name ASC);

CREATE TABLE G2OFFICE
(
G2Office_Name VARCHAR(20) NOT NULL ,
G2Office_Leader VARCHAR(20) NOT NULL ,
G2Contact_Information VARCHAR(20) NOT NULL ,
G2Address VARCHAR(20) NOT NULL ,
G2Admin_Cost INTEGER NULL ,
G2Department_Name VARCHAR(200) NOT NULL ,
G2Department_ID VARCHAR(200) NOT NULL,
G2Company_Name VARCHAR(200) NOT NULL,
constraint PKOFFICE PRIMARY KEY (G2Office_Name,G2Department_Name,G2Company_Name),
constraint FKOFFICE FOREIGN KEY (G2Department_Name,G2Department_ID,G2Company_Name) REFERENCES G2DEPARTMENT (G2Department_Name,G2Department_ID,G2Company_Name)
);
CREATE UNIQUE INDEX idxg2office ON G2OFFICE(G2Office_Name ASC,G2Department_Name ASC,G2Company_Name ASC);


CREATE TABLE G2COVERAGE
(
G2Coverage_Id VARCHAR(20) NOT NULL ,
G2Coverage_Amount INTEGER NOT NULL ,
G2Coverage_Type CHAR(10) NOT NULL ,
G2Coverage_Level CHAR(15) NOT NULL ,
G2Product_Id VARCHAR(20) NOT NULL ,
G2Covearge_Terms VARCHAR(500) NULL ,
G2Company_Name VARCHAR(200) NOT NULL ,
PRIMARY KEY (G2Coverage_Id,G2Company_Name),
FOREIGN KEY (G2Company_Name) REFERENCES G2INSURANCE_COMPANY (G2Company_Name)
);
CREATE UNIQUE INDEX idxg2Coverage ON G2Coverage (G2Coverage_Id ASC,G2Company_Name ASC);


CREATE TABLE G2INSURANCE_Policy_COVERAGE
(
G2Agreement_id VARCHAR(20) NOT NULL ,
G2Application_Id VARCHAR(20) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
G2Coverage_Id VARCHAR(20) NOT NULL ,
G2Company_Name VARCHAR(200) NOT NULL ,
constraint PKINSPOLCOVER PRIMARY KEY (G2Agreement_id,G2Application_Id,G2Cust_Id,G2Coverage_Id,G2Company_Name),
constraint FKINSPOLCOVER_1 FOREIGN KEY (G2Agreement_id, G2Application_Id, G2Cust_Id) REFERENCES G2INSURANCE_POLICY (G2Agreement_id, G2Application_Id, G2Cust_Id),
constraint FKINSPOLCOVER_2 FOREIGN KEY (G2Coverage_Id, G2Company_Name) REFERENCES G2Coverage (G2Coverage_Id, G2Company_Name)
);
CREATE UNIQUE INDEX idxg2insurancepolicyCoverage ON G2INSURANCE_Policy_COVERAGE
(G2Agreement_id ASC,G2Application_Id ASC,G2Cust_Id ASC,G2Coverage_Id ASC,G2Company_Name ASC);


CREATE TABLE G2CLAIM
(
G2Claim_Id VARCHAR(20) NOT NULL ,
G2Agreement_Id VARCHAR(20) NOT NULL ,
G2Claim_Amount INTEGER NOT NULL ,
G2Incident_Id VARCHAR(20) NOT NULL ,
G2Damage_Type VARCHAR(200) NOT NULL ,
G2Date_Of_Claim DATE NOT NULL ,
G2Claim_Status CHAR(100) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKCLAIM PRIMARY KEY (G2Claim_Id,G2Cust_Id),
constraint FKCLAIM FOREIGN KEY (G2Cust_Id) REFERENCES G2CUSTOMER (G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2claim ON G2CLAIM (G2Claim_Id ASC,G2Cust_Id ASC);


CREATE TABLE G2Claim_SETTLEMENT
(
G2Claim_Settlement_Id VARCHAR(20) NOT NULL ,
G2Vehicle_Id VARCHAR(20) NOT NULL ,
G2Date_Settled DATE NOT NULL ,
G2Amount_Paid INTEGER NOT NULL ,
G2Coverage_Id VARCHAR(20) NOT NULL ,
G2Claim_Id VARCHAR(20) NOT NULL ,
G2Cust_Id VARCHAR(20) NOT NULL ,
constraint PKSETTLEMENT PRIMARY KEY (G2Claim_Settlement_Id,G2Claim_Id,G2Cust_Id),
constraint FKSETTLEMENT FOREIGN KEY (G2Claim_Id, G2Cust_Id) REFERENCES G2CLAIM (G2Claim_Id, G2Cust_Id)
);
CREATE UNIQUE INDEX idxg2claimsettlement ON G2Claim_SETTLEMENT
(G2Claim_Settlement_Id ASC,G2Claim_Id ASC,G2Cust_Id ASC);