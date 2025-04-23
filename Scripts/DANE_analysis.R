#RUN THE WHOLE SCRIPT -> Ctrl + Shift + S
#MULTILINE COMMENT ->  Ctrl + Shift + C

library(ggplot2)

dataset_dir <- getwd()

file_path <- file.path(dataset_dir, "DANE_data.csv")

dane_dataset <- read.csv(file_path, header = TRUE, fileEncoding = "UTF-8")

## EDA

#Checking dimension, structure of dataset

dim(dane_dataset)

#There are 830743 observations and 183 variables, giving a total dimension of 152 025 969 data points

table(sapply(dane_dataset, class))

#105 factor variables, 3 integer and 75 numeric (floating point)

na_percentage <- (colSums(is.na(dane_dataset)) / nrow(dane_dataset)) * 100

na_categories <- cut(
  na_percentage,
  breaks = c(-Inf, 0, 50, 75, Inf),
  labels = c("0%", ">0% & <=50%", ">50% & <=75%", ">75%"),
  right = TRUE
)

na_summary <- table(na_categories)

#Most (108) variables have no NA, but a sizeable minority (63) has more than 50% NA

numeric_dane_dataset <- dane_dataset[sapply(dane_dataset, is.numeric)]

sparsity_check <- data.frame(
  Variable = names(numeric_dane_dataset),
  Zero_Percentage = sapply(numeric_dane_dataset, function(x) mean(x == 0, na.rm = TRUE) * 100)
)

sparsity_check <- sparsity_check[order(-sparsity_check$Zero_Percentage), ]

summary(sparsity_check$Zero_Percentage)

#Not sparse, minimum coincindes with first quartile and median, revealing that most variables have 0% of variable sparsity

## Introductory aspects

# Define conversion rate
COP_TO_USD <- 0.000241

#Cleaning
colnames(dane_dataset) <- gsub(" +", " ", 
                               gsub("\\.", " ", 
                                    gsub("\\.\\.last\\.12\\.months\\.", "(last 12 months)", 
                                         gsub("\\.\\.last\\.month\\.", "(last month)", 
                                              colnames(dane_dataset)))))


colnames(dane_dataset) <- gsub("([a-zA-Z0-9])\\(last 12 months\\)", "\\1 (last 12 months)", colnames(dane_dataset))
colnames(dane_dataset) <- gsub("([a-zA-Z0-9])\\(last month\\)", "\\1 (last month)", colnames(dane_dataset))




# Columns to convert 
monetary_cols <- c(
  'total_labor_income', 'main_job_gross_income', 'overtime_income_amount',
  'food_as_pay_value', 'housing_as_pay_value', 'company_transport_value',
  'other_in_kind_income_value', 'withholding_tax_amount', 'secondary_job_income',
  'Income amount last month', 'Earned income last month',
  'Amount received for rentals (last month)', 'Amount received from pensions or retirement (last month)',
  'Amount received as alimony (last month)', 'Amount received from households in country (last 12 months)',
  'Amount received from households abroad (last 12 months)', 'Amount received from institutions in country (last 12 months)',
  'Amount from national private entities (last 12 months)', 'Amount from government entities (last 12 months)',
  'Amount from More Families in Action (last 12 months)', 'Amount from Youth in Action (last 12 months)',
  'Amount from Colombia Mayor (last 12 months)', 'Amount from other programs (last 12 months)',
  'Amount from entities outside the country (last 12 months)', 'Amount received from investments (last 12 months)',
  'Amount received from severance pay or interest (last 12 months)', 'Amount received from other sources (last 12 months)',
  'Monthly amortization fee', 'Actual monthly rent payment', 'Monthly health payment (COP)',
  'Amount paid in property tax (last 12 months)', 'Amount paid in capital gains tax (last 12 months)',
  'Amount paid in vehicle tax (last 12 months)', 'Amount paid in income and supplementary tax (last 12 months)',
  'Amount paid in taxes on winnings or asset sales (last 12 months)'
)

# Clean & convert columns
for (col in monetary_cols) {
  if (col %in% colnames(dane_dataset)) {
    dane_dataset[[col]] <- suppressWarnings(as.numeric(dane_dataset[[col]]))
    dane_dataset[[col]][dane_dataset[[col]] == 0] <- NA
    dane_dataset[[paste0(col, '_USD')]] <- round(dane_dataset[[col]] * COP_TO_USD, 2)
  }
}

# Define financial product columns
financial_product_cols <- c(
  'Uses checking account', 'Uses savings account', 'Uses CDT',
  'Uses home purchase loan', 'Uses vehicle purchase loan',
  'Uses free investment loan', 'Uses credit card', 'Uses other financial product'
)

