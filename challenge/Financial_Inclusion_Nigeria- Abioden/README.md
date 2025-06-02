# Financial_Inclusion_Nigeria
Understanding financial inclusion metrics and potentials through data exploration.

## This project aims to explore international economic opportunity data to uncover insights that can help inform local decision-making and drive meaningful impact using publicly available information. I have chosen the Nigerian dataset to work with.


### *In this project, the main work will be about consolidating the columns in the dataset into a more compact structure. We will then feed this compact structure into the function that'll give us different visualizations to explore the data and extract the stories hidden in the data. I have defined a list of columns that we need to create based on the data at hand. The list is as follows:*


---

### **1. `state`**
- **Description**: Indicates the state or territory where the individual resides.
- **Purpose**: This column helps analyze geographic disparities in financial inclusion and economic opportunities across different regions.

---

### **2. `bank_account_ownership`**
- **Description**: Indicates whether an individual owns a formal bank account (e.g., savings, checking) and the type of financial institution they use (e.g., commercial bank, microfinance institution).
- **Purpose**: This column helps assess financial inclusion by identifying individuals with access to formal banking services.

---

### **3. `financial_inclusion_metrics`**
- **Description**: A composite score or indicator that measures various aspects of financial inclusion, such as access to credit, savings, and digital payment systems.
- **Purpose**: This column provides a quantitative measure of an individual's overall financial inclusion status.

---

### **4. `demographic_factors`**
- **Description**: Captures demographic characteristics of individuals, such as age, gender, education level, employment status, and household size.
- **Purpose**: This column helps identify demographic groups that are more or less likely to be financially included or economically empowered.

---

### **5. `savings_behavior`**
- **Description**: Describes how individuals save money, including formal methods (e.g., bank accounts) and informal methods (e.g., savings groups, keeping cash at home).
- **Purpose**: This column helps understand saving habits and their relationship with financial inclusion and resilience.

---

### **6. `borrowing_behavior`**
- **Description**: Indicates how individuals borrow money, including formal sources (e.g., banks, microfinance institutions) and informal sources (e.g., family, friends, moneylenders).
- **Purpose**: This column helps analyze borrowing patterns and their impact on financial inclusion and economic opportunities.

---

### **7. `digital_payment_adoption`**
- **Description**: Indicates whether an individual uses digital payment systems (e.g., mobile money, e-wallets, online banking) for transactions.
- **Purpose**: This column helps assess the adoption of digital financial services and its role in promoting financial inclusion.

---

### **8. `access_to_electricity`**
- **Description**: Indicates whether an individual has reliable access to electricity, which is a critical enabler for using digital financial services and other infrastructure.
- **Purpose**: This column helps identify barriers to financial inclusion caused by lack of basic infrastructure.

---

### **9. `internet_access`**
- **Description**: Indicates whether an individual has access to the internet, which is essential for using online banking, digital payments, and other financial services.
- **Purpose**: This column helps evaluate the role of internet access in driving financial inclusion and economic opportunities.

---

### **10. `mobile_phone_usage`**
- **Description**: Indicates whether an individual uses a mobile phone and the extent of its usage (e.g., feature phone vs. smartphone).
- **Purpose**: This column helps assess the role of mobile phones in enabling access to financial services, particularly mobile money and digital payments.

---

### **11. `credit_access`**
- **Description**: Indicates whether an individual has access to formal credit services from banks, microfinance institutions, or other lenders.
- **Purpose**: This column helps evaluate the availability of credit as a tool for financial inclusion and economic empowerment.

---

### **12. `small_business_ownership`**
- **Description**: Indicates whether an individual owns or operates a small business.
- **Purpose**: This column helps assess the relationship between entrepreneurship and financial inclusion, as well as the role of small businesses in economic development.

---

### **13. `entrepreneurship`**
- **Description**: Captures indicators of entrepreneurial activity, such as starting or managing a business, involvement in income-generating activities, or participation in innovation ecosystems.
- **Purpose**: This column helps identify individuals who are engaged in entrepreneurial activities and their access to financial resources.
---

These descriptions provide a clear understanding of each column's purpose and how it contributes to analyzing financial inclusion and economic opportunities.






## Questions we want to answer:

#### **1. Distribution of Bank Account Ownership**
**Question**:  
What is the distribution of bank account ownership (`bank_account_ownership`) across different states/territories? Are there any significant correlations with demographic factors (`demographic_factors`) or access to infrastructure (e.g., `access_to_electricity`, `internet_access`)?

---

#### **2. Infrastructure and Financial Inclusion**
**Question**:  
How does access to infrastructure (e.g., `access_to_electricity`, `internet_access`, `mobile_phone_usage`) correlate with financial inclusion metrics such as bank account ownership, digital payment adoption, and credit access?

---

#### **3. Barriers to Financial Inclusion**
**Question**:  
What are the primary barriers to financial inclusion for individuals who do not own a bank account (`bank_account_ownership = No`)? Are these barriers related to lack of infrastructure (e.g., `access_to_electricity`, `internet_access`) or other factors?

---

#### **4. Savings Behavior Across Groups**
**Question**:  
How do savings behaviors (`savings_behavior`) vary across demographic groups (`demographic_factors`) and geographic regions (`state`, `region`)? Are there observable patterns among different income levels or education levels?

---

#### **5. Borrowing Behavior and Credit Access**
**Question**:  
What is the relationship between borrowing behavior (`borrowing_behavior`) and access to credit (`credit_access`)? Do individuals with limited credit access rely on informal borrowing methods (e.g., family/friends, moneylenders)?

---

#### **6. Digital Payment Adoption Trends**
**Question**:  
What trends can be observed in digital payment adoption (`digital_payment_adoption`) across different demographic groups and geographic regions? Are there specific factors (e.g., `internet_access`, `mobile_phone_usage`) that drive or hinder adoption?

---

#### **7. Entrepreneurship and Small Business Ownership**
**Question**:  
How does entrepreneurship (`entrepreneurship`) correlate with small business ownership (`small_business_ownership`) and access to credit (`credit_access`)? Are there disparities based on demographic factors or geographic location?

---

#### **8. Financial Resilience and Economic Opportunities**
**Question**:  
How do financial resilience metrics (e.g., `finhealth_resilience`, `finneeds_resilience`) relate to broader economic opportunities, such as entrepreneurship (`entrepreneurship`) and small business ownership (`small_business_ownership`)?

---

#### **9. Correlations Between Financial Inclusion Metrics**
**Question**:  
What relationships exist between various financial inclusion metrics, such as bank account ownership (`bank_account_ownership`), savings behavior (`savings_behavior`), borrowing behavior (`borrowing_behavior`), and digital payment adoption (`digital_payment_adoption`)?

---

#### **10. Role of Demographic Factors**
**Question**:  
Which demographic factors (`demographic_factors`) are the strongest predictors of financial inclusion, as measured by `bank_account_ownership` and `financial_inclusion_metrics`? How do age, gender, education level, and employment status influence financial inclusion?

---

### *I'd like to say that this phase is not fully completed yet (there are still missing values in the consolidated dataset). This is a representation of what the final workflow will eventually look like (I just don't have the time to dig all in on it yet).*
