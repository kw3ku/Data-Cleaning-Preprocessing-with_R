# R-Data-Proj
# Data Cleaning and Preprocessing Project

This project demonstrates data cleaning and preprocessing techniques using R. It involves generating synthetic data with intentional inaccuracies and applying various data cleaning methods to prepare the data for analysis.

## Project Overview

### Synthetic Data Generation
- **Objective:** Create a dataset that mimics real-world messy data.
- **Process:**
  - Generate a dataset with 200 columns and rows of random data.
  - Introduce issues such as missing values, duplicates, outliers, and inconsistent formatting.

### Data Cleaning Techniques
- **Handling Outliers:** Replace values exceeding the 99th percentile with the threshold value.
- **Handling Missing Values:** Impute missing numeric values with the mean of the respective column.
- **Removing Duplicates:** Remove duplicate rows after rounding numeric columns.
- **Correcting Inconsistent Formatting:** Convert character columns to numeric.
- **Correcting Incorrect Values:** Replace negative values with their absolute values.
- **Standardizing Column Names:** Convert column names to lowercase.
- **Normalizing Data:** Scale numeric columns.

### Visualization
- Create a correlation matrix plot to visualize the relationships between numeric columns.

## Repository Structure

The repository includes the following files and directories:

