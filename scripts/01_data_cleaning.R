# ============================================================
# IT3011 Group Assignment - Script 01: Data Cleaning
# Learning Outcomes: LO1, LO4
# ============================================================

# Load libraries
library(tidyverse)

# Load raw data
# data <- read.csv("data/raw/survey_results.csv")

# ---- 1. Inspect Data ----
# str(data)
# summary(data)
# head(data)

# ---- 2. Handle Missing Values ----
# data_clean <- data %>% drop_na()   # or use imputation

# ---- 3. Remove Outliers ----
# Use IQR method or z-score

# ---- 4. Save Processed Data ----
# write.csv(data_clean, "data/processed/cleaned_data.csv", row.names = FALSE)

cat("Data cleaning complete.\n")
