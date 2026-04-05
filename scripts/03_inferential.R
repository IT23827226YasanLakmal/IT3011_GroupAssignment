# ============================================================
# IT3011 Group Assignment - Script 03: Inferential Statistics
# Learning Outcomes: LO2 - Hypothesis Testing
# ============================================================

library(tidyverse)

# ---- 1. Load Cleaned Data ----
cat("Loading cleaned dataset...\n")
data <- read.csv("data/processed/cleaned_data.csv")
data$SelfAssessment_Level <- factor(data$SelfAssessment_Level, levels = c("Low", "Moderate", "High"))

# ---- 2. Define Hypotheses ----
# H0: There is no significant correlation between Assignment Completion (Self-assessment proxy) and Exam Score.
# H1: There is a significant positive correlation between Assignment Completion and Exam Score.

# H0_2: There is no significant difference in Exam Scores across different Self-Assessment Levels.
# H1_2: There is a significant difference in Exam Scores across different Self-Assessment Levels.

# ---- 3. Check Assumptions ----
cat("\n--- Checking Assumptions ---\n")
# Normality test (using a sample if n > 5000, shapiro.test requires n >= 3 && n <= 5000)
# We will use a random sample of 4000 to test normality if dataset is large
sample_data <- data
if(nrow(data) > 5000) { sample_data <- data %>% sample_n(4000) }

cat("Shapiro-Wilk Test for Normality (Exam Score):\n")
shapiro_res <- shapiro.test(sample_data$ExamScore)
print(shapiro_res)

cat("\nBartlett's Test for Homogeneity of Variance:\n")
bartlett_res <- bartlett.test(ExamScore ~ SelfAssessment_Level, data = data)
print(bartlett_res)

# ---- 4. Run Tests ----
cat("\n--- Running Inferential Tests ---\n")

# Correlation Test
cat("Pearson Correlation Test:\n")
cor_res <- cor.test(data$AssignmentCompletion, data$ExamScore, method = "pearson")
print(cor_res)

# ANOVA Test
cat("\nOne-Way ANOVA (Exam Score by Self-Assessment Level):\n")
anova_res <- aov(ExamScore ~ SelfAssessment_Level, data = data)
print(summary(anova_res))

# Post-hoc test if ANOVA is significant
if (summary(anova_res)[[1]][["Pr(>F)"]][1] < 0.05) {
  cat("\nANOVA is significant. Running Tukey HSD post-hoc test:\n")
  tukey_res <- TukeyHSD(anova_res)
  print(tukey_res)
}

# ---- 5. Save Output ----
dir.create("output/tables", recursive = TRUE, showWarnings = FALSE)
# Using sink to save printed output to a text file for documentation
sink("output/tables/inferential_results.txt")
cat("Correlation Test:\n")
print(cor_res)
cat("\nANOVA Summary:\n")
print(summary(anova_res))
if (exists("tukey_res")) {
  cat("\nTukey HSD:\n")
  print(tukey_res)
}
sink()

cat("============================================================\n")
cat("Inferential analysis complete. Results saved in output/tables/\n")
cat("Proceed to 04_predictive.R\n")
cat("============================================================\n")
