# Mexico - Financial Inclusion Analysis
Brandon Rugg, April 2025

This folder contains an analysis of financial and infrastructure across Mexican municipalities. The work is based on data from the CNBV Financial Inclusion Database (Sept 2024) and demographic and housing data from the INEGI ITER 2020 Census. 

Financial inclusion (measured using an index derived from five metrics such as the number of savings accounts per adult) shows strong positive correlations with indicators of digital access and education, including the percentage of homes with computers (r = 0.69), internet access (r = 0.65), and adults with post-basic education (r = 0.60). It also shows strong negative correlations with markers of socioeconomic vulnerability, such as lack of motor vehicles (r = –0.57), illiteracy (r = –0.53), and dirt floors in homes (r = –0.45).

These variables are highly skewed across municipalities, reflecting persistent regional disparities. Future analysis of the two contained datasets could focus on the geographic distribution of financial inclusion, infrastructure quality, the relative activity of commercial banks vs. EACPs (regulated community financial institutions in Mexico), and potential differences in account ownership by gender.

There are two Jupyter Notebook files:
- **'Mexico data wrangling.ipynb'**, which processes the CNBV and INEGI datasets. URLs for the original data files are provided. Some formatting of the initial files were performed manually, including translations of column titles in the CNBV .xlsx file. Some very basic cleaning of column titles is performed.
- **'exploratory_analysis.ipynb'**, which combines the two datasets, performs feature engineering, and analyzes the correlations between financial metrics, and then between the calculated "Financial Inclusion Index" and housing and demographic data. I also started trying to generate a map of the FII across municipalities, but wasn't able to get it working.

Other files:
- A 2016 report from the Mexican National Council for Financial Inclusion (https://www.gob.mx/cms/uploads/attachment/file/199615/Mexico_s_National_Policy_Financial_Inclusion.pdf)
- A GeoJSON file for Mexico's municipalities to be used for mapping

