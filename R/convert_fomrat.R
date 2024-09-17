# Load necessary libraries
library(tidyverse)

# Read the data
data <- read.csv("original/maternalmortality.csv",header = TRUE)


# a. Select the required columns: Country.Name and years from 2000 to 2019
data_subset <- data %>%
  select(Country.Name, X2000:X2019)

# b. Reshape the data from wide to long format
data_long <- data_subset %>%
  pivot_longer(cols = X2000:X2019, 
               names_to = "Year", 
               names_prefix = "X", 
               values_to = "MatMor") %>%
  mutate(Year = as.numeric(Year)) # Ensure the Year is numeric

# View the first and last 20 rows of the resulting dataset
head(data_long, 20)
tail(data_long, 20)
