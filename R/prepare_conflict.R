# Load the necessary library
library(dplyr)

# Read the data
conflict <- read.csv("data/original/conflictdata.csv", header = TRUE)

# Process the data
confdata <- conflict |>
  # Group by ISO and year, then calculate the total deaths for each country-year
  group_by(ISO, year) |>
  summarise(totdeath = sum(best), .groups = 'drop') |>
  # Create a binary indicator of armed conflict
  mutate(armconf1 = ifelse(totdeath < 25, 0, 1)) |>
  # Increment the year by 1
  mutate(year = year + 1)

confdata$year <- as.numeric(confdata$year)


# View the results
table(confdata$armconf1)
head(confdata)