# Binary conversion function
yes_no_to_binary <- function(vec) {
  vec <- tolower(trimws(as.character(vec)))
  return(ifelse(vec == "yes", 1, 0))
}


dane_dataset[financial_product_cols] <- lapply(dane_dataset[financial_product_cols], as.character)


# Apply conversion
dane_dataset[paste0(financial_product_cols, "_bin")] <- lapply(dane_dataset[financial_product_cols], yes_no_to_binary)


# Financial inclusion flags
bin_cols <- paste0(financial_product_cols, '_bin')
dane_dataset$has_any_financial_product <- as.integer(rowSums(dane_dataset[, bin_cols], na.rm = TRUE) > 0)

savings_cols <- paste0(c('Uses checking account', 'Uses savings account', 'Uses CDT'), '_bin')
dane_dataset$uses_savings_product <- rowSums(dane_dataset[, savings_cols], na.rm = TRUE) > 0

credit_cols <- paste0(c('Uses credit card', 'Uses home purchase loan', 'Uses vehicle purchase loan', 'Uses free investment loan'), '_bin')
dane_dataset$uses_credit_product <- rowSums(dane_dataset[, credit_cols], na.rm = TRUE) > 0

# Financial exclusion
dane_dataset$is_financially_excluded <- yes_no_to_binary(dane_dataset[['Uses none of the above']])

## Financial Product Usage by Region

#How many data points exist per region? How is it distributed?

#First, some name cleaning

# Convert 'Region' to factor and then Remove the empty string level from the 'Region' factor
dane_dataset$Region = as.factor(dane_dataset$Region)

dane_dataset$Region <- factor(dane_dataset$Region, levels = levels(dane_dataset$Region)[levels(dane_dataset$Region) != ""])

# Drop any unused levels
dane_dataset$Region <- droplevels(dane_dataset$Region)


region_counts <- table(dane_dataset$Region)

region_percentages <- prop.table(region_counts) * 100

region_percentages_sorted <- sort(region_percentages, decreasing = TRUE)

#Quite a lot actually! Min: 1060 e max:  48114

# Plot

barplot(region_percentages_sorted,
        las = 2,              
        col = "lightblue",      
        border = NA,     
        main = "Percentage of Observations per Region",
        ylab = "Percentage",
        ylim = c(0, 6),
        cex.names = 0.7     
)

# Compute percentages by region

region_perc_df <- as.data.frame(region_percentages)
colnames(region_perc_df) <- c("Region", "Percentage")


# Group by Region and calculate usage percentage

region_usage <- aggregate(. ~ Region, 
                          data = dane_dataset[c("Region", paste0(financial_product_cols, "_bin"))],
                          FUN = mean)
#To get percentage
region_usage[ , -1] <- region_usage[ , -1] * 100

#Studying other interesting variables such as Gender, Age, Unemployed, CLASE

class(dane_dataset$Gender)

levels(dane_dataset$Gender)

# Remove the empty string level from the 'Gender' factor
dane_dataset$Gender <- factor(dane_dataset$Gender, levels = levels(dane_dataset$Gender)[levels(dane_dataset$Gender) != ""])

# Drop any unused levels
dane_dataset$Gender <- droplevels(dane_dataset$Gender)

gender_counts = table(dane_dataset$Gender)

round(prop.table(gender_counts) * 100,2)

#53.33% of data is women and 46.67% is men

class(dane_dataset$Age)

age_counts = table(dane_dataset$Age)

#Pretty dispersed, from 0 to 108! 

round(prop.table(age_counts) * 100,2)

#Testing normality, since it is numeric

# Histogram
hist(dane_dataset$Age, main = "Histogram of Age", xlab = "Age", col = "lightblue", border = "black")

#left skewed, but could be Normal

# Q-Q Plot
qqnorm(dane_dataset$Age)
qqline(dane_dataset$Age, col = "red")

#Not really normal, it's more sigmoidal than linear the relationship between sample and theoretical normal quantiles

# Kolmogorov-Smirnov test against normal distribution
ks.test(dane_dataset$Age, "pnorm", mean(dane_dataset$Age), sd(dane_dataset$Age))

#p-value rather small, doesn't indicate normality. Better categorize it

dane_dataset$Age_Category <- cut(dane_dataset$Age,
                                 breaks = c(0, 20, 34, 64, Inf),
                                 labels = c("Young", "Young Adult", "Adult", "Senior"),
                                 right = TRUE)


class(dane_dataset$Unemployed)

levels(dane_dataset$Unemployed)

# Replace the empty string level with "Not unemployed"
levels(dane_dataset$Unemployed)[levels(dane_dataset$Unemployed) == ""] <- "Employed"

