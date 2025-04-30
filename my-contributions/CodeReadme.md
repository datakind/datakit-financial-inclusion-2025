
📊 Project: Economic Pattern Analysis Across Indian States (2017–2023)
📁 Dataset Overview
The dataset contains annual financial data (in crore INR) for all Indian states from FY 2017–18 to FY 2022–23. Each row represents a state, and each column from 2017–18 to 2022–23 represents the total revenue or expenditure for that year. This data gives a time series of economic figures for each state, helping us study:
• Growth trends across states
• Regional performance comparison
• Impact of COVID-19 (notably FY 2020–21)
• Year-over-year changes and variability

🔍 Data Preprocessing
Steps taken:
1. Removed the total row ("Total" entry at the bottom).
2. Converted all year columns to numeric.
3. Melted the dataframe for time series visualization (long format: state, year, value).
4. Handled missing/zero data, especially for Jammu & Kashmir.

🧠 Model Choice: Linear Regression (and future options)
✅ Model Used: Linear Regression (per state)
• Why? Linear regression helps model the trend of financial growth or decline for each state over time.
• It's simple, interpretable, and suitable for short-term trend forecasting (6-year span).
• Output: Slope of growth per state → which states are consistently improving or declining.

🤖 Other Model Ideas:
You can add these later for enhancement:
• Polynomial Regression: for detecting nonlinear growth patterns.
• Clustering (K-Means): to group states based on growth behavior.
• Time Series Forecasting (ARIMA, Prophet): for advanced forecasting.
• PCA (Dimensionality Reduction): if more economic indicators are added.

📈 Visualizations
1. Line Plot: Revenue trends per state over the years.
2. Heatmap: Comparing normalized revenue across states and years.
3. Bar Plot (Regression Slope): Visualizes the average yearly economic growth of each state.
Each visualization helps in communicating regional disparities, growth momentum, and identifying states with stable vs. volatile financial trends
