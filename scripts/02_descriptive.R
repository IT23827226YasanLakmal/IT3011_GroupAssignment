# ============================================================
# IT3011 Group Assignment - Script 02: Descriptive Statistics
# Learning Outcomes: LO1 - Summary stats and visualizations
# ============================================================

library(tidyverse)

# ---- 1. Load Cleaned Data ----
cat("Loading cleaned dataset...\n")
data <- read.csv("data/processed/cleaned_data.csv")

# Ensure factors are set
data$SelfAssessment_Level <- factor(data$SelfAssessment_Level, levels = c("Low", "Moderate", "High"))

# ---- 2. Summary Statistics ----
cat("\n--- Summary Statistics (Assignment Completion & Exam Score) ---\n")
summary_stats <- data %>%
  summarise(
    Mean_Completion = mean(AssignmentCompletion),
    SD_Completion = sd(AssignmentCompletion),
    Mean_Exam = mean(ExamScore),
    SD_Exam = sd(ExamScore),
    N = n()
  )
print(summary_stats)

cat("\n--- Mean Exam Score by Self-Assessment Level ---\n")
group_stats <- data %>%
  group_by(SelfAssessment_Level) %>%
  summarise(
    Mean_Exam = mean(ExamScore),
    SD_Exam = sd(ExamScore),
    N = n()
  )
print(group_stats)

# Save tables
dir.create("output/tables", recursive = TRUE, showWarnings = FALSE)
write.csv(group_stats, "output/tables/summary_by_level.csv", row.names = FALSE)

# ---- 3. Visualizations ----
cat("Generating visualizations...\n")
dir.create("output/figures", recursive = TRUE, showWarnings = FALSE)

# Histogram of Exam Scores
p1 <- ggplot(data, aes(x = ExamScore)) + 
  geom_histogram(fill = "steelblue", color = "black", bins = 30) +
  theme_minimal() +
  labs(title = "Distribution of Exam Scores", x = "Exam Score", y = "Frequency")
ggsave("output/figures/histogram_exam_score.png", plot = p1, width = 6, height = 4)

# Boxplot of Exam Scores by Self-Assessment Level
p2 <- ggplot(data, aes(x = SelfAssessment_Level, y = ExamScore, fill = SelfAssessment_Level)) +
  geom_boxplot() +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Exam Score by Self-Assessment Level", 
       x = "Self-Assessment Practice (Assignment Completion Proxy)", 
       y = "Exam Score")
ggsave("output/figures/boxplot_exam_by_level.png", plot = p2, width = 6, height = 4)

# Scatterplot: Assignment Completion vs Exam Score
p3 <- ggplot(data, aes(x = AssignmentCompletion, y = ExamScore)) +
  geom_point(alpha = 0.5, color = "darkblue") +
  geom_smooth(method = "lm", color = "red") +
  theme_minimal() +
  labs(title = "Assignment Completion vs. Exam Score",
       x = "Assignment Completion (%)", y = "Exam Score")
ggsave("output/figures/scatter_completion_vs_exam.png", plot = p3, width = 6, height = 4)

cat("============================================================\n")
cat("Descriptive analysis complete. Outputs saved in output/ folder.\n")
cat("Proceed to 03_inferential.R\n")
cat("============================================================\n")