unemployment_counts = table(dane_dataset$Unemployed)

round(prop.table(unemployment_counts) * 100,2)

#Very unbalanced, unemplyment stands at 5.71%

class(dane_dataset$CLASE)

levels(dane_dataset$CLASE)

# Remove the empty string level from the 'CLASE' factor
dane_dataset$CLASE <- factor(dane_dataset$CLASE, levels = levels(dane_dataset$CLASE)[levels(dane_dataset$CLASE) != ""])

area_counts = table(dane_dataset$CLASE)

round(prop.table(area_counts) * 100,2)


#Let's try and model  'Uses checking account', 'Uses home purchase loan' and 'Uses credit card' on 'Gender', 'Age', 'Unemployed', 'CLASE' and 'Region'

#1. Uses checking account_bin

#Check distribution between interesting variables

vars <- list(
  Region = dane_dataset$Region,
  Gender = dane_dataset$Gender,
  Age_Category = dane_dataset$Age_Category, 
  Unemployed = dane_dataset$Unemployed, 
  CLASE = dane_dataset$CLASE
)

for (var_name in names(vars)) {
  cat("=====================================\n")
  cat("Contingency Table for:", var_name, "\n")
  cat("=====================================\n")
  
  var_data <- vars[[var_name]]
  tbl <- table(var_data, dane_dataset$`Uses checking account_bin`)
  prop_tbl <- prop.table(tbl, margin = 1)
  
  cat("\nAbsolute counts:\n")
  print(tbl)
  
  cat("\nRow-wise proportions:\n")
  print(round(prop_tbl, 4))
  
  cat("\n\n")
}

#Throughout all variables, the vast majority indicates absence of checking account usage. A finer grained approach is needed.


logit_checking_account <- glm(`Uses checking account_bin` ~ Gender + Age + Unemployed + CLASE + Region, 
              data = dane_dataset, 
              family = binomial)

summary(logit_checking_account)

#Testing model statisctically

anova(logit_checking_account, test = "Chisq")

#All variables, except for unemployment, contribute to expain usage of checking account

#Get odds ratio and confidence interval

exp(coef(logit_checking_account))          # OR

#Analysis, with all variables constant (ceteris paribus):

#Men have a 75% higher chance of using a checking account;
#Each year increases 3% the chance of using a checking account;
#Living in a urban region increases circa 4.246 times the chance of using a checking account!
#Do regional results go hand in hand with the current socioeconomic status of Colombia?

#In general, yes! The regions with higher levels of urbanization, economic development, and population density tend to have a higher probability of having a checking account.

#Some specific points:
  
#  Bogotá, Antioquia, Valle, Atlántico, Bolívar → These are financial and economic centers → higher levels of banking access.

# Amazonas, Vaupés, Guainía, Arauca → Remote regions with limited banking infrastructure → lower or unstable odds ratios (ORs).

# Putumayo shows an extremely high OR (> 50), which is most likely due to a small sample size or sampling bias. In fact, Putumayo accounts for only 0.48% of the observations in the dataset, while it represents approximately 0.8% of the Colombian population, indicating possible underrepresentation.

#Extract CI for OR (no ability to use MASS, manual calculation!)

coef_logit <- coef(logit_checking_account)
se_logit <- sqrt(diag(vcov(logit_checking_account)))

# CI (95%)
z_value <- qnorm(0.975)  # 1.96
lower_ci <- coef_logit - z_value * se_logit
upper_ci <- coef_logit + z_value * se_logit

# Convert to OR and respective CI
or <- exp(coef_logit)
lower_or <- exp(lower_ci)
upper_or <- exp(upper_ci)

or_table <- data.frame(
  Lower95CI = lower_or,
  Upper95CI = upper_or
)

print(round(or_table, 3))

