# install packages
install.packages("ggplot2")
library(ggplot2)

install.packages("reshape2")
library(reshape2)

install.packages("corrplot")
library(corrplot)

install.packages("ggcorrplot")
library(ggcorrplot)



# load data file, shorten session dataframe name to 'data'

philipines.census2020.feic2021.banking2021.data.province_huc <- read.csv("C:/Users/liulo/Dropbox/datakind/Projects/datakit 2025/philipines.census2020.feic2021.banking2021.data.province_huc.csv")

data <- philipines.census2020.feic2021.banking2021.data.province_huc

#remove categorical data and 2015 pop variables - region and province names- copy to 'data_corr':  

data_corr <- data[4:19]#

#shorten column names remove NAs - copy to 'data_corr_clean'

data_corr_clean <- na.omit(data_corr)
data_colnames <- c("pop","land_area","num_fam","fam_inc","fam_exp","fam_inc_pc","gini","pop_hh","hh_num","atm_onsite","atm_offsite","atm_total","deposit_chkg","deposit_sav","deposit_time","deposit_other")

colnames(data_corr_clean) <- data_colnames



#generate and print correlation matrix

correlation_matrix <- cor(data_corr, use = "complete.obs")
correlation_matrix

# generate 3 correlation visualizations

#1:  hard to discern
data_corr_round <-round(cor(data_corr_clean),2)
data_corr_mel <- melt (data_corr_round, na.rm=TRUE)
ggplot(data = data_corr_mel, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()


#2: improved version of #1
ggcorrplot(cor(data_corr_clean))

#3:  another visualization

corrplot(cor(data_corr_clean))
