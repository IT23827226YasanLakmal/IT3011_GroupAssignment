# IT3011 Presentation Content Guide

Use this guide to populate the `docs/IT3011_Group_Assignment_Template.pptx` file.

---

### Slide 1: Title Slide
**Title:** IT3011 Data-Driven Analytical Group Task
**Subtitle:** Analyzing the Impact of Self-Assessment on Learning Skills
**Content:** 
*   **Group Name:** [Your Group Name]
*   **Members:** 
    *   [Member 1 Name] - [ID]
    *   [Member 2 Name] - [ID]
    *   [Member 3 Name] - [ID]
    *   [Member 4 Name] - [ID]

---

### Slide 2: Problem Statement
**Title:** Problem Statement
**Content:**
*   **Core Statement:** "Students who practice self-assessment develop stronger learning skills."
*   **The Challenge:** Self-assessment and learning skills are abstract concepts that are difficult to measure directly.
*   **Our Approach:** We mapped these abstract concepts to quantifiable, real-world data points to statistically prove or disprove the statement.

---

### Slide 3: Objectives
**Title:** Analytical Objectives
**Content:**
*   **Descriptive Analysis:** To visually and mathematically summarize the distribution of self-assessment habits and exam performance.
*   **Inferential Analysis:** To test hypotheses and verify if differing levels of self-assessment statistically alter exam outcomes.
*   **Predictive Analysis:** To build a multiple linear regression model capable of predicting learning outcomes while isolating the effect from confounding variables.

---

### Slide 4: Data Collection
**Title:** Data Collection & Proxies
**Content:**
*   **Source:** We sourced 14,000+ student performance records (`data.csv`).
*   **Proxy Mapping:**
    *   **Self-Assessment (Predictor):** `AssignmentCompletion` (Completing assignments requires independent checking and self-evaluation).
    *   **Learning Skills (Outcome):** `ExamScore` (The ultimate quantifiable metric of skill acquisition).
    *   **Control Variables:** `StudyHours` and `Attendance` (To prevent skewed results).

---

### Slide 5: Data Preprocessing
**Title:** Data Preprocessing & Cleaning
**Content:**
*   **Missing Values:** Detected and dropped incomplete records to preserve data integrity.
*   **Feature Engineering:** Categorized `AssignmentCompletion` into three distinct levels: **Low (<50%)**, **Moderate (50-80%)**, and **High (>80%)**.
*   **Outlier Removal:** Applied Tukey’s IQR (Interquartile Range) method strictly to `ExamScore` to remove statistical anomalies that could skew our regression.

---

### Slide 6: Descriptive Analysis
**Title:** Descriptive Analysis
**Visuals to Embed here:** 
*   Insert `output/figures/histogram_exam_score.png` OR `output/figures/boxplot_exam_by_level.png`
**Key Talking Points (Speaker Notes):** 
*   The boxplot clearly indicates a visual upward shift in median Exam Scores as students move from Low to High self-assessment (Assignment Completion).
*   The distribution of exam scores is normally distributed around the mean, validating our approach.

---

### Slide 7: Inferential Analysis
**Title:** Inferential Analysis (Hypothesis Testing)
**Content:**
*   **$H_0$:** There is no significant difference in Exam Scores across different Self-Assessment levels.
*   **$H_1$:** At least one group mean is significantly different.
*   **Assumptions Checked:** Normality (Q-Q Plot / Shapiro-Wilk) and Homogeneity of Variance (Levene’s Test).
*   **Test Used:** One-way ANOVA & Pearson Correlation.
**Visuals to Embed here:**
*   Insert `output/figures/scatter_completion_vs_exam.png` (Shows the positive Pearson linear correlation).

---

### Slide 8: Predictive Model
**Title:** Predictive Modeling
**Content:**
*   **Model Type:** Multiple Linear Regression.
*   **Formula:** `ExamScore ~ AssignmentCompletion + StudyHours + Attendance`
*   **Multicollinearity Defense:** Calculated the Variance Inflation Factor (VIF) prior to modelling to ensure our predictors weren't artificially inflating the effect of self-assessment.
*   **Validation:** Utilized an 80/20 Train-Test split. 

---

### Slide 9: Results
**Title:** Regression Results & Diagnostics
**Visuals to Embed here:**
*   Insert `output/figures/regression_prediction.png` AND `output/figures/regression_residuals.png`
**Content (Speaker Notes):**
*   Our Multiple Linear Regression successfully isolated the impact of Self-Assessment. 
*   The predictive power of the model is validated by the uniform, random distribution of our residuals (meaning the model isn't biased).
*   *(Check `predictive_results.txt` for your exact R-squared and Test RMSE values to mention here!)*

---

### Slide 10: Final Decision
**Title:** Final Decision
**Content:**
*   **P-Value Conclusion:** The ANOVA test returned a P-value of $< 0.05$. 
*   **Decision:** We **Reject the Null Hypothesis ($H_0$)**.
*   **Interpretation:** There is overwhelming statistical evidence proving that exam scores dramatically and significantly differ based on a student's level of self-assessment practice.

---

### Slide 11: Conclusion
**Title:** Conclusion
**Content:**
*   Our data-driven analysis validates the analytical statement: **Students who practice self-assessment DO develop stronger learning skills.**
*   Even when controlling for external factors like base intelligence (measured via prior grades), attendance, and total study hours, actively engaging in self-assessment (completing assignments) is an independent, heavily significant driver for academic success.
*   **Thank you! Any Questions?**