# Interpretation of Odds Ratios and Confidence Intervals (CIs)
# Now looking at the confidence intervals (95% CI) for the odds ratios of the logistic regression:
#   
#   Men have between 63% and 88% higher odds of having a checking account than women.
# 
# Each additional year of age increases the odds by 2.8% to 3.1%, suggesting a consistent age-related effect.
# 
# Being unemployed decreases the odds by 9% to 36%, suggesting that employment status is a relevant barrier to financial access.
# 
# Living in urban areas is associated with a 3.5 to 5.1 times higher probability of having a checking account.
# 
# These effects are statistically significant and align with expected socioeconomic patterns.
# 
# Regional Patterns and Interpretation
# Many regions show high odds ratios with relatively narrow confidence intervals, especially:
#   
#   Bogotá D.C., Valle del Cauca, Bolívar, Atlántico, Santander, Nariño, Risaralda, Magdalena
# → These are economically active and urbanized regions, and the model reflects that clearly through consistently elevated odds ratios and tight confidence bounds.
# 
# However, certain regions show extremely wide or unstable confidence intervals, notably:
#   
#   Putumayo: OR between 16.9 and 167, likely reflecting a very small sample size or sampling bias. This is supported by the fact that Putumayo represents only 0.48% of the dataset, while accounting for around 0.8% of the Colombian population, suggesting underrepresentation.
# 
# Arauca and Guainía: CIs range from close to zero up to astronomical values (e.g., Arauca’s upper bound exceeds 10⁷²!), which strongly indicates model instability.
# 
# Why does this happen? A few possible explanations:
#   
#   Sparse data: If only a handful of individuals from these regions appear in the dataset, especially with little variation in the outcome (e.g., almost all with or without a checking account), the model struggles to estimate a reliable effect.
# 
# Perfect or quasi-perfect separation: If, for example, all individuals in a region either have or don’t have a checking account, logistic regression estimates can diverge towards infinity.
# 
# Collinearity with other predictors: If regional variables correlate highly with other features (e.g., urban/rural), the model may attribute the effect inconsistently.
# 
# Summary
# The model effectively captures national socioeconomic patterns:
#   
#   Urbanization and age have clear, interpretable effects.
# 
# Employment remains a relevant factor in financial access.
# 
# Regional disparities in odds ratios largely mirror existing inequalities in infrastructure and development.
# 
# However, care must be taken when interpreting results from underrepresented or low-population regions, where odds ratios can be highly unstable or misleading due to sample issues.

#Pseudo R-squared (McFadden) -> Assessing model's performance

pseudo_r2_mcfadden <- function(model) {
  1 - model$deviance / model$null.deviance
}


pseudo_r2 = pseudo_r2_mcfadden(logit_checking_account)

#Model explains around 9.7% of data variability, which is decent given that it is a big dataset and there's big variability.

#Worth trying another model with macro-region groupings, to mitigate some problematic regions let's say.

## Using macro-regions

# Initialize a character vector to store macro-regions
Macro_Region <- character(length(dane_dataset$Region))

# Assign macro-region labels based on Region values
Macro_Region[dane_dataset$Region %in% c("Bogotá", "Antioquia", "Boyacá", "Cundinamarca",
                                        "Caldas", "Risaralda", "Quindío", "Santander",
                                        "Norte de Santander", "Tolima", "Huila")] <- "Andean"

Macro_Region[dane_dataset$Region %in% c("Atlántico", "Bolívar", "Magdalena", "La Guajira",
                                        "Sucre", "Córdoba", "Cesar")] <- "Caribbean"

Macro_Region[dane_dataset$Region %in% c("Chocó", "Valle del Cauca", "Cauca", "Nariño")] <- "Pacific"

Macro_Region[dane_dataset$Region %in% c("Amazonas", "Caquetá", "Guainía", "Guaviare", "Meta",
                                        "Putumayo", "Vaupés", "Vichada")] <- "Amazon-Orinoquía"

Macro_Region[dane_dataset$Region %in% c("Arauca", "Casanare")] <- "Eastern Plains"

Macro_Region[dane_dataset$Region %in% c("San Andrés", "Providencia")] <- "Insular"


# Add the new macro-region variable to the data frame
dane_dataset$Macro_Region <- Macro_Region

#New model

logit_checking_account_simplified <- glm(`Uses checking account_bin` ~ Gender + Age + CLASE + Macro_Region,
                        data = dane_dataset, family = binomial)

summary(logit_checking_account_simplified)

# Pseudo R-squared (McFadden)
pseudo_R2_macro_region <- pseudo_r2_mcfadden(logit_checking_account_simplified)
pseudo_R2_macro_region

#The results didn't change much, even having a decrease on the Pseudo R-squared. It seems that detailed regions are better!

#We can test for interactions, using detailed regions

#Region and Urban/rural are usually related. We can explore that a bit more

# Create contingency table for CLASE and Region by 'Uses checking account'
prop_by_clase_region <- with(dane_dataset, 
                             table(CLASE, Region, `Uses checking account_bin`)[,, "1"])

# Convert counts into proportions
total_by_clase_region <- with(dane_dataset, 
                              table(CLASE, Region))

prop_by_clase_region <- prop_by_clase_region / total_by_clase_region

prop_by_clase_region_t <- t(prop_by_clase_region)

#Display the proportion table

prop_by_clase_region_t

#Barplot is not good because it's too much info, but it's easy to see that are very urban regions (e.g. Bogotá, Atlántico, Caldas) and rural ones (e.g. Risaralda, Bolívar) so worth exploring an interaction

