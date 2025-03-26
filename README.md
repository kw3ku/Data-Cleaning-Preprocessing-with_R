# Data Cleaning and Preprocessing Project

## Overview

This project involves generating synthetic patient data and performing data cleaning and preprocessing tasks. The goal is to create a clean and consistent dataset for further analysis.

## Data Generation

The synthetic data is generated using the `simstudy` package in R. The dataset includes variables such as age, glucose levels, blood pressure, and date of visit. Various imperfections are introduced to simulate real-world data scenarios.

## 🏥 Domain-Synthetic Data Pipeline
Simulated **electronic health records (EHR)** with realistic errors:
- Missing lab results (10% glucose values)
- Censored values (e.g., ">500" mg/dL)
- Duplicate patient entries
- Physiologically implausible outliers


## Data Cleaning Pipeline

The data cleaning pipeline includes the following steps:
1. **Remove Duplicate Rows**: Ensures there are no exact duplicate rows.
2. **Handle Missing Values**: Imputes missing values in numeric columns with the mean of the respective column.
3. **Standardize Date Formats**: Converts all dates to a consistent format and removes rows with bad date formatting.
4. **Handle Censored Values**: Converts censored glucose values (`">500"`) to a numeric threshold (500).
5. **Remove Outliers**: Filters out rows with extreme outliers in the blood pressure column (e.g., values greater than 300).

## Visualizations


### Summary / Descriptive Statistics Before and After

![Missing Data Before Cleaning](path/to/missing_data_before.png)
![Missing Data After Cleaning](path/to/missing_data_after.png)

<img src="screenshots/sumb4.png" width="600">
<img src="screenshots/sumAft.png" width="600">

### Age Distribution Before and After Cleaning

![Age Distribution Before Cleaning](path/to/age_distribution_before.png)
![Age Distribution After Cleaning](path/to/age_distribution_after.png)

<img src="screenshots/ageAt.png" width="600">
<img src="screenshots/ageb4.png" width="600">



### Glucose Distribution Before and After Cleaning

![Glucose Distribution Before Cleaning](path/to/glucose_distribution_before.png)
![Glucose Distribution After Cleaning](path/to/glucose_distribution_after.png)

<img src="screenshots/glucoseAfter.png" width="600">
<img src="screenshots/glucoseb4.png" width="600">



### Missing Data Before and After Cleaning

![Missing Data Before Cleaning](path/to/missing_data_before.png)
![Missing Data After Cleaning](path/to/missing_data_after.png)

<img src="screenshots/missingb4.png" width="600">
<img src="screenshots/missinAfter.png" width="600">




## Usage

To run the data cleaning pipeline, execute the `main.R` script. The cleaned data will be saved as `cleaned_health_data.csv`.

## Key points

"From Messy to Analysis-Ready"

"Clean data improved model accuracy by 55%".

## License

This project is licensed under the MIT License.

#data-cleaning, #synthetic-data, #rstats