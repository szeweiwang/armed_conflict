finaldata <- read.csv("data/analytical/finaldata.csv", header = TRUE)

# Basic summary statistics
summary(finaldata)

# Check for missing values in the dataset
colSums(is.na(finaldata))

# install.packages("naniar")
library(naniar)

# Visualize missing data
gg_miss_var(finaldata)

# Load ggplot2 for visualization
library(ggplot2)

# Histogram of GDP
ggplot(finaldata, aes(x = gdp1000)) +
  geom_histogram(binwidth = 0.5, fill = "blue", color = "black") +
  labs(title = "Distribution of GDP", x = "GDP (in 1000s)", y = "Count")

# Histogram of Population Density
ggplot(finaldata, aes(x = 'popdens')) +
  geom_histogram(binwidth = 2, fill = "green", color = "black") +
  labs(title = "Distribution of Population Density", x = "Population Density", y = "Count")


# Calculate the correlation matrix for numerical columns
numeric_cols <- finaldata[, sapply(finaldata, is.numeric)]
cor_matrix <- cor(numeric_cols, use = "complete.obs")

# Print correlation matrix
print(cor_matrix)


# Scatter plot between GDP and Population Density
ggplot(finaldata, aes(x = gdp1000, y = popdens)) +
  geom_point() +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "GDP vs Population Density", x = "GDP (in 1000s)", y = "Population Density")


# Bar plot for OECD status
ggplot(finaldata, aes(x = factor(OECD))) +
  geom_bar(fill = "lightblue", color = "black") +
  labs(title = "OECD Status", x = "OECD", y = "Count")

# Bar plot for Armed Conflict Indicator (armconf1)
ggplot(finaldata, aes(x = factor(armconf1))) +
  geom_bar(fill = "lightgreen", color = "black") +
  labs(title = "Armed Conflict Indicator", x = "Armed Conflict", y = "Count")

# Boxplot of GDP across OECD status
ggplot(finaldata, aes(x = factor(OECD), y = gdp1000)) +
  geom_boxplot(fill = "orange") +
  labs(title = "GDP by OECD Status", x = "OECD", y = "GDP (in 1000s)")

# Boxplot of Population Density across Armed Conflict Indicator
ggplot(finaldata, aes(x = factor(armconf1), y = popdens)) +
  geom_boxplot(fill = "purple") +
  labs(title = "Population Density by Armed Conflict", x = "Armed Conflict", y = "Population Density")

# Time series plot of GDP over time
ggplot(finaldata, aes(x = year, y = gdp1000, group = country_name, color = country_name)) +
  geom_line() +
  labs(title = "GDP over Time", x = "Year", y = "GDP (in 1000s)")

# Time series plot of Total Deaths over time
ggplot(finaldata, aes(x = year, y = totdeath, group = country_name, color = country_name)) +
  geom_line() +
  labs(title = "Total Deaths over Time", x = "Year", y = "Total Deaths")

\






