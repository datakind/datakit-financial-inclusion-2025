🇵🇰 Pakistan: Financial Inclusion & Enterprise Insights (DataKit Contribution)

📌 Project Summary
This project explores financial inclusion at the individual level and business dynamics at the enterprise level in Pakistan. Using survey microdata from the World Bank (Global Findex 2021 & Enterprise Survey 2022), the study aims to surface disparities in financial access and infrastructure bottlenecks, with a focus on gender, geography, and firm characteristics.

We contribute to DataKind's mission by sharing cleaned datasets, insights, and Power BI visualizations relevant to financial inclusion and economic opportunity in Pakistan.

the links below is the study data set description
https://microdata.worldbank.org/index.php/catalog/4396/data-dictionary
https://microdata.worldbank.org/index.php/catalog/6461/data-dictionary/F1?file_name=Pakistan-2022-full-data.dta

🧹 Data Cleaning & Transformation Process

✅ 1. Raw Datasets
We started from 2 publicly available datasets:

Source	Dataset	Description
World Bank	Pakistan-2022-full-data.dta	Enterprise Survey (Firm-level)
World Bank	micro_pak.csv	Global Findex (Individual-level)

🔧 2. Cleaning Steps
Global Findex (micro_pak.csv)

Kept variables related to account ownership, digital payments, gender, urban/rural, mobile access, income quintile

Binary Labeling	Transformed 1/0 values into "Yes" / "No", "Female" / "Male", "Urban" / "Rural" for readability

Column Renaming	Renamed for clarity: account_mob → mobile_account, anydigpayment → digital_payment, etc.

Missing Values	Rows with >20% null values dropped

Export	Final file: findex_final.csv

Enterprise Survey (Pakistan-2022-full-data.dta)

Selected key variables: firm size, sector, infrastructure (electricity/internet), trade (exports/imports), credit access

Variable Mapping	a4a → sector, a6a → firm_size, b4 → female_ownership, c3/c6 → electricity access

Renaming & Transformation	Standardized binary values to Yes/No; converted percentage strings to numeric

Calculated Fields	Added new variable: total_export_pct = direct_export + indirect_export

Export	Final file: firm_final.csv

📈 Power BI Dashboard

The Power BI report includes:

1️⃣ Financial Inclusion – Individuals

100% Stacked Bar: Account Ownership vs Gender, vs Urbanicity

Heatmaps: Income Quintile vs Borrowed, vs Saved

Donut: Mobile Ownership Share

Funnel: Digital Payment Adoption

Narrative Box summarizing insights

2️⃣ Business Environment – Firms

Donut: Firm Distribution by Sector

Bar: Internet/Electricity Disruptions by Region

Line: Avg Export vs Import by Sector

Grouped Bar: Credit Application/Approval by Firm Size

Bar: Credit Obstacle by Gender

Narrative Box with key findings


📝 Insights Summary 

Key Findings – Individuals

Rural respondents lead in account ownership and digital payment usage

Women are significantly less likely to hold financial/mobile accounts

Digital finance remains limited (only 19% made digital payments)

Income affects saving behavior; borrowing is more erratic

Mobile phone ownership is 69%, limiting digital reach

Key insights - individuals

Encourage usage, not just access.

Tailor financial products for women.

Expand rural digital finance infrastructure.

Boost financial education to reduce informal/debt risks.

Key Findings – Firms

Retail firms dominate by count; manufacturing leads in trade

Punjab leads in internet disruptions, Khyber in electricity outages

Large firms face higher credit access obstacles

Female-led firms apply less for credit and receive less full funding

Key insights - Firms

Tailor export support and import substitution policies to manufacturing firms.

 Prioritize infrastructure investment in Punjab (internet) and Khyber (electricity).
 
 Provide risk-mitigation tools for firms exposed to global trade.
 
 Streamline credit processes for large firms facing administrative delays.
 
Promote financial inclusion for women-led firms with better access, trust, and loan design.

