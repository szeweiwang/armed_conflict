# Load the necessary library
library(tidyverse)

# Load the dataset
data <- read.csv("original/disaster.csv", encoding = "ISO-8859-1")

# Ensure that the 'year' column is numeric
# Using `dplyr::` to avoid name conflicts with the `year()` function in other libraries
data <- data %>%
  mutate(year = as.integer(data$Year))  # Refer explicitly to the 'year' column

# a. Subset the data to only include years 2000-2019 and the disaster types 'Earthquake' and 'Drought'
data_filtered <- data %>%
  filter(year >= 2000 & year <= 2019, Disaster.Type %in% c("Earthquake", "Drought"))

# b. Select only the variables: Year, ISO, and Disaster.Type
data_subset <- data_filtered %>%
  select(year, ISO, Disaster.Type)

# c. Create dummy variables for 'drought' and 'earthquake'
data_dummy <- data_subset %>%
  mutate(drought = ifelse(Disaster.Type == "Drought", 1, 0),
         earthquake = ifelse(Disaster.Type == "Earthquake", 1, 0))


disasters <- data_dummy %>% group_by(year,ISO)  %>%
  summarise(drought = sum(drought), 
            earthquake = sum(earthquake), 
            .groups = 'drop')