# Interaction between CLASE and Age
logit_checking_account_inter_clase_age <- glm(`Uses checking account_bin` ~ Gender + Age * CLASE + Region,
                                              data = dane_dataset, family = binomial)

# Interaction between Gender and Age
logit_checking_account_inter_gender_age <- glm(`Uses checking account_bin` ~ Gender * Age + CLASE + Region,
                                               data = dane_dataset, family = binomial)

# Interaction between Region and CLASE
logit_checking_account_inter_region_clase <- glm(`Uses checking account_bin` ~ Gender + Age + CLASE * Region,
                                                 data = dane_dataset, family = binomial)
inter_models <- list(
  clase_age = logit_checking_account_inter_clase_age,
  gender_age = logit_checking_account_inter_gender_age,
  region_clase = logit_checking_account_inter_region_clase
)

# Pseudo R²
sapply(inter_models, pseudo_r2_mcfadden)

#Interactions seem to have a positive effect on explaining checking accounts behaviour, especially the interaction between Region and CLASE

#We will use a Chi square test to assess if gender afects the usage of a checking acount across age categories

#Setting up and some interesting visualizations

total_by_cat <- table(dane_dataset$Age_Category, dane_dataset$Gender)


users_by_cat <- with(dane_dataset, 
                     table(Age_Category, Gender, `Uses checking account_bin`)[,, "1"])

prop_by_cat <- users_by_cat / total_by_cat


# Transpose to compare gender side by side
prop_by_cat_t <- t(prop_by_cat)

# Barplot
barplot(prop_by_cat_t, beside = TRUE, col = c("lightblue", "salmon"),
        legend.text = TRUE, args.legend = list(title = "Gender", x = "topright"),
        main = "Proportion of Checking Account Usage by Age Category and Gender",
        ylab = "Proportion", xlab = "Age Category")


# 1. Calculate the number of non-users, except for child
non_users_by_cat <- total_by_cat - users_by_cat

# 2. Setup the Age_Category x Gender x Uses_checking_account (Yes/No) array
full_array <- array(data = c(users_by_cat, non_users_by_cat),
                    dim = c(dim(users_by_cat)[1], dim(users_by_cat)[2], 2),
                    dimnames = list(
                      Age_Category = dimnames(users_by_cat)[[1]],
                      Gender = dimnames(users_by_cat)[[2]],
                      Uses_checking_account = c("Yes", "No")
                    ))

# 3. Chi-square test per age category
for (cat in dimnames(full_array)[["Age_Category"]]) {
  cat_table <- full_array[cat, , ]  # submatrix: [Gender x Yes/No]
  cat(cat_table)
  cat("\n== Age category:", cat, "==\n")
  print(chisq.test(cat_table))
}

#Among Colombian adults and seniors, the probability of having a checking account is significantly associated with gender. At a younger age, less than 21, there's also a noticeable difference but not enough to be considered significant (sampling bias, inherent noise)

# Interaction between Region and CLASE, Gender and Age_Category
logit_checking_account_inter_region_clase_gender_age_category <- glm(`Uses checking account_bin` ~ Gender * Age_Category + CLASE * Region,
                                                 data = dane_dataset, family = binomial)

#The best model so far, with 12.1% of explained variability.



# Regional Differences in Financial Product Usage
# This document presents a statistical analysis to investigate whether there are significant differences across Colombian regions regarding the usage of various financial products. The dataset includes binary indicators for product usage, and the main grouping variable is Region.
# 
# 1. Objective
# To evaluate whether the proportion of users of each financial product differs significantly by region. We will:
#   
#   Use statistical hypothesis tests (ANOVA or Kruskal-Wallis) to compare group means.
# 
# Assess assumptions of normality and homogeneity of variance.
# 
# If appropriate, fit logistic regression models to predict usage probability based on region.
# 
# 2. Variables of Interest
# We focus on the following binary outcome variables (0 = does not use, 1 = uses):
#   
#   Uses_checking_account_bin
# 
# Uses_savings_account_bin
# 
# Uses_CDT_bin
# 
# Uses_home_purchase_loan_bin
# 
# Uses_vehicle_purchase_loan_bin
# 
# Uses_free_investment_loan_bin
# 
# Uses_credit_card_bin
# 
# Uses_other_financial_product_bin
# 
# The grouping variable is:
#   
#   Region: Factor with multiple levels (Colombian regions).

# Objective
# We aim to assess whether the region of residence significantly affects the likelihood of using various financial products. The variables under study are binary (0/1), so we will use:
#   
#   Kruskal-Wallis tests: non-parametric test comparing distributions across multiple groups.
# 
#   Logistic regression: to quantify the effect of region on the odds of using each financial product.

# Run Kruskal-Wallis tests for each binary variable by Region

