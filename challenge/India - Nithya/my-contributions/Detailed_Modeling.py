import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans, DBSCAN
from sklearn.linear_model import LinearRegression
import numpy as np

import pandas as pd

# Load the uploaded dataset
file_path = "RS_Session_259_AU_3111.csv"
df = pd.read_csv(file_path)

# Display the first few rows and the column names to inspect the structure
df.head(), df.columns

# Step 1: Clean and Prepare Data
df_clean = df.drop(columns=['Sl. No.'])
df_clean = df_clean[df_clean['State'] != 'Total']
df_clean.set_index('State', inplace=True)

# Convert all columns to numeric (ensure float type)
df_clean = df_clean.apply(pd.to_numeric, errors='coerce')

# Step 2: Line Plot of Trends
plt.figure(figsize=(14, 8))
for state in df_clean.index:
    plt.plot(df_clean.columns, df_clean.loc[state], label=state, alpha=0.5)
plt.title("Yearly Financial Trends by State")
plt.xlabel("Year")
plt.ylabel("Amount (in Cr)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# Step 3: Linear Regression per state for trend slope
years = np.array([int(col[:4]) for col in df_clean.columns]).reshape(-1, 1)
slopes = {}
for state in df_clean.index:
    y = df_clean.loc[state].values
    model = LinearRegression().fit(years, y)
    slopes[state] = model.coef_[0]

# Plot top states by positive growth rate
sorted_slopes = dict(sorted(slopes.items(), key=lambda item: item[1], reverse=True))
top_states = list(sorted_slopes.keys())[:10]
top_growth = list(sorted_slopes.values())[:10]

plt.figure(figsize=(12, 6))
sns.barplot(x=top_states, y=top_growth, palette="viridis")
plt.title("Top 10 States by Growth Rate (Linear Regression Slope)")
plt.ylabel("Growth Rate (slope)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# Step 4: KMeans Clustering based on expenditure pattern
scaler = StandardScaler()
scaled_data = scaler.fit_transform(df_clean)

kmeans = KMeans(n_clusters=4, random_state=42)
clusters = kmeans.fit_predict(scaled_data)

df_clean['Cluster'] = clusters

# Visualize Clusters
plt.figure(figsize=(10, 6))
sns.boxplot(x='Cluster', y='2022-23', data=df_clean.reset_index())
plt.title("Cluster Distribution Based on 2022-23 Expenditure")
plt.tight_layout()
plt.show()

# Step 5: PCA + DBSCAN for anomaly detection
pca = PCA(n_components=2)
pca_data = pca.fit_transform(scaled_data)

dbscan = DBSCAN(eps=0.9, min_samples=2)
db_labels = dbscan.fit_predict(pca_data)

plt.figure(figsize=(10, 6))
sns.scatterplot(x=pca_data[:, 0], y=pca_data[:, 1], hue=db_labels, palette='tab10', s=100)
plt.title("DBSCAN Clustering on PCA-Reduced Data")
plt.xlabel("PCA Component 1")
plt.ylabel("PCA Component 2")
plt.legend(title="Cluster Label")
plt.tight_layout()
plt.show()

# Step 6: Correlation Heatmap
corr_matrix = df_clean.drop(columns='Cluster').T.corr()
plt.figure(figsize=(14, 12))
sns.heatmap(corr_matrix, cmap='coolwarm', xticklabels=False, yticklabels=False)
plt.title("Correlation Heatmap Between States Based on Trends")
plt.tight_layout()
plt.show()
