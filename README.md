# Telco Customer Churn Analysis

An end-to-end data analytics portfolio project exploring customer churn patterns in a telecommunications dataset using **Excel, Python, MySQL and Power BI**.

## Business Problem

Customer churn affects recurring revenue and customer lifetime value. The objective of this project was to understand the overall churn level, identify customer segments with higher observed churn, and translate the findings into areas the business could investigate to improve retention.

This is a descriptive analysis of the supplied dataset. The results show associations and patterns; they do not establish that any particular factor caused a customer to leave.

## Dashboard

The Power BI report contains three pages:

1. **Executive Overview** — total customers, churned customers and overall churn rate.
2. **Churn Drivers** — churn-rate comparisons by contract, tenure group and internet service, with key observations.
3. **Customer Risk & Retention Opportunities** — contract × internet service matrix, high-churn segment KPI cards and retention investigation recommendations.


### Executive Overview
![Executive Overview](screenshot\executive_summary.png)

### Churn Drivers
![Churn Drivers](screenshot\churn_drivers.png)

### Customer Risk & Retention Opportunities
![Customer Risk & Retention Opportunities](screenshot\risk_retention.png)

## Dataset

The project uses the Telco Customer Churn dataset, originally supplied as a CSV with **7,043 customer records and 21 columns**.

The source data includes customer demographics, account details, subscribed services, contract type, payment method, monthly charges, total charges and churn status.

## Tools Used

| Tool | Purpose |
|---|---|
| Microsoft Excel | Initial inspection, data familiarization and spot-checking of records and summary values |
| Python (pandas, NumPy) | Data-type conversion, data-quality checks, feature grouping, summary analysis and cleaned CSV export |
| MySQL | SQL-based aggregation and validation of churn metrics across customer segments |
| Power BI | Data modelling, DAX measures, interactive report visuals and business-facing insights |

## Project Workflow

### 1. Excel — Initial inspection and validation

- Opened the source CSV and reviewed the columns, records and category values.
- Familiarized myself with the fields used in the analysis, including `Contract`, `InternetService`, `PaymentMethod`, `tenure`, `MonthlyCharges`, `TotalCharges` and `Churn`.
- Used Excel as an initial inspection and spot-checking step before performing repeatable cleaning and analysis in Python.

### 2. Python — Cleaning and exploratory analysis

The script in `Python\clean_data.py`:

- Loads the raw CSV.
- Checks the expected columns and duplicate customer IDs.
- Converts `TotalCharges` from text to numeric using `pandas.to_numeric(..., errors="coerce")`.
- Checks missing `TotalCharges` values and investigates their tenure and churn status.
- Retains the 11 records with missing `TotalCharges`; these records have tenure of zero and churn status `No` in this dataset. They are not automatically deleted or filled with invented values.
- Ensures relevant numeric columns have numeric data types.
- Creates `TenureGroup` categories: New, Early, Established and Long-term.
- Creates `MonthlyChargeGroup` categories: Low paying, Medium paying, High paying and Highest paying.
- Exports the analysis-ready dataset to `Clean_Csv/Telco_Churn_Cleaned.csv`.
- Calculates overall churn and segment-level churn summaries.

### 3. MySQL — Querying and Validation

The SQL script in `MySql\telco_churn_analysis.sql` contains MySQL queries for:

- Overall customer count, churned customer count and churn rate.
- Churn by contract type.
- Churn by tenure group.
- Churn by internet service.
- Churn by payment method.
- Churn by monthly charge group.
- Average monthly charges by churn status.
- Contract × internet service segment analysis.
- Churn by OnlineSecurity and TechSupport status.

The queries assume the cleaned CSV has been imported into a MySQL database table named `Clean_Csv\Telco_Churn_Cleaned.csv`. The SQL file uses MySQL 8.0+ compatible syntax for data aggregation, conditional calculations, grouping, and customer churn analysis.

### 4. Power BI — Dashboard and communication

- Imported the cleaned CSV.
- Checked column data types in Power Query.
- Created a DAX measure for churn rate:

```DAX
Churn_rate =
CALCULATE(
    COUNTROWS(Telco_Churn_Cleaned),
    Telco_Churn_Cleaned[Churn] = "Yes"
) / COUNTROWS(Telco_Churn_Cleaned)
```

- Formatted the measure as a percentage with two decimal places.
- Created KPI cards and charts to compare churn across customer segments.
- Built a matrix showing churn rate by contract and internet service.
- Added retention investigation recommendations based on the observed patterns.

## Key Findings

| Analysis | Observed result |
|---|---:|
| Total customers | 7,043 |
| Churned customers | 1,869 |
| Overall churn rate | 26.54% |
| Month-to-month contract churn | 42.71% |
| One-year contract churn | 11.27% |
| Two-year contract churn | 2.83% |
| New customers (0–12 months) churn | 47.44% |
| Long-term customers (49–72 months) churn | 9.51% |
| Fiber optic customers churn | 41.89% |
| DSL customers churn | 18.96% |
| Customers with no internet service churn | 7.40% |
| Electronic check payment churn | 45.29% |

### Segment-level observation

The contract × internet service matrix showed an observed churn rate of **54.61%** among month-to-month customers with fiber optic service. Segment size should also be considered before prioritizing this group for retention activity.

### Business interpretation

The analysis suggests several areas for further investigation:

- Review onboarding and early customer support for newer customers.
- Investigate retention approaches for month-to-month customers.
- Examine payment experience among electronic check users.
- Investigate service quality, pricing and customer feedback among fiber optic customers.

These are investigation opportunities, not proven explanations for churn.


## How to Run

### Python

1. Install Python.
2. Install dependencies:

```bash
pip install pandas numpy
```

3. Place `Telco-Customer-Churn-Analysis.csv` in the `Raw data\Telco-Customer-Churn-Analysis.csv` folder.
4. Run:

```bash
python Python/clean_data.py
```

5. The cleaned output will be created at `Clean_Csv/Telco_Churn_Cleaned.csv`.

### MySQL

1. Create a MySQL database for the project.
2. Import `Clean_Csv/Telco_Churn_Cleaned.csv` into a table named `telco_churn` using MySQL Workbench's Table Data Import Wizard.
3. Verify that the imported column names and data types match the SQL script. Ensure numeric columns such as `tenure`, `monthlycharges`, and `totalcharges` have appropriate numeric data types.
4. Open `MySql\telco_churn_analysis.sql` in MySQL Workbench.
5. Select the project database and execute the queries to analyze and validate customer churn metrics across different customer segments.

### Power BI

1. Open Power BI Desktop.
2. Import `Clean_Csv/Telco_Churn_Cleaned.csv`.
3. Check data types in Power Query.
4. Recreate or open the `.pbix` report and review the three report pages.

## Notes and Limitations

- The 11 missing `TotalCharges` values were retained rather than imputed or deleted.
- `TotalCharges` is not used to fabricate missing financial values.
- Churn percentages are calculated within each segment: churned customers in the segment divided by all customers in that segment.
- Segment percentages are not additive because customer groups can overlap across different dimensions.
- Observed relationships do not prove causation.
- The dataset is a snapshot and may not represent current telecom customer behavior.

## Author

**Mohammed Kaif Shaikh**

Data Analytics Portfolio Project  
Tools: Excel | Python | MySQL | Power BI