var_names <- c()
stat_values <- c()
p_values <- c()

for (v in bin_cols) {
  # Eliminar NAs
  subset_data <- dane_dataset[!is.na(dane_dataset[[v]]) & !is.na(dane_dataset$Region), ]
  
  # Aplicar teste
  test <- kruskal.test(subset_data[[v]] ~ subset_data$Region)
  
  #Save results
  var_names <- c(var_names, v)
  p_values <- c(p_values, round(test$p.value,3))
}


kruskal_table <- data.frame(
  Variable = var_names,
  P_Value = round(p_values, 4)
)

#Order per p value
kruskal_table <- kruskal_table[order(kruskal_table$P_Value), ]

# Mostrar resultados
print(kruskal_table, row.names = FALSE)

# All tests return p-values effectively equal to zero (i.e., p < 2.2e-16 in R), which strongly suggests that there are statistically significant differences across regions for all financial product usage types.
# 
# The highest test statistics (i.e., largest deviations across regions) are found for:
#   
#   ���Uses other financial producn (χ² ≈ 14,154)
# 
#   ���Uses savings accounn (χ² ≈ 13,236)
# 
#   ���Uses credit carn (χ² ≈ 10,082)
# 
# These products show the most pronounced regional disparities in usage — for example, one region may have a high proportion of savings account users, while another has a much lower rate.


# Function to perform logistic regression and summarize diagnostics
for (v in bin_cols) {
  
  # Logistic regression formula (using backticks for variables with spaces)
  formula <- as.formula(paste("`", v, "` ~ Region", sep = ""))
  
  # Fit the logistic regression model
  model <- glm(formula, data = dane_dataset, family = "binomial")
  
  # Summarized model result
  cat("\n\n--- Model for", v, "---\n")
  print(summary(model)$coefficients) # Displaying coefficients
  
  
  # Plotting residuals and fitted values
  cat("\n--- Residuals and Fitted Values ---\n")
  residuals <- residuals(model)
  fitted_values <- fitted(model)
  plot(fitted_values, residuals, main = paste("Residuals vs Fitted -", v),
       xlab = "Fitted values", ylab = "Residuals")
  abline(h = 0, col = "red")
  
  # Model summary for fit (Pseudo R-squared, AIC, etc.)
  cat("\n--- Model Summary ---\n")
  model_summary <- c("AIC" = AIC(model), 
                     "Pseudo R-squared (McFadden)" = 1 - model$deviance / model$null.deviance)
  print(model_summary)
}

# ## Analysis
#   
#   ### **Current Account Use (`checking_account_bin`):**
#   - The analysis shows significant regional differences in current account usage, with **Caquetá** showing a considerably higher likelihood of use, while **Cesar** shows a negative association.
# - These differences may stem from socioeconomic factors, such as limited access to banking infrastructure in some regions.
# - The pattern reflects inequalities in financial services access between urban areas like **Bogotá D.C.** and more rural or economically disadvantaged regions such as **Guainía** or **Cesar**.
# 
# ### **Savings Account Use (`savings_account_bin`):**
# - Most regions show negative coefficients, indicating that residents in many regions are less likely to use savings accounts compared to the reference region.
# - **La Guajira**, **Chocó**, and **Caquetá** show the strongest negative associations, suggesting either limited banking access or a preference for informal saving mechanisms.
# - This reflects a possible disconnection between impoverished areas and the formal financial system, a common pattern in rural and marginalized regions of Colombia.
# 
# ### **CDT (Term Deposit) Use (`CDT_bin`):**
# - Clear regional variations: **La Guajira**, **Magdalena**, and **Cesar** show negative associations, while **Bogotá D.C.** presents a positive one.
# - Regions with negative coefficients may be linked to lower income levels or a lack of financial literacy.
# - **Bogotá**, as the capital, shows higher financial inclusion, reflected in the greater likelihood of CDT use.
# 
# ### **Conclusion and Comparison Across Colombia:**
# - These analyses realistically reflect Colombia's socioeconomic and regional disparities, with **urban areas** like **Bogotá** and **Antioquia** showing greater use of formal financial services, while **rural and impoverished regions** such as **La Guajira** and **Caquetá** show lower usage.
# - To improve **financial inclusion**, policy should focus more on regions with lower usage of formal banking services. Improving access to banking infrastructure, financial education, and trust in the formal financial system are key measures.
# 
# ---

### Use of Free Investment Loans (`free_investment_loan_bin`):**

