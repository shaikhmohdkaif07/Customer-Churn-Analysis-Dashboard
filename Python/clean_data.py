path = (r"D:\analytics\Customer Churn Rate Dashboard\Raw data\Telco-Customer-Churn-Analysis.csv")

#Loading and reading data 
import pandas as pd 
df = pd.read_csv(path)

#analysing problem with total charges 
print(df["TotalCharges"].head(5))
df["TotalCharges"]=pd.to_numeric(df["TotalCharges"],errors="coerce")
print(df.info())

#Number of new customer 
print(df[df["TotalCharges"].isna()])
New_Customer=(df["tenure"] == 0).sum()
print(New_Customer)

#analysing categories in data 
for column in df.columns:
    print(column)
    print(df[column].unique())

#numerical consistency 
range=df[["tenure","MonthlyCharges","TotalCharges"]].agg(['min','max'])
print(range)

#checking duplicate customer id 
Dup_id=df["customerID"].duplicated().sum()
print(Dup_id)

#How serious is customer churn?

#Total customers
total_customer=len(df)
print(total_customer)
#Number of churned customers
churned_customers = (df["Churn"] == "Yes").sum()
print(churned_customers)

#Overall churn rate
churn_rate= churned_customers/total_customer*100
print(f"percentage of churn is : {churn_rate:.2f}%")

#Contract groups 
contract=df.groupby("Contract").size()
print(contract)

#Churn by contract
churn_cont= df.groupby("Contract")["Churn"].value_counts()
print(churn_cont)

#Churn rate with contract column 
contract_churn = pd.crosstab(df["Contract"], df["Churn"])
print(contract_churn)

churn_rate_cont = contract_churn["Yes"] / (contract_churn["Yes"] + contract_churn["No"]) * 100
print("percentage of churn by contract",churn_rate_cont.round(2))

#Tenure does it matter ?
print(df["tenure"].describe())
boundaries = [0, 12, 24, 48, 72]
labels = ["New", "Early", "Established", "Long-term"]

df["TenureGroup"] = pd.cut(
    df["tenure"],
    bins=boundaries,
    labels=labels,
    include_lowest=True
)
print(df["TenureGroup"].value_counts().sort_index())

tenure_churn = pd.crosstab(df["TenureGroup"], df["Churn"])
print(tenure_churn)

ten_churn_percentage = tenure_churn["Yes"] / (tenure_churn["Yes"] + tenure_churn["No"]) * 100
print("percentage of churn by tenure",ten_churn_percentage.round(2))

#services churn 
internet_churn = pd.crosstab( df["InternetService"] , df["Churn"] )
print(internet_churn)
internet_churn_rate = internet_churn["Yes"] /(internet_churn["Yes"] + internet_churn["No"])*100
print(internet_churn_rate.round(2))

#Payment Method 
payment_churn = pd.crosstab( df["PaymentMethod"] , df["Churn"] )
print(payment_churn)

payment_churn_rate= payment_churn["Yes"]/(payment_churn["Yes"] + payment_churn["No"])*100
print("Percentage of churn by payment",payment_churn_rate.round(2))

#monthly charges 
print(df["MonthlyCharges"].describe())
boundaries = [0, 35.50, 70.35, 89.85, 120]
labels = ["low paying", "medium paying", "high paying", "highest paying"]

df["MonthlyChargesGroup"] = pd.cut(
    df["MonthlyCharges"],
    bins=boundaries,
    labels=labels,
    include_lowest=True
)
print(df["MonthlyChargesGroup"].value_counts().sort_index())

monthly_charge_churn = pd.crosstab(df["MonthlyChargesGroup"], df["Churn"])
print(monthly_charge_churn)

monthly_charge_churn_percentage = monthly_charge_churn["Yes"] / (monthly_charge_churn["Yes"] + monthly_charge_churn["No"]) * 100
print("percentage of churn by monthly charge",monthly_charge_churn_percentage.round(2))

df.to_csv("./Clean_Csv/Telco_Churn_Cleaned.csv", index=False)