# ============================================================
# IT3011 Group Assignment - Script 01: Data Cleaning
# Learning Outcomes: LO1, LO4
# Analytical Statement: "students who practice self-assessment develop stronger learning skills"
# ============================================================

# Load libraries
library(tidyverse)

# ---- 1. Load Raw Data ----
cat("Loading raw dataset...\n")
data <- read.csv("data/raw/data.csv")

# Ensure required proxy variables are present
# We will use 'AssignmentCompletion' as a proxy for "Practice Self-assessment"
# We will use 'ExamScore' and 'FinalGrade' as proxies for "Stronger learning skills"
# Let's subset data for relevant columns to keep things focused
data_clean <- data %>%
  select(Age, Gender, StudyHours, Attendance, AssignmentCompletion, ExamScore, FinalGrade)

# ---- 2. Handle Missing Values ----
cat("Handling missing values...\n")
initial_rows <- nrow(data_clean)
data_clean <- data_clean %>% drop_na()
cat(sprintf("Removed %d rows with missing values.\n", initial_rows - nrow(data_clean)))

# ---- 3. Create Custom Variables (Feature Engineering) ----
cat("Creating derived variables for Self-Assessment...\n")
# Categorise Self-Assessment practice based on Assignment Completion rates
data_clean <- data_clean %>%
  mutate(
    SelfAssessment_Level = case_when(
      AssignmentCompletion >= 80 ~ "High",
      AssignmentCompletion >= 50 ~ "Moderate",
      TRUE ~ "Low"
    ),
    # Convert to factor with ordered levels
    SelfAssessment_Level = factor(SelfAssessment_Level, levels = c("Low", "Moderate", "High"))
  )

# ---- 4. Remove Outliers (IQR Method for ExamScore) ----
cat("Detecting and treating outliers in ExamScore...\n")
Q1 <- quantile(data_clean$ExamScore, 0.25)
Q3 <- quantile(data_clean$ExamScore, 0.75)
IQR <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR

data_outliers_removed <- data_clean %>%
  filter(ExamScore >= lower_bound & ExamScore <= upper_bound)
cat(sprintf("Removed %d outliers from ExamScore.\n", nrow(data_clean) - nrow(data_outliers_removed)))

# ---- 5. Save Processed Data ----
cat("Saving cleaned dataset...\n")
dir.create("data/processed", showWarnings = FALSE)
write.csv(data_outliers_removed, "data/processed/cleaned_data.csv", row.names = FALSE)

cat("============================================================\n")
cat("Data cleaning complete. Proceed to 02_descriptive.R\n")
cat("============================================================\n")
