# Load required library
library(boot)

# Load the dataset
data <- read.csv("data/analytical/finaldata.csv")

# Filter data for the year 2017
data_2017 <- subset(data, year == 2017)

# Define a function to calculate the median difference
median_diff <- function(data, indices, outcome) {
  # Bootstrap resampling
  d <- data[indices, ]
  # Calculate medians stratified by armed conflict
  median_conflict <- median(d[d$armconf1 == 1, outcome], na.rm = TRUE)
  median_no_conflict <- median(d[d$armconf1 == 0, outcome], na.rm = TRUE)
  # Return the difference
  return(median_conflict - median_no_conflict)
}

# Function to compute bootstrap CIs
compute_bootstrap_ci <- function(data, outcome) {
  # Bootstrap resampling
  boot_out <- boot(data, statistic = function(d, i) median_diff(d, i, outcome), R = 1000)
  # Compute 95% confidence intervals
  ci <- boot.ci(boot_out, type = "perc")
  return(ci)
}

# Outcomes to evaluate
outcomes <- c("infmor", "un5mor", "neomor")

# Compute and display CIs for each outcome
for (outcome in outcomes) {
  cat("\n95% Bootstrap Confidence Intervals for", outcome, "in 2017:\n")
  ci <- compute_bootstrap_ci(data_2017, outcome)
  print(ci)
}
