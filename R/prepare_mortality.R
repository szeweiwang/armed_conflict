# Load necessary libraries
library(tidyverse)
library(countrycode)


process_mortality <- function(data) {

  
  # a. Select the required columns: Country.Name and years from 2000 to 2019
  data_subset <- data %>%
    select(Country.Name, X2000:X2019)
  
  # b. Reshape the data from wide to long format
  data_long <- data_subset %>%
    pivot_longer(cols = X2000:X2019, 
                 names_to = "year", 
                 names_prefix = "X", 
                 values_to = "MatMor") %>%
    mutate(Year = as.numeric(year)) # Ensure the Year is numeric
  
  return(data_long)
}

data_maternal <- read.csv("data/original/maternalmortality.csv", header = TRUE)
data_infant <- read.csv("data/original/infantmortality.csv", header = TRUE)
data_neonatal <- read.csv("data/original/neonatalmortality.csv", header = TRUE)
data_under5 <- read.csv("data/original/under5mortality.csv", header = TRUE)

data_maternal <- process_mortality(data_maternal)
data_infant <- process_mortality(data_infant)
data_neonatal <- process_mortality(data_neonatal)
data_under5 <- process_mortality(data_under5)


# Create a list of your dataframes
df_list <- list(data_maternal, data_infant, data_neonatal, data_under5)

# Use reduce() and full_join() to merge all dataframes
mortalities_merge <- df_list %>% 
  reduce(full_join, by = c("Country.Name", "year"))

mortalities_merge <- mortalities_merge %>%
  select(Country.Name, year, MatMor.x,MatMor.y,MatMor.x.x,MatMor.y.y) %>%
  rename(Country_name = Country.Name, 
         year = year,
         Maternal_mort_rate=MatMor.x,
         Infant_mort_rate=MatMor.y,
         Neo_mort_rate=MatMor.x.x,
         Under5_mort_rate=MatMor.y.y)


mortalities_merge$ISO <- countrycode(mortalities_merge$Country_name,
                            origin = "country.name",
                            destination = "iso3c")

#return resulting data
mortalities_merge <- mortalities_merge |>
  dplyr::select(-Country_name)

mortalities_merge$year <- as.numeric(mortalities_merge$year)

head(mortalities_merge)
