import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

try:
    import statsmodels.formula.api as smf
    HAS_STATSMODELS = True
except ImportError:
    HAS_STATSMODELS = False
    print("Error: statsmodels is required for predictive modeling. Please install using `pip install statsmodels`")
    exit(1)

print("============================================================")
print("IT3011 Group Assignment - Script 04: Predictive stats (Python)")
print("Learning Outcomes: LO3, LO5")
print("============================================================\n")

# ---- 1. Load Cleaned Data ----
print("Loading cleaned dataset...")
try:
    data = pd.read_csv("data/processed/cleaned_data.csv")
except FileNotFoundError:
    print("Cleaned data not found. Run 01_data_cleaning.py first.")
    exit(1)

# ---- 2. Build Linear Regression Model ----
print("\n--- Linear Regression Model ---")
model = smf.ols('ExamScore ~ AssignmentCompletion + StudyHours + Attendance', data=data).fit()
model_summary = model.summary()
print(model_summary)

# ---- 3. Model Diagnostics ----
print("\nGenerating model diagnostic plots...")
os.makedirs("output/figures", exist_ok=True)

# Scatter plot with regression line (using seaborn)
plt.figure(figsize=(6, 4))
sns.regplot(x='AssignmentCompletion', y='ExamScore', data=data,
            scatter_kws={'alpha':0.3, 'color':'gray'}, line_kws={'color':'red'})
plt.title("Linear Regression: Exam Score vs Assignment Completion")
plt.xlabel("Assignment Completion (%)")
plt.ylabel("Exam Score")
plt.tight_layout()
plt.savefig("output/figures/regression_prediction_py.png")
plt.close()

# Residuals vs Fitted
plt.figure(figsize=(6, 4))
sns.residplot(x=model.fittedvalues, y=model.resid, lowess=True, 
              scatter_kws={'alpha': 0.5}, line_kws={'color': 'red'})
plt.title("Residuals vs Fitted Values")
plt.xlabel("Fitted Values")
plt.ylabel("Residuals")
plt.tight_layout()
plt.savefig("output/figures/regression_residuals_py.png")
plt.close()


# ---- 4. Save Output ----
os.makedirs("output/tables", exist_ok=True)
with open("output/tables/predictive_results_py.txt", "w") as f:
    f.write("Multiple Linear Regression Model Summary:\n")
    f.write(model_summary.as_text())

print("\nPredictive analysis complete.")
print("All python analysis scripts have finished successfully!")