# - The model indicates strong regional disparities in the use of free investment loans.
# - **Bogotá D.C.**, **Boyacá**, **Casanare**, **Cauca**, **Nariño**, and **Vichada** have **positive and significant** associations, implying residents here are more likely to use this financial product.
# - In contrast, regions such as **Arauca**, **Atlántico**, **Bolívar**, **Cesar**, **Chocó**, **Córdoba**, **Guainía**, **La Guajira**, **Magdalena**, **San Andrés y Providencia**, and **Vaupés** exhibit **negative and significant** associations.
# - The strongest negative effects are seen in **Vaupés** and **Cesar**, reflecting possible financial exclusion or distrust in formal credit products.
# - The **Intercept** is highly negative, suggesting that, on average, the probability of using such loans is low.
# - The Likelihood Ratio Test confirms that **region is a significant predictor** (p < 0.001), reinforcing the idea that geography strongly shapes access to credit.
# 
# **Interpretation:**
# - Urban or semi-urban departments like **Bogotá** and **Boyacá** show greater access or willingness to use free investment loans—potentially due to higher financial literacy or better infrastructure.
# - Rural and peripheral departments (e.g., **Vaupés**, **Arauca**, **San Andrés**) may face obstacles such as limited credit availability, fewer banks, or cultural resistance to formal lending.
# 
# ---
# 
# ### Use of Credit Cards (`credit_card_bin`):**
# 
# - The analysis reveals sharp contrasts across regions.
# - **Bogotá D.C.**, **Boyacá**, **Caldas**, **Casanare**, **Cundinamarca**, and **Meta** are positively and significantly associated with credit card usage.
# - Regions with **strongly negative and significant** associations include **Amazonas**, **Arauca**, **Cesar**, **Chocó**, **Córdoba**, **Guainía**, **La Guajira**, and **Magdalena**.
# - The **Intercept** is also strongly negative, suggesting that credit card use is not widespread in the general population.
# - As with loans, the Likelihood Ratio Test shows that regional differences are **highly statistically significant**.
# 
# **Interpretation:**
# - Urbanized and more developed departments—especially **Bogotá D.C.**—show higher adoption of credit cards, likely due to more aggressive banking presence and higher income levels.
# - In contrast, rural and marginalized areas continue to be left out of the credit system, mirroring overall financial inclusion challenges in Colombia.


# Global Comment on Model Results
# 1. McFadden’s Pseudo R²:
#   The values range from 0.014 to 0.066, which is considered low in terms of explanatory power.
# 
# Values > 0.2 would be considered moderate.
# 
# Values > 0.4 start to be considered good.
# 
# Thus, the current models capture very little of the variability in the binary response variable.
# 
# 2. AIC (Akaike Information Criterion):
#   The AIC values vary widely, from around 21 000 up to almost 900 000 which is not good (AIC should be minimal)
# 
# ✅ Overall Conclusion:
#   The fitted models explain the binary response poorly.

## Using macro-regions

# Initialize a character vector to store macro-regions
Macro_Region <- character(length(dane_dataset$Region))

# Assign macro-region labels based on Region values
Macro_Region[dane_dataset$Region %in% c("Bogotá", "Antioquia", "Boyacá", "Cundinamarca",
                                        "Caldas", "Risaralda", "Quindío", "Santander",
                                        "Norte de Santander", "Tolima", "Huila")] <- "Andean"

Macro_Region[dane_dataset$Region %in% c("Atlántico", "Bolívar", "Magdalena", "La Guajira",
                                        "Sucre", "Córdoba", "Cesar")] <- "Caribbean"

Macro_Region[dane_dataset$Region %in% c("Chocó", "Valle del Cauca", "Cauca", "Nariño")] <- "Pacific"

Macro_Region[dane_dataset$Region %in% c("Amazonas", "Caquetá", "Guainía", "Guaviare", "Meta",
                                        "Putumayo", "Vaupés", "Vichada")] <- "Amazon-Orinoquía"

Macro_Region[dane_dataset$Region %in% c("Arauca", "Casanare")] <- "Eastern Plains"

Macro_Region[dane_dataset$Region %in% c("San Andrés", "Providencia")] <- "Insular"


# Add the new macro-region variable to the data frame
dane_dataset$Macro_Region <- Macro_Region


for (v in bin_cols) {
  
  # Logistic regression formula (using backticks for variables with spaces)
  formula <- as.formula(paste("`", v, "` ~ Macro_Region", sep = ""))
  
  # Fit the logistic regression model
  model <- glm(formula, data = dane_dataset, family = "binomial")
  
  # Summarized model result
  cat("\n\n--- Model for", v, "---\n")
  print(summary(model)$coefficients) # Displaying coefficients
  
  
  # Plotting residuals and fitted values
  cat("\n--- Residuals and Fitted Values ---\n")
  residuals <- residuals(model)
  fitted_values <- fitted(model)
  plot(fitted_values, residuals, main = paste("Residuals vs Fitted -", v),
       xlab = "Fitted values", ylab = "Residuals")
  abline(h = 0, col = "red")
  
  # Model summary for fit (Pseudo R-squared, AIC, etc.)
  cat("\n--- Model Summary ---\n")
  model_summary <- c("AIC" = AIC(model), 
                     "Pseudo R-squared (McFadden)" = 1 - model$deviance / model$null.deviance)
  print(model_summary)
}


