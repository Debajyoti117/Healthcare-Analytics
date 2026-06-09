-- CREATING A TABLE
CREATE TABLE hospital_data (
    hospital_name    VARCHAR(100),
    location         VARCHAR(100),
    department       VARCHAR(100),
    doctors_count    INT,
    patients_count   INT,
    admission_date   DATE,
    discharge_date   DATE,
    medical_expenses NUMERIC(10, 2)
);
SELECT * FROM hospital_data;

-- Q1. Total Number of Patients

SELECT SUM(patients_count) AS total_patients
FROM hospital_data;

-- Q2. Average Number of Doctors per Hospital

SELECT
    hospital_name,
    ROUND(AVG(doctors_count), 2) AS avg_doctors
FROM hospital_data
GROUP BY hospital_name
ORDER BY avg_doctors DESC;

-- Q3. Top 3 Departments with the Highest Number of Patients

SELECT
    department,
    SUM(patients_count) AS total_patients
FROM hospital_data
GROUP BY department
ORDER BY total_patients DESC
LIMIT 3;

-- Q4. Hospital with the Maximum Medical Expenses

SELECT
    hospital_name,
    SUM(medical_expenses) AS total_expenses
FROM hospital_data
GROUP BY hospital_name
ORDER BY total_expenses DESC
LIMIT 1;

-- Q5. Daily Average Medical Expenses

SELECT
    hospital_name,
    ROUND(
        SUM(medical_expenses) /
        NULLIF(SUM(discharge_date - admission_date), 0),
        2
    ) AS avg_expenses_per_day
FROM hospital_data
GROUP BY hospital_name
ORDER BY avg_expenses_per_day DESC;

-- Q6. Longest Hospital Stay

SELECT
    hospital_name,
    location,
    department,
    admission_date,
    discharge_date,
    (discharge_date - admission_date) AS stay_days
FROM hospital_data
ORDER BY stay_days DESC
LIMIT 1;

-- Q7. Total Patients Treated Per City
SELECT
    location  AS city,
    SUM(patients_count) AS total_patients
FROM hospital_data
GROUP BY location
ORDER BY total_patients DESC;

-- Q8. Average Length of Stay Per Department

SELECT
    department,
    ROUND(AVG(discharge_date - admission_date), 2) AS avg_stay_days
FROM hospital_data
GROUP BY department
ORDER BY avg_stay_days DESC;

-- Q9. Department with the Lowest Number of Patient

SELECT
    department,
    SUM(patients_count) AS total_patients
FROM hospital_data
GROUP BY department
ORDER BY total_patients ASC
LIMIT 1;

-- Q10. Monthly Medical Expenses Report

SELECT
    TO_CHAR(admission_date, 'YYYY-MM')  AS month,
    TO_CHAR(admission_date, 'Month YYYY') AS month_name,
    ROUND(SUM(medical_expenses), 2)     AS total_expenses
FROM hospital_data
GROUP BY
    TO_CHAR(admission_date, 'YYYY-MM'),
    TO_CHAR(admission_date, 'Month YYYY')
ORDER BY month;

