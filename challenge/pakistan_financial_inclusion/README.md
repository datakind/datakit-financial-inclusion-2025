# 🇵🇰 Pakistan Financial Inclusion: End-to-End Data Science Pipeline  

This repository contains the **cleaned dataset**, **data cleaning process**, and **end-to-end data science pipeline** for the **Pakistan Financial Inclusion** project. The pipeline includes **Exploratory Data Analysis (EDA)**, **Predictive Modeling**, and **SHAP Analysis** to analyze financial inclusion data and build a model to predict key outcomes.  

![GitHub repo size](https://img.shields.io/github/repo-size/mmsaleem3737/pakistan-financial-inclusion-cleaning)
![GitHub last commit](https://img.shields.io/github/last-commit/mmsaleem3737/pakistan-financial-inclusion-cleaning)
![GitHub stars](https://img.shields.io/github/stars/mmsaleem3737/pakistan-financial-inclusion-cleaning?style=social)  

---

## 📂 Files Included  

| File Name                                      | Description                                                                 |
|------------------------------------------------|-----------------------------------------------------------------------------|
| `cleaned_data.csv`                             | Final cleaned dataset ready for analysis.                                   |
| `data_cleaning_process.ipynb`                  | Jupyter Notebook containing step-by-step data cleaning code and explanation.|
| `financial_inclusion_cleaning_report.pdf`      | PDF report explaining the cleaning process and key observations.            |
| `end_to_end_data_science_pipeline.ipynb`       | Jupyter Notebook covering EDA, modeling, and SHAP analysis.                |
| `end_to_end_data_science_pipeline.pdf`         | PDF report summarizing the end-to-end data science pipeline.               |

---

<details>
<summary><b>🛠️ Key Steps (Click to Expand)</b></summary>

### 1. **Data Cleaning**  
- Removed duplicates and invalid entries.  
- Handled missing values.  
- Converted data types where necessary.  
- Normalized column names for consistency.  
- Exported cleaned dataset for further use.  

### 2. **Exploratory Data Analysis (EDA)**  
- **Data Loading and Overview**: Loaded the dataset and performed initial exploration.  
- **Categorical Data Analysis**: Analyzed gender, education level, employment status, and financial behaviors.  
- **Visualizations**: Created distribution plots, box plots, and pair plots to understand relationships between variables.  

### 3. **Advanced EDA**  
- **Correlation Analysis**: Identified relationships between key variables using a correlation matrix.  
- **Chi-Square Tests**: Tested associations between categorical variables (e.g., gender and account ownership).  
- **Distribution Plots**: Visualized the distribution of age, income, and other numerical features.  

### 4. **Feature Engineering**  
- **New Features**: Created binary features for digital payment usage, account ownership, savings, and borrowing.  
- **Interaction Terms**: Generated interaction terms between key features (e.g., age group and education level).  

### 5. **Predictive Modeling**  
- **Model Selection**: Trained and evaluated **Logistic Regression** and **Random Forest** models.  
- **Class Imbalance**: Addressed class imbalance using **SMOTE** and class-weighted Logistic Regression.  
- **Hyperparameter Tuning**: Optimized the Random Forest model using **Grid Search**, achieving **100% accuracy**.  
- **Feature Importance**: Identified the top features driving the model's predictions (e.g., `account`, `digital_payment_user`).  

### 6. **SHAP Analysis**  
- **Model Interpretability**: Used SHAP values to explain the model's predictions.  
- **Key Insights**: Identified the impact of features like `account` and `digital_payment_user` on the model's output.  
- **Interaction Effects**: Explored interactions between features to uncover hidden patterns.  

</details>

---

<details>
<summary><b>🔍 Key Findings (Click to Expand)</b></summary>

### 1. **Gender Gap in Financial Inclusion**  
- Males have slightly higher access to financial services compared to females.  
- **Policy Action**: Targeted interventions, such as financial literacy programs for women, are needed to bridge this gap.  

### 2. **Education Level and Financial Inclusion**  
- Individuals with higher education levels are more likely to own accounts and use financial services.  
- **Policy Action**: Improving access to education, especially in underserved areas, can promote financial inclusion.  

### 3. **Digital Divide**  
- Only 19% of individuals use digital payments, highlighting a significant digital divide.  
- **Policy Action**: Investments in digital infrastructure and digital literacy programs are essential.  

### 4. **Employment Status and Financial Behavior**  
- Employed individuals are more likely to save or borrow, indicating a link between employment and financial stability.  
- **Policy Action**: Job creation programs and support for small businesses can improve financial inclusion.  

### 5. **Model Performance**  
- The Random Forest model achieved **100% accuracy** after hyperparameter tuning.  
- **Top Features**: `account`, `digital_payment_user`, and `fin11_1` were the most important predictors.  

</details>

---

<details>
<summary><b>🛠️ How to Use (Click to Expand)</b></summary>

1. Clone the repository:  
```bash
git clone https://github.com/mmsaleem3737/pakistan-financial-inclusion-cleaning.git
