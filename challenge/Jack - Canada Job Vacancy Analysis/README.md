# Project Background
Here I looked to examine data regarding job vacancies in Canada in order to determine if there are any trends that may positively or negatively impact certain demographics.
Insights are provided based on the following data:
-	Job Vacancies: At the core of this analysis, the total number of jobs available was examined, focusing on necessary job requirements including minimum education and experience.
-	Unemployment Rate: The percentage of participating Canadian workers unable to find jobs.
-	Total Workers in Canada: An evaluation of how much the total workforce is increasing.

Python was used to obtain some of the data used for this analysis, the code can be found [here](https://github.com/JackLemere/DataKind-Financial-Inclusion-2025/blob/main/Canada%20Job%20Vacancy%20Analysis/Stats%20Canada%20Workforce%20Data%20Scrape.ipynb).

A Tableau dashboard containing the relevant visualizations as seen below can be found [here](https://public.tableau.com/app/profile/jack.lemere5367/viz/CanadaJobTrends/Dashboard1?publish=yes).

![alt text](https://github.com/JackLemere/DataKind-Financial-Inclusion-2025/blob/main/Canada%20Job%20Vacancy%20Analysis/dashboard.png "Dashboard")

# Data

The data used in this analysis examined 3 different tables:
-	**Table 1**: Statistics Canada. Table 14-10-0443-01  Job vacancies, proportion of job vacancies and average offered hourly wage by occupation and selected characteristics, quarterly, unadjusted for seasonality [link](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410044301&pickMembers%5B0%5D=1.1&pickMembers%5B1%5D=2.1&cubeTimeFrame.startMonth=01&cubeTimeFrame.startYear=2016&cubeTimeFrame.endMonth=10&cubeTimeFrame.endYear=2024&referencePeriods=20160101%2C20241001)
-	**Table 2**: Statistics Canada. Table 14-10-0020-01  Unemployment rate, participation rate and employment rate by educational attainment, annual [link](https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=1410002001)
-	**Table 3**: Statistics Canada. Table 14-10-0288-02  Employment by class of worker, monthly, seasonally adjusted (x 1,000) [link](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028802&pickMembers%5B0%5D=1.1&pickMembers%5B1%5D=3.1&cubeTimeFrame.startMonth=02&cubeTimeFrame.startYear=2000&referencePeriods=20000201%2C20000201)

# Summary

### Overview of Findings

The following insights have been noted:
-	Total job vacancies have been declining since a strong peak in 2022
-	Job vacancies requiring less previous experience are declining at a faster rate than all other prior experience requirements
-	Jobs with lower education requirements are declining at a faster rate than all other minimum education requirements
-	Growth rate of employment in Canada has not changed significantly in recent years
-	Unemployment rate in Canada has increased in 2024 from previous years

# Insights Deep Dive

The first analysis done was on job vacancies in relation to the necessary experience required for those jobs. The first dataset breaks down the total job vacancies by the amount of experience required by each job. They are split into categories Less than 1 year, 1-3 years, 3-5 years, 5-8 years, and 8+ years. By examining these job vacancies by their required experience, it was found that the number of jobs that require no experience has been declining particularly heavily over the past two years. The total number of job vacancies for all other experience levels appears to reflect the general growth of employment in Canada, though the number of job vacancies requiring no experience has fallen to its lowest tally since 2017 despite a growing population of workers. This may be an indication that jobs that fall into these categories are becoming increasingly competitive. Having a more competitive job market is generally good for businesses, however it may lead to more barriers for job applicants in these affected demographics to feel more obstacles when job seeking, leading to a decrease in economic opportunities.

![alt text](https://github.com/JackLemere/DataKind-Financial-Inclusion-2025/blob/main/Canada%20Job%20Vacancy%20Analysis/jobs%20by%20experience.png "Job Vacancy By Experience")

A similar comparison can be made when it comes to education. The dataset also breaks down job vacancies by their minimum education requirements. These requirements are broken down into no minimum education required, high school diploma, non-university certificate, university certificate below bachelor’s degree, bachelor’s degree, and university certificate above bachelor’s degree. What was found was that jobs with lower education requirements are seeing a stronger decrease in vacancies than jobs with higher education requirements. Since 2016, jobs with no education requirements followed by high school diploma jobs have seen the highest number of vacancies than any other category. As of 2024, the jobs that have highest proportion of vacancies are those that require at least a non-university certificate. Similarly to the experiential analysis, having a lack of education may lead to increased competition from some people when searching for work, resulting in lowered economic opportunities. 

![alt text](https://github.com/JackLemere/DataKind-Financial-Inclusion-2025/blob/main/Canada%20Job%20Vacancy%20Analysis/jobs%20by%20education.png "Job Vacancy By Education")

The trends identified so far also coincide with a small increase in unemployment rate. Apart from the large increase in unemployment during the COVID-19 lockdown periods, the unemployment rate in Canada had been steadily decreasing. However, 2024 saw an increase in unemployment rate for the first time since 2020. Despite a consistent increase in the number of workers in Canada over the years, the number of total job vacancies in all areas has seen a decline in recent years. This may indicate higher job market competition in general, though the previous analysis would indicate those with low education or experience are likely the most affected.

![alt text](https://github.com/JackLemere/DataKind-Financial-Inclusion-2025/blob/main/Canada%20Job%20Vacancy%20Analysis/overall%20trends.png "Job Trends in Canada")

# Further Questions:

Although there is a host of potential additions that would help to enrich this analysis, I believe the following should be further explored: 
-	What is causing the total number jobs vacancies with little education or experience to decline in recent years? Some possibilities may involve new technological advancements, evolving education demographics, emerging and declining business sectors, policy changes, etc.
-	How much of an impact do these changing trends have on economic opportunity for those who fall in these demographics? Further analysis on whether these types of jobs are now more competitive and causing difficulty in securing employment would be beneficial.
-	If these trends are indicators of lower economic opportunity, what can be done to mitigate it? Having a clearer picture of the job market would help further initiatives such as getting people better access to job experience and education or creating more jobs in which these potential barriers are not required.
-	What other datasets can these be merged with to further these insights? Ex. Could unemployment rate be broken down by education or experience? How are various sectors affected?

# Analysis Process

Before beginning this analysis, I first decided to try to really understand the objective in detail by diving deep into what financial inclusion and economic opportunity meant in Canada. I highlighted definitions, clear examples, and then brainstormed what may be promoting or hindering access to these examples. This gave me a better idea of what kind of data to seek out. DataKind has kindly provided some examples of this, which include:

- Job availability: Access to employment that offers fair wages and benefits.
- Entrepreneurship: Opportunities to start and grow businesses (e.g. access credit or loans).
- Education and skill development: Access to training and education to enhance employability.
- Access to markets and financial services: Opportunities to access capital, resources, and markets for economic growth.
- Home or land ownership: Opportunity to contribute to long-term financial security and wealth generation.

I then began searching for datasets relating to these topics and found Statistics Canada to be a great open source for these topics. From there I found the table that I would use as Table 1 for this analysis and began drawing insights from what I saw. Much of data I obtained from Statistics Canada did not require much cleaning apart from the removal of some unnecessary metadata columns. I primarily used Excel to sort and filter the data as needed in order to draw out some insights. I would then document the insights I found and have shared them here. The excel document in which most of the data was analysed can be found [here](https://github.com/JackLemere/DataKind-Financial-Inclusion-2025/blob/main/Canada%20Job%20Vacancy%20Analysis/jobs.xlsx).

# Things That Did Not Work and Works in Progress

- At first, I wanted to compare the growth rate of job vacancies to the overall population of Canada, however I noted that much of the population growth in Canada was not a true reflection of job demand in Canada due to many Canadians not requiring employment. I then decided to search for more relevant data and came across Table 3 which highlights the total number of employees in Canada over time.

- Knowing I wanted to utilize Table 3 for my analysis, I first decided to try to use the data as it was presented on the Statistics Canada website. This method however saw some problems, as I could not have all the time periods I required in one table, meaning I would have had to download each table separately and merge them together. To get around this, I created a Python script that would scrape the data for me and give me the totals for all working employees in Canada over the time period I required.

- When examining unemployment rate, the dataset I found had the unemployment rates for each level of education. This was initially very useful as I had done analysis on various education levels and wanted to compare them. One issue I had was that the data was divided in different groups, this one including categories such as 'Years 0-8' for an education group which my prior dataset did not include. As a result, I was not able to find a way to accurately merge these tables since I did not have information on the total populations of these groups and only had the unemployed percentages. This is something I hope I can continue to build on and hopefully find a way to merge these tables to further my insights.

- Finally, as briefly mentioned in the analysis process section, this analysis of job availability in Canada is just one of many aspects that make up overall economic opportunity in Canada. The next steps will be to hopefully find further insights relating to this topic, but also to look more into other examples of financial inclusion and economic opportunity. Looking more into these other categories may help shed some light on the analysis done here and provide further insights relating to this topic.
