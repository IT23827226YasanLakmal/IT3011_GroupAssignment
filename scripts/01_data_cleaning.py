import pandas as pd
import numpy as np
import os

print("============================================================")
print("IT3011 Group Assignment - Script 01: Data Cleaning (Python)")
print("Learning Outcomes: LO1, LO4")
print("============================================================\n")

# ---- 1. Load Raw Data ----
print("Loading raw dataset...")
try:
    data = pd.read_csv("data/raw/data.csv")
except FileNotFoundError:
    print("Error: data/raw/data.csv not found!")
    exit(1)

# Subset required columns
columns_to_keep = ['Age', 'Gender', 'StudyHours', 'Attendance', 'AssignmentCompletion', 'ExamScore', 'FinalGrade']
data_clean = data[columns_to_keep].copy()

# ---- 2. Handle Missing Values ----
print("Handling missing values...")
initial_rows = len(data_clean)
data_clean = data_clean.dropna()
print(f"Removed {initial_rows - len(data_clean)} rows with missing values.")

# ---- 3. Create Custom Variables (Feature Engineering) ----
print("Creating derived variables for Self-Assessment...")

def categorize_completion(val):
    if val >= 80:
        return "High"
    elif val >= 50:
        return "Moderate"
    else:
        return "Low"

data_clean['SelfAssessment_Level'] = data_clean['AssignmentCompletion'].apply(categorize_completion)
data_clean['SelfAssessment_Level'] = pd.Categorical(data_clean['SelfAssessment_Level'], categories=["Low", "Moderate", "High"], ordered=True)

# ---- 4. Remove Outliers (IQR Method for ExamScore) ----
print("Detecting and treating outliers in ExamScore...")
Q1 = data_clean['ExamScore'].quantile(0.25)
Q3 = data_clean['ExamScore'].quantile(0.75)
IQR = Q3 - Q1
lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

data_outliers_removed = data_clean[(data_clean['ExamScore'] >= lower_bound) & (data_clean['ExamScore'] <= upper_bound)]
print(f"Removed {len(data_clean) - len(data_outliers_removed)} outliers from ExamScore.")

# ---- 5. Save Processed Data ----
print("Saving cleaned dataset...")
os.makedirs("data/processed", exist_ok=True)
data_outliers_removed.to_csv("data/processed/cleaned_data.csv", index=False)

print("\nData cleaning complete. Proceed to 02_descriptive.py")