# Compared to using Region, switching to Macro_Region did not improve model performance overall. Most Pseudo R-squared values are slightly lower (i.e., weaker explanatory power), and the AICs are comparable or slightly worse across models. In summary:
#   
#   Pseudo R² dropped across most models, especially for Uses savings account and Uses CDT.
# 
# Significance of predictors remains strong, but that’s not enough if explanatory power decreases.
# 
# No meaningful gain in interpretability to justify the drop.

#Using other preditors: Gender, Age, Unemployed, CLASE

class(dane_dataset$Gender)

levels(dane_dataset$Gender)

# Remove the empty string level from the 'Gender' factor
dane_dataset$Gender <- factor(dane_dataset$Gender, levels = levels(dane_dataset$Gender)[levels(dane_dataset$Gender) != ""])

# Drop any unused levels
dane_dataset$Gender <- droplevels(dane_dataset$Gender)

gender_counts = table(dane_dataset$Gender)

round(prop.table(gender_counts) * 100,2)

#53.33% of data is women and 46.67% is men

class(dane_dataset$Age)

age_counts = table(dane_dataset$Age)

#Pretty dispersed, from 0 to 108! 

round(prop.table(age_counts) * 100,2)

#Testing normality, since it is numeric

# Histogram
hist(dane_dataset$Age, main = "Histogram of Age", xlab = "Age", col = "lightblue", border = "black")

#left skewed, but could be Normal

# Q-Q Plot
qqnorm(dane_dataset$Age)
qqline(dane_dataset$Age, col = "red")

#Not really normal, it's more sigmoidal than linear the relationship between sample and theoretical normal quantiles

# Kolmogorov-Smirnov test against normal distribution
ks.test(dane_dataset$Age, "pnorm", mean(dane_dataset$Age), sd(dane_dataset$Age))

#p-value rather small, doesn't indicate normality

class(dane_dataset$Unemployed)

levels(dane_dataset$Unemployed)

# Replace the empty string level with "Not unemployed"
levels(dane_dataset$Unemployed)[levels(dane_dataset$Unemployed) == ""] <- "Not unemployed"

unemployment_counts = table(dane_dataset$Unemployed)

round(prop.table(unemployment_counts) * 100,2)

#Very unbalanced, unemplyment stands at 5.71%

class(dane_dataset$CLASE)

levels(dane_dataset$CLASE)

# Remove the empty string level from the 'CLASE' factor
dane_dataset$CLASE <- factor(dane_dataset$CLASE, levels = levels(dane_dataset$CLASE)[levels(dane_dataset$CLASE) != ""])

area_counts = table(dane_dataset$CLASE)

round(prop.table(area_counts) * 100,2)

for (v in bin_cols) {
  # Logistic regression formula (including multiple predictors)
  formula <- as.formula(paste("`", v, "` ~ Gender + Age + Unemployed + CLASE + Region", sep = ""))
  
  # Fit logistic regression model
  model <- glm(formula, data = dane_dataset, family = binomial)
  
  # Summarized model result
  cat("\n\n--- Model for", v, "---\n")
  print(summary(model)$coefficients) # Displaying coefficients
  
  
  # Plotting residuals and fitted values
  cat("\n--- Residuals and Fitted Values ---\n")
  residuals <- residuals(model)
  fitted_values <- fitted(model)
  plot(fitted_values, residuals, main = paste("Residuals vs Fitted -", v),
       xlab = "Fitted values", ylab = "Residuals")
  abline(h = 0, col = "red")
  
  # Model summary for fit (Pseudo R-squared, AIC, etc.)
  cat("\n--- Model Summary ---\n")
  model_summary <- c("AIC" = AIC(model), 
                     "Pseudo R-squared (McFadden)" = 1 - model$deviance / model$null.deviance)
  print(model_summary)
}



for (v in bin_cols) {
  # Logistic regression formula (including multiple predictors)
  formula <- as.formula(paste("`", v, "` ~ Gender + Age + Unemployed + CLASE + Region", sep = ""))
  
  # Fit logistic regression model
  model <- glm(formula, data = dane_dataset, family = binomial)
  
  # Summarized model result
  cat("\n\n--- Model for", v, "---\n")
  print(summary(model))
}        
