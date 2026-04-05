import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

print("============================================================")
print("IT3011 Group Assignment - Script 02: Descriptive stats (Python)")
print("Learning Outcomes: LO1")
print("============================================================\n")

# ---- 1. Load Cleaned Data ----
print("Loading cleaned dataset...")
try:
    data = pd.read_csv("data/processed/cleaned_data.csv")
    data['SelfAssessment_Level'] = pd.Categorical(data['SelfAssessment_Level'], categories=["Low", "Moderate", "High"], ordered=True)
except FileNotFoundError:
    print("Cleaned data not found. Run 01_data_cleaning.py first.")
    exit(1)

# ---- 2. Summary Statistics ----
print("\n--- Summary Statistics ---")
summary_stats = data[['AssignmentCompletion', 'ExamScore']].agg(['mean', 'std', 'count']).T
print(summary_stats)

print("\n--- Mean Exam Score by Self-Assessment Level ---")
group_stats = data.groupby('SelfAssessment_Level', observed=False)['ExamScore'].agg(
    Mean_Exam='mean', 
    SD_Exam='std', 
    N='count'
).reset_index()
print(group_stats)

os.makedirs("output/tables", exist_ok=True)
group_stats.to_csv("output/tables/summary_by_level_py.csv", index=False)

# ---- 3. Visualizations ----
print("\nGenerating visualizations...")
os.makedirs("output/figures", exist_ok=True)

# Set style
sns.set_theme(style="whitegrid")

# Histogram
plt.figure(figsize=(6, 4))
sns.histplot(data['ExamScore'], bins=30, color='steelblue', kde=False)
plt.title("Distribution of Exam Scores")
plt.xlabel("Exam Score")
plt.ylabel("Frequency")
plt.tight_layout()
plt.savefig("output/figures/histogram_exam_score_py.png")
plt.close()

# Boxplot
plt.figure(figsize=(6, 4))
sns.boxplot(x='SelfAssessment_Level', y='ExamScore', data=data, palette="Set2")
plt.title("Exam Score by Self-Assessment Level")
plt.xlabel("Self-Assessment Practice")
plt.ylabel("Exam Score")
plt.tight_layout()
plt.savefig("output/figures/boxplot_exam_by_level_py.png")
plt.close()

# Scatterplot
plt.figure(figsize=(6, 4))
sns.regplot(x='AssignmentCompletion', y='ExamScore', data=data, 
            scatter_kws={'alpha':0.5, 'color':'darkblue'}, line_kws={'color':'red'})
plt.title("Assignment Completion vs. Exam Score")
plt.xlabel("Assignment Completion (%)")
plt.ylabel("Exam Score")
plt.tight_layout()
plt.savefig("output/figures/scatter_completion_vs_exam_py.png")
plt.close()

print("\nDescriptive analysis complete. Outputs saved in output/ folder.")
