# Secure Programming - Assignment

## Assignment Overview
The goal of this assignment is to implement a secure solution for a web application designed for employee sick leave registration. The application prototype is provided, and your task is to secure it by applying secure coding practices and addressing security concerns.

The task will build on the previous "Threat Modeling" assignment, which must be approved before proceeding with this assignment.

---

## Learning Goals
- Apply models and guidelines for developing secure web applications.
- Implement various cryptographic methods to secure web applications.

---

## Background
You are a consultant at CodeSec and have been assigned the task of reviewing the development of a software application for registering sick leave. A web application has been created for this, but it lacks a deliberate focus on security. Additionally, you have created a threat model for this web application, and now it’s time to review the prototype and ensure that the application can be secured.

Please note that this task builds on the previous "Threat Modeling" assignment, which must be completed and approved before proceeding.

---

## Assignment Details

### Objective:
Implement a secure solution and highlight the security controls/design principles used.

### Task:
- Review the code of the partially implemented web application for sick leave and ensure security is incorporated. You must implement missing functionalities related to security (e.g., login functionality) and write comments on all security-related aspects, referencing the points in the provided checklist.
- Example: In views where variables like `@variabelnamn` appear, comment: “Checklist 2.4: Using Razor View prevents XSS attacks.”

### Prerequisites:
- You are working with a .NET Core application provided on the course page. Note that it is incomplete and requires fixing the database and other components before running.
- **Important**: The databases are locally stored on my device and is **not included** in this upload. Therefore, you will not be able to run the application without configuring your own database.
- The following use cases have been partially implemented:
  - Employees can log in to report sick leave.
  - Sick leave for today.
  - Sick leave with a doctor’s note (start and end date).
  - Sick leave for child care (select a child and provide the date).
  - HR can log in to search for employees using an employee number (unique) and view sick leave and child care leave details.
  - IT personnel can log in to view logs and retrieve log data (decrypted).

---

## Non-functional Requirements
You must implement the following non-functional requirements:
- Password policy from the threat model must be implemented.
- All actions in the application should be logged (time, user, IP address, action). These logs must be encrypted. This includes logging in, failed login attempts, sick leave actions, employee searches, and log access.
- Comment your code where security measures are applied and reference the relevant points from the checklist. The checklist is found under "Cechklista Programmering 2022.pdf".

---

## Threat Modeling Assignment Recap

### Learning Goals
- Describe models and guidelines for developing secure web applications.
- Conduct risk analysis and threat modeling.

### Background
You are consultants at CodeSec and have been assigned to lead the development of software for registering sick leave. Employees at PillMedTech should be able to log in from home and report sick leave or child care leave.

Sensitive personal information (e.g., personal ID numbers) will be transmitted. Your client, PillMedTech, turned to CodeSec due to your strong reputation in creating stable and secure web applications.

You have been provided with some background on the company’s IT security (see PillMedTech.pdf, pages 10-11), and the process of creating a security policy is already underway.

You decide to conduct a thorough threat modeling and propose security measures for the web application.

### Tasks for Threat Modeling Assignment:
- Describe the different roles that will use the application, and create a use case diagram.
- Describe the pros and cons of running the application on the provided environment.
- Fill in the table for entry points and explain what entry points are.
- Identify and classify assets in the application and explain what they are.
- Fill in the trust levels table and explain what each role can do.
- Create at least one data flow diagram and describe what it represents.
- Conduct a threat analysis and describe the threats against the sick leave system, their impact, and the countermeasures that should be implemented.
- Create a password policy and explain why it’s necessary and how it should be communicated within the organization.

---
