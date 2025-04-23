#RUN THE WHOLE SCRIPT -> Ctrl + Shift + S
#MULTILINE COMMENT ->  Ctrl + Shift + C

dataset_dir <- getwd()

#Can't upload the data on the repository, but you can ask Daniel Dobrenz (daniel.dobrenz at gmail.com) for it!

file_path <- file.path(dataset_dir, "colombia_financial_inclusion_dataset_translated_cleaned.csv")

colombia_financial_inclusion_dataset <- read.csv(file_path, header = TRUE)

## EDA

#Checking dimension, structure of dataset

dim(colombia_financial_inclusion_dataset)

#There are 1 391 139 observations and 99 variables, giving a total dimension of 13 772 2761 data points

table(sapply(colombia_financial_inclusion_dataset, class))

#After some initial inspection, better alter data types

cols_to_convert <- c("entity_type", "entity_code", "unified_capital", "category_code")

colombia_financial_inclusion_dataset[cols_to_convert] <- lapply(
  colombia_financial_inclusion_dataset[cols_to_convert], as.character
)

#5 factor variables, 54 integer and 40 numeric (floating point)

zero_rows <- rowSums(colombia_financial_inclusion_dataset[, 10:99] == 0) == ncol(colombia_financial_inclusion_dataset[, 10:99])
relative_count <- sum(zero_rows) / nrow(colombia_financial_inclusion_dataset)

#Roughly 16% of the dataset has zeros on the numeric variables, they encompass the 10 to 99th columns.

na_percentage <- (colSums(is.na(colombia_financial_inclusion_dataset)) / nrow(colombia_financial_inclusion_dataset)) * 100

#No NAs

#Ignore duplicate counting if not running on with some kind of GPU! Else, code breaks!

#duplicate_rows <- sum(duplicated(colombia_financial_inclusion_dataset)) 

#How sparse is the dataset?

numeric_vars <- colombia_financial_inclusion_dataset[, sapply(colombia_financial_inclusion_dataset, is.numeric)]

sparsity_check <- data.frame(
  Variable = names(numeric_vars),
  Zero_Percentage = sapply(numeric_vars, function(x) mean(x == 0, na.rm = TRUE) * 100)
)

sparsity_check <- sparsity_check[order(-sparsity_check$Zero_Percentage), ]

summary(sparsity_check$Zero_Percentage)

boxplot(sparsity_check$Zero_Percentage)

#Extremely sparse, minimum 75% of variable sparsity with half of the variables surpassing the 97.5% sparsity!


# First analysis: Home loans differences between men & women, between regions and sub-regions (categories)

#Check variables that match housing loans variables

loan_vars <- grep("loans", names(colombia_financial_inclusion_dataset), value = TRUE, ignore.case = TRUE)

housing_vars <- grep("housing", names(colombia_financial_inclusion_dataset), value = TRUE, ignore.case = TRUE)

housing_loan_vars <- intersect(loan_vars, housing_vars);

cfid_housing_loans <- colombia_financial_inclusion_dataset[, c(housing_loan_vars, "region_description", "category_description"), drop = FALSE];

par(mfrow = c(2, 2))

plot(cfid_housing_loans$number_of_housing_loans_men ~ cfid_housing_loans$region_description, 
     main = "Housing Loans (Men) by Region",
     xlab = "Region", 
     ylab = "Number of Loans")

plot(cfid_housing_loans$number_of_housing_loans_women ~ cfid_housing_loans$region_description, 
     main = "Housing Loans (Women) by Region",
     xlab = "Region", 
     ylab = "Number of Loans")

plot(cfid_housing_loans$number_of_housing_loans_men ~ cfid_housing_loans$category_description, 
     main = "Housing Loans (Men) by Category",
     xlab = "Category", 
     ylab = "Number of Loans")

plot(cfid_housing_loans$number_of_housing_loans_women ~ cfid_housing_loans$category_description, 
     main = "Housing Loans (Women) by Category",
     xlab = "Category", 
     ylab = "Number of Loans")


#Not informative!!!!

#What about proportion of housing loans differences between men

prop_housing_loans_men = ifelse(cfid_housing_loans$number_of_housing_loans != 0,cfid_housing_loans$number_of_housing_loans_men/cfid_housing_loans$number_of_housing_loans, 0)

prop_housing_loans_women = ifelse(cfid_housing_loans$number_of_housing_loans != 0,cfid_housing_loans$number_of_housing_loans_women/cfid_housing_loans$number_of_housing_loans, 0)

summary(prop_housing_loans_men)

summary(prop_housing_loans_women)

#Proportion of housing loans by men falls out of bounds, it should be between 0 and 1 but it gets the max value of 230000000. 
#Apart from this, the distribution of this variable is highly concentrated, with first quartile = mean = median = third quartile

# Proportion of housing loans by women on the other hand does fall between 0 and 1, but also incredibly concentrated.
#As with men, first quartile = mean = median = third quartile

#All in all, this dataset reveals serious defficiencies and shouldn't be used as a use-case!


