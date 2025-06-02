import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import MinMaxScaler
from sklearn.cluster import KMeans

# Load data (simulate reading from a CSV for now)
data = {
    "State": [
        "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat", "Haryana",
        "Himachal Pradesh", "Jammu & Kashmir", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", 
        "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan",
        "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal"
    ],
    "2017-18": [
        29001.25, 9238.79, 22301.52, 65083.19, 20754.83, 2544.27, 20782.34, 7297.53, 4801.27, 11911.66,
        21143.64, 31751.99, 16833.07, 50853.06, 37203.32, 4154.29, 4323.15, 3097.04, 3353.09, 31272.03,
        10616.96, 37028.03, 2470.52, 27099.72, 16420.06, 4322.54, 120940.1, 7084.9, 49321.13
    ],
    "2018-19": [
        32787.03, 10436.14, 25215.85, 73602.96, 23458.69, 2878.36, 23489.32, 8254.6, 5429.77, 13989.8,
        23906.13, 35894.83, 19038.17, 57486.87, 42050.43, 4698.59, 4889.07, 3502.96, 3792.41, 35353.73,
        12008.95, 41852.35, 2794.67, 30638.87, 18560.88, 4888.95, 136766.46, 8011.59, 55775.72
    ],
    "2019-20": [
        28242.39, 8987.57, 21721.44, 63406.33, 20205.84, 2479.85, 20232.09, 7111.53, 4677.56, 6801.81,
        20593.04, 30919, 16401.05, 49517.61, 36219.64, 4047.77, 4211.78, 3017.8, 3267.08, 30453.25,
        10345.78, 36049.14, 2407.69, 26392.4, 15987.59, 4211.78, 117818.3, 6901.54, 48048.4
    ],
    "2020-21": [
        24460.59, 10472.58, 18629.32, 59861.41, 20337.54, 2296.53, 20218.53, 6437.59, 4753.92, 0,
        19712.23, 21694.11, 11560.4, 46922.16, 36504.01, 4271.97, 4551.63, 3010.55, 3409.25, 27542.67,
        10638.21, 35575.77, 2308.47, 24924.51, 12691.62, 4218.45, 106687.01, 6568.72, 44737.01
    ],
    "2021-22": [
        35385.83, 14643.9, 28150.55, 91352.62, 28570.86, 3356.98, 31105.78, 9722.16, 7349.04, 0,
        27734.64, 33283.58, 17820.09, 69541.5, 54318.06, 6009.65, 6580.63, 4222.87, 4875.46, 38144.79,
        15288.79, 54030.61, 3353.69, 37458.6, 18720.54, 6077.52, 160358.05, 9906.25, 65540.75
    ],
    "2022-23": [
        38176.74, 16689.17, 29694.26, 95509.85, 32358.26, 3665.19, 33034, 10378, 7883.98, 0,
        31404.12, 34596.18, 18260.68, 74542.85, 60000.98, 6795.08, 7286.14, 4745.25, 5400.19, 42989.33,
        17163.65, 57230.78, 3680.28, 38731.24, 19668.15, 6724.23, 169745.3, 10617.01, 71434.93
    ]
}

df = pd.DataFrame(data)

# Data Cleaning: Remove states with 0 in latest year (likely missing or incomplete data)
df = df[df["2022-23"] != 0]

# Normalize the values for clustering
scaler = MinMaxScaler()
numeric_cols = df.columns[1:]  # exclude 'State'
df_scaled = pd.DataFrame(scaler.fit_transform(df[numeric_cols]), columns=numeric_cols)

# Add 'State' back to the scaled DataFrame
df_scaled['State'] = df['State'].values

# Clustering
kmeans = KMeans(n_clusters=3, random_state=42)
df_scaled['Cluster'] = kmeans.fit_predict(df_scaled[numeric_cols])

# Merge with original data for visualization
df_vis = df.merge(df_scaled[['State', 'Cluster']], on='State')

# Visualization
plt.figure(figsize=(12, 6))
sns.boxplot(data=df_vis, x='Cluster', y='2022-23')
plt.title('State-wise 2022-23 Values by Cluster')
plt.ylabel('Amount in Crores')
plt.xlabel('Cluster')
plt.grid(True)
plt.tight_layout()
plt.show()

# Lineplot: Growth trend of a few sample states
sample_states = ['Bihar', 'Uttar Pradesh', 'Kerala', 'Tamil Nadu']
df_long = df_vis[df_vis['State'].isin(sample_states)].melt(id_vars='State', value_vars=numeric_cols)
plt.figure(figsize=(12, 6))
sns.lineplot(data=df_long, x='variable', y='value', hue='State', marker='o')
plt.title('Year-wise Trend for Sample States')
plt.ylabel('Amount in Crores')
plt.xlabel('Year')
plt.grid(True)
plt.tight_layout()
plt.show()
