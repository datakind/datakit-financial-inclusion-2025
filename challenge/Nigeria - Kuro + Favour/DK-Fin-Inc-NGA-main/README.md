# 🇳🇬 Nigeria Financial Inclusion Analysis (2021)

This project explores **financial inclusion trends in Nigeria** using the 2021 Global Findex Database from the **World Bank Microdata Library**. It presents insights through a combination of Python-based data analysis, a Power BI dashboard, and a written report to drive data-informed decision-making in the financial ecosystem.

---

## 📊 Project Components

1. **Jupyter Notebook** (`DataKind_Financial_Inclusion.ipynb`):  
   - Data wrangling and exploratory analysis of the 2021 Findex dataset.
   - Focuses on demographic trends in digital payments, mobile money, savings, and borrowing behaviors.

2. **Power BI Dashboard** (`NGA_2021_findex.pbix`):  
   - Interactive visual report summarizing key insights across gender, education, income levels, employment status, and urban/rural divide.
   - Designed for stakeholders, policymakers, and development partners to easily explore the state of financial inclusion.

3. **PDF Report** (`NGA_2021_FINDEX_REPORT.pdf`):  
   - Concise summary of findings with data visualizations and practical recommendations.
   - Highlights key inclusion gaps and proposes data-driven interventions.

---

## 📁 File Structure

```text
├── dataset-and-codebook                   # Folder containing the dataset and codebook
├── DataKind_Financial_Inclusion.ipynb     # Jupyter notebook with code and analysis
├── NGA_2021_findex (Dahboard).pbix        # Power BI dashboard file
├── NGA_2021_FINDEX_REPORT.pdf             # Final report of key insights (from dashboard) and recommendations
├── requirements.txt                       # Python libraries needed
└── README.md                              # Project documentation
```

---

## 🌍 Dataset Source

This project uses publicly available data from the:

> **[World Bank Global Findex Database (2021)](https://microdata.worldbank.org/index.php/catalog/4688/)**  
> Provided by: World Bank Microdata Library  
> Country: Nigeria  
> Accessed: 22nd March 2025

The dataset covers adult financial behavior including access to accounts, mobile money usage, savings, credit, and remittances.

---

## 🛠️ Getting Started

### Prerequisites

- Python 3.8+
- Jupyter Notebook
- Power BI Desktop (for .pbix file)
- Recommended: Create a virtual environment

### Installation

```bash
# Clone the repository
git clone https://github.com/WoDauKuro/DK-Fin-Inc-NGA.git
cd DK-Fin-Inc-NGA

# Create a virtual environment (optional)
python -m venv env
source env/bin/activate  # On Windows: env\Scripts\activate

# Install required Python libraries
pip install -r requirements.txt
```

### Launch the Notebook

```bash
jupyter notebook DataKind_Financial_Inclusion.ipynb
```

---

## 🔍 Key Insights

- **Gender Gap:** Males are more likely to adopt digital payments and mobile money services than females.
- **Urban vs Rural:** Urban residents exhibit significantly higher financial inclusion than rural dwellers.
- **Education & Income:** Higher levels of education and income positively correlate with access to digital financial services.
- **Savings & Borrowing:** Informal savings and borrowing dominate, especially in rural communities and among low-income groups.
- **Remittances:** Cash remains the dominant channel, but mobile money usage is growing.

---

## ✅ Recommendations

- **Expand mobile money infrastructure**, especially in rural areas.
- **Promote financial literacy**, targeting women and low-income earners.
- **Collaborate with local fintechs** to tailor services to underserved populations.
- **Monitor digital gaps** to ensure inclusive growth in financial ecosystems.

---

## 📌 Future Work

- Deeper modeling of financial behavior drivers using machine learning.
- Study of remittance inflows and their impact on household welfare.
- Comparative analysis with previous Findex waves (2014, 2017).

---

## 🤝 Contributing

Pull requests are welcome! If you'd like to contribute, please:
- Fork the repository
- Create a new branch
- Submit a pull request with detailed changes

---

## 📄 License

This project is open-source and licensed under the [MIT License](LICENSE).

---

**Let’s bridge Nigeria’s financial gap—one insight at a time.**
