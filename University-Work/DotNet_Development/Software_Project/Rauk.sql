/*DROP TABLE Organizations;
DROP TABLE Programs;
DROP TABLE Applications_and_Evaluations;
DROP TABLE Payments;
DROP TABLE Participants;
DROP TABLE Reports_and_Reclaims;
DROP TABLE Scholarships_and_Grants;*/

USE RAUK;

CREATE TABLE Organizations (
    organization_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    Organization VARCHAR(255) NOT NULL,
    OrganizationEmail VARCHAR(255),
    PostalCode VARCHAR(10) NOT NULL,
    City VARCHAR(255) NOT NULL,
    Municipality VARCHAR(255) NOT NULL,
    County VARCHAR(255) NOT NULL,
    AccountHolder VARCHAR(255) NOT NULL,
    OrganizationNumber VARCHAR(20) NOT NULL,
    Plus_Bankgiro VARCHAR(20) NOT NULL
);

CREATE TABLE Programs (
    program_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    Program VARCHAR(255) NOT NULL,
    EducationLevel VARCHAR(255),
    EducationalProgram VARCHAR(255),
    Subject VARCHAR(255),
    Semester VARCHAR(255),
    Weeks INT,
    PartnerSchool VARCHAR(255),
    PartnerCity VARCHAR(255),
    PartnerCountry VARCHAR(255),
    PartnerSchool_EducationLevel VARCHAR(255),
    GrantArea VARCHAR(255),
    From_Country VARCHAR(255),
    To_Country VARCHAR(255)
);

CREATE TABLE Applications_and_Evaluations (
    application_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    FrameCaseNumber VARCHAR(255) NOT NULL,
    Dnr VARCHAR(255) NOT NULL,
    ApplicationStatus VARCHAR(255) NOT NULL,
    Period VARCHAR(255) NOT NULL,
    PeriodDate DATE NOT NULL,
    Archived_Date DATE NOT NULL,
    Accompanying_SupportStaff VARCHAR(255),
    Theme VARCHAR(255),
    Exchange_Type VARCHAR(255),
    Weighted_QualityPoints_BudgetView FLOAT,
    Average_TotalPoints_Application FLOAT,
    PointDifference_ApplicationView FLOAT,
    Weighted_AveragePoints FLOAT NOT NULL,
    AverageRating FLOAT NOT NULL,
    PointDifference FLOAT NOT NULL,
    QualityPoints_Report FLOAT NOT NULL,
    organization_id INT,
    program_id INT,
    FOREIGN KEY (organization_id) REFERENCES Organizations (organization_id),
    FOREIGN KEY (program_id) REFERENCES Programs (program_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    Payment FLOAT NOT NULL,
    Total_Applied_Amount FLOAT NOT NULL,
    Total_Granted_Amount FLOAT NOT NULL,
    Total_Reported_Amount FLOAT NOT NULL,
    Total_Approved_Amount FLOAT NOT NULL,
    Applied_Amount_ExtraFunds FLOAT,
    Granted_Amount_ExtraFunds FLOAT,
    Reported_Amount_ExtraFunds FLOAT,
    Approved_Adjusted_Amount_ExtraFunds FLOAT,
    Applied_AuditGrant FLOAT,
    Granted_AuditGrant FLOAT,
    Applied_AdminGrant FLOAT,
    Granted_AdminGrant FLOAT,
    Applied_Amount_Scholarships FLOAT,
    Granted_Amount_Scholarships FLOAT,
    Approved_Amount_Scholarships FLOAT,
    application_id INT,
    FOREIGN KEY (application_id) REFERENCES Applications_and_Evaluations (application_id)
);

CREATE TABLE Participants (
    participant_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    BirthData DATE,
    Gender VARCHAR(10),
    Country VARCHAR(255),
    Level VARCHAR(255),
    Applied_Participant_Number INT,
    Granted_Participant_Number INT,
    Reported_Participant_Number INT,
    Applied_Staff_Teacher_Number INT,
    Reported_Staff_Teacher_Number INT,
    Applied_Student_Number INT,
    Reported_Student_Number INT,
    Reported_Women_Student_Number INT,
    Reported_Men_Student_Number INT,
    Reported_Women_Teacher_Number INT,
    Reported_Men_Teacher_Number INT,
    Reported_Women_SchoolLeader_Number INT,
    Reported_Men_SchoolLeader_Number INT,
    Reported_Women_AssociatedStaff_Number INT,
    Reported_Men_AssociatedStaff_Number INT,
    application_id INT,
    FOREIGN KEY (application_id) REFERENCES Applications_and_Evaluations (application_id)
);

CREATE TABLE Reports_and_Reclaims (
    report_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    ReportStatus VARCHAR(255),
    ReportStatusDate DATE,
    Date_when_ReportStatus_Set DATE NOT NULL,
    Status_Report VARCHAR(255) NOT NULL,
    Reclaim_Paid_Date DATE NOT NULL,
    Reclaim_Amount FLOAT NOT NULL,
    Reclaim_Paid_Amount FLOAT NOT NULL,
    Reclaim_Created_Date DATE NOT NULL,
    NumberOfReportedScholarships INT,
    NumberOfReportedCompletedScholarships INT,
    NumberOfReportedAbortedScholarships INT,
    NumberOfReportedNotAwardedScholarships INT,
    application_id INT,
    FOREIGN KEY (application_id) REFERENCES Applications_and_Evaluations (application_id)
);

CREATE TABLE Scholarships_and_Grants (
    scholarship_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    PreviousApplication_Dnr VARCHAR(255),
    Project VARCHAR(255),
    ProjectYear INT,
    Applied_Year_Month DATE,
    Reported_Year_Month DATE,
    Applied_Number_Of_Days INT,
    Reported_Number_Of_Days INT,
    NumberOfAppliedScholarships INT,
    NumberOfGrantedScholarships INT,
    application_id INT,
    FOREIGN KEY (application_id) REFERENCES Applications_and_Evaluations (application_id)
);