# ============================================================
# IT3011 Group Assignment - Script 04: Predictive Analysis
# Learning Outcomes: LO3, LO5 - Predictive Modelling
# ============================================================

library(tidyverse)

# ---- 1. Load Cleaned Data ----
cat("Loading cleaned dataset...\n")
data <- read.csv("data/processed/cleaned_data.csv")

# ---- 2. Build Linear Regression Model ----
cat("\n--- Linear Regression Model ---\n")
# Predicting ExamScore based on AssignmentCompletion (Self-assessment proxy)
# along with control variables StudyHours and Attendance.
model <- lm(ExamScore ~ AssignmentCompletion + StudyHours + Attendance, data = data)

model_summary <- summary(model)
print(model_summary)

# ---- 3. Model Diagnostics ----
cat("\nGenerating model diagnostic plots...\n")
dir.create("output/figures", recursive = TRUE, showWarnings = FALSE)

png("output/figures/regression_diagnostics.png", width = 800, height = 600)
par(mfrow = c(2, 2))
plot(model)
dev.off()

# Save regression predictions plot
p_pred <- ggplot(data, aes(x = AssignmentCompletion, y = ExamScore)) +
  geom_point(alpha = 0.3, color = "gray") +
  stat_smooth(method = "lm", col = "red") +
  labs(title = "Linear Regression: Exam Score predicted by Assignment Completion",
       x = "Assignment Completion (Self-Assessment Practice)",
       y = "Exam Score") +
  theme_minimal()
ggsave("output/figures/regression_prediction.png", plot = p_pred, width = 6, height = 4)

# ---- 4. Save Output ----
dir.create("output/tables", recursive = TRUE, showWarnings = FALSE)
sink("output/tables/predictive_results.txt")
cat("Multiple Linear Regression Model Summary:\n")
print(model_summary)
sink()

cat("============================================================\n")
cat("Predictive analysis complete.\n")
cat("All analysis scripts have finished successfully!\n")
cat("============================================================\n")
