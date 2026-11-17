
/*
Telco Customer Churn Analysis — MySQL
--------------------------------------
The SQL below assumes the cleaned CSV has been imported into a
MySQL table named telco_churn.

Prerequisites:
1. Import the cleaned CSV into MySQL.
2. Confirm column names and data types.
3. The cleaned CSV includes TenureGroup and MonthlyChargeGroup,
   created during Python data cleaning.
*/


-- 0. Check table and records

SELECT COUNT(*) AS total_rows
FROM telco_churn;

SELECT *
FROM telco_churn
LIMIT 10;


-- 1. Overall customer and churn KPIs

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM telco_churn;


-- 2. Churn by contract type

SELECT
    contract,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM telco_churn
GROUP BY contract
ORDER BY churn_rate_pct DESC;


-- 3. Churn by tenure group

SELECT
    tenuregroup,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM telco_churn
GROUP BY tenuregroup
ORDER BY
    CASE tenuregroup
        WHEN 'New' THEN 1
        WHEN 'Early' THEN 2
        WHEN 'Established' THEN 3
        WHEN 'Long-term' THEN 4
        ELSE 5
    END;


-- 4. Churn by internet service

SELECT
    internetservice,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM telco_churn
GROUP BY internetservice
ORDER BY churn_rate_pct DESC;


-- 5. Churn by payment method

SELECT
    paymentmethod,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM telco_churn
GROUP BY paymentmethod
ORDER BY churn_rate_pct DESC;


-- 6. Churn by monthly charge group

SELECT
    monthlychargegroup,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM telco_churn
GROUP BY monthlychargegroup
ORDER BY churn_rate_pct DESC;


-- 7. Average monthly charges by churn status

SELECT
    churn,
    ROUND(AVG(monthlycharges), 2) AS avg_monthly_charges
FROM telco_churn
GROUP BY churn
ORDER BY churn;


-- 8. Contract × internet service segment analysis

SELECT
    contract,
    internetservice,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM telco_churn
GROUP BY contract, internetservice
ORDER BY contract, churn_rate_pct DESC;


-- 9. Churn by add-on service: OnlineSecurity

SELECT
    onlinesecurity,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM telco_churn
GROUP BY onlinesecurity
ORDER BY churn_rate_pct DESC;


-- 10. Churn by add-on service: TechSupport

SELECT
    techsupport,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM telco_churn
GROUP BY techsupport
ORDER BY churn_rate_pct DESC;


-- 11. Average monthly charges by churn status (alternative)

SELECT
    churn,
    AVG(monthlycharges) AS average_monthly_charges
FROM telco_churn
GROUP BY churn;
