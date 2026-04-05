import pandas as pd
import scipy.stats as stats
import os

try:
    import statsmodels.api as sm
    from statsmodels.stats.multicomp import pairwise_tukeyhsd
    HAS_STATSMODELS = True
except ImportError:
    HAS_STATSMODELS = False
    print("Warning: statsmodels not installed. Tukey HSD will be skipped.")

print("============================================================")
print("IT3011 Group Assignment - Script 03: Inferential stats (Python)")
print("Learning Outcomes: LO2")
print("============================================================\n")

# ---- 1. Load Cleaned Data ----
print("Loading cleaned dataset...")
try:
    data = pd.read_csv("data/processed/cleaned_data.csv")
    data['SelfAssessment_Level'] = pd.Categorical(data['SelfAssessment_Level'], categories=["Low", "Moderate", "High"], ordered=True)
except FileNotFoundError:
    print("Cleaned data not found. Run 01_data_cleaning.py first.")
    exit(1)

# ---- 3. Check Assumptions ----
print("\n--- Checking Assumptions ---")
# Normality test
sample_data = data.sample(4000) if len(data) > 5000 else data
shapiro_stat, shapiro_p = stats.shapiro(sample_data['ExamScore'])
print(f"Shapiro-Wilk Test (Exam Score): W={shapiro_stat:.4f}, p-value={shapiro_p:.4e}")

# Homogeneity of variance (Levene or Bartlett)
groups = [data[data['SelfAssessment_Level'] == level]['ExamScore'] for level in data['SelfAssessment_Level'].cat.categories]
bartlett_stat, bartlett_p = stats.bartlett(*groups)
print(f"Bartlett's Test for Homogeneity of Variance: stat={bartlett_stat:.4f}, p-value={bartlett_p:.4e}")

# ---- 4. Run Tests ----
print("\n--- Running Inferential Tests ---")

# Correlation Test
pearson_corr, pearson_p = stats.pearsonr(data['AssignmentCompletion'], data['ExamScore'])
print(f"Pearson Correlation Test: r={pearson_corr:.4f}, p-value={pearson_p:.4e}")

# ANOVA Test
f_stat, anova_p = stats.f_oneway(*groups)
print(f"\nOne-Way ANOVA (Exam Score by Self-Assessment Level): F={f_stat:.4f}, p={anova_p:.4e}")

# Tukey HSD
tukey_res_str = ""
if anova_p < 0.05 and HAS_STATSMODELS:
    print("\nANOVA is significant. Running Tukey HSD post-hoc test:")
    tukey_res = pairwise_tukeyhsd(endog=data['ExamScore'], groups=data['SelfAssessment_Level'], alpha=0.05)
    print(tukey_res)
    tukey_res_str = str(tukey_res)

# ---- 5. Save Output ----
os.makedirs("output/tables", exist_ok=True)
with open("output/tables/inferential_results_py.txt", "w") as f:
    f.write(f"Pearson Correlation Test: r={pearson_corr:.4f}, p={pearson_p:.4e}\n")
    f.write(f"ANOVA Test: F={f_stat:.4f}, p={anova_p:.4e}\n")
    if tukey_res_str:
        f.write("\nTukey HSD:\n")
        f.write(tukey_res_str + "\n")

print("\nInferential analysis complete. Results saved in output/tables/")
