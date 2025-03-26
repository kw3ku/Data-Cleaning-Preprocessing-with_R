library(simstudy)
library(tidyverse)
#install.packages("simstudy")

# Define synthetic patient data
def <- defData(
  varname = "age",
  dist = "uniformInt",
  formula = "18;90"
)

def <- defData(def, 
  varname = "glucose",
  dist = "normal",
  formula = "80 + 0.5*age",
  variance = 10
  )

def <- defData(def, 
  varname = "blood_pressure",
  dist = "normal",
  formula = "120 + 0.3*age",
  variance = 15)

set.seed(998)
health_data <- genData(1000, def) %>% 
  mutate( 
    # Introduce 10% missingness in glucose
    glucose = ifelse(runif(n()) < 0.1, NA, glucose),  
    
    # Add censored values (e.g., ">500")
    glucose = ifelse(glucose > 500 & runif(n()) < 0.05, ">500", glucose),  
    
    # Add outliers (e.g., BP errors)
    blood_pressure = ifelse(runif(n()) < 0.03, blood_pressure * 3, blood_pressure),  
    
    # Add duplicate patients (Add 5 duplicate rows)
    .dup = sample(c(rep(TRUE, 5)), size = n(), replace = TRUE),  
    
    # Add noise to age
    age = age + rnorm(n(), mean = 0, sd = 2),  
    
    # Simulate glucose typos
    glucose = ifelse(runif(n()) < 0.02, glucose + sample(c(-10, 10), n(), replace = TRUE), glucose),  
    
    # Inconsistent date formats
    date_of_visit = ifelse( 
      runif(n()) < 0.5,
      as.Date('2025-03-25') - sample(1:1000, n(), replace = TRUE),
      format(as.Date('2025-03-25') - sample(1:1000, n(), replace = TRUE), "%d/%m/%Y")
    )
  ) %>% 
  bind_rows(slice(., which(.dup == TRUE))) %>%  
  select(-.dup)  # Remove the .dup column after creating duplicates


    # Save the synthetic data
  write.csv(health_data, "~/$PATH/health_data_again.csv", row.names = FALSE)
    
  
  # Count total duplicate rows (all columns must match)
  duplicate_counts <- health_data %>% 
    group_by(across(everything())) %>% 
    filter(n() > 1) %>% 
    tally(name = "duplicate_count")
  
  print(duplicate_counts)

  total_duplicates <- sum(duplicate_counts$duplicate_count) - nrow(duplicate_counts)
  cat("Total duplicate rows (excluding originals):", total_duplicates)
  
  duplicate_counts <- health_data %>% 
    group_by(id, date_of_visit) %>%  # Replace with your key columns
    filter(n() > 1) %>% 
    tally(name = "duplicate_count")
  
  # View duplicates
  print(duplicate_counts)
  cat("the number: ", duplicate_counts)


  # NA values

  # Summarize the number of NA values in each column
    na_summary <- health_data %>%
    summarize(across(everything(), ~ sum(is.na(.))))

  # Print the summary of NA values
    print(na_summary)


  # Constructing the Data Cleaning Pipeline
  remove_duplicates <- function(data) {
    data %>% 
      distinct()  # Remove duplicate rows
  }

  # Function to handle missing values (impute with mean for numeric columns)
    handle_missing_values <- function(data) {
    data %>%
        mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))
    }

    # Function to standardize date formats
    standardize_date_formats <- function(data) {
  data %>%
    mutate(date_of_visit = parse_date_time(date_of_visit, orders = c("Ymd", "dmy", "mdy", "Y-m-d", "d/m/Y", "m/d/Y"))) %>%
    filter(!is.na(date_of_visit))
}

    # Function to handle censored values (convert to numeric and set a threshold)
    handle_censored_values <- function(data) {
    data %>%
        mutate(glucose = ifelse(glucose == ">500", 500, as.numeric(glucose)))
    }

    # Function to handle censored values (convert to numeric and set a threshold)
    handle_censored_values <- function(data) {
    data %>%
        mutate(glucose = ifelse(glucose == ">500", 500, as.numeric(glucose)))
    }
    
    # Function to remove outliers (e.g., blood pressure > 300)
    remove_outliers <- function(data) {
      data %>%
        filter(blood_pressure <= 300)
    }


    # Main function of the data cleaning pipeline
    clean_data <- function(data) {
    data %>%
        remove_duplicates() %>%
        handle_missing_values() %>%
        standardize_date_formats() %>%
        handle_censored_values()%>%
        remove_outliers()
    }

    # Clean the data using the pipeline
    cleaned_health_data <- clean_data(health_data)

    # Print the cleaned data
    print(cleaned_health_data)

    # Save the cleaned data
    write.csv(cleaned_health_data, "~/r_works_base/data-cleaning/cleaned_health_data2.csv", row.names = FALSE)

# Summary statistics before cleaning
summary(health_data)

# Summary statistics after cleaning
summary(cleaned_health_data)

# Histogram of age before and after cleaning
ggplot(health_data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "blue", alpha = 0.7) +
  ggtitle("Age Distribution Before Cleaning")

ggplot(cleaned_health_data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "green", alpha = 0.7) +
  ggtitle("Age Distribution After Cleaning")


# Boxplot of glucose before and after cleaning
ggplot(health_data, aes(y = glucose)) +
  geom_boxplot(fill = "blue", alpha = 0.7) +
  ggtitle("Glucose Distribution Before Cleaning")

ggplot(cleaned_health_data, aes(y = glucose)) +
  geom_boxplot(fill = "green", alpha = 0.7) +
  ggtitle("Glucose Distribution After Cleaning")

# Missing data visualization before cleaning
missing_data_before <- health_data %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(cols = everything(), names_to = "variable", values_to = "missing_count")

ggplot(missing_data_before, aes(x = variable, y = missing_count)) +
  geom_bar(stat = "identity", fill = "red", alpha = 0.7) +
  ggtitle("Missing Data Before Cleaning")


# Missing data visualization after cleaning
missing_data_after <- cleaned_health_data %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(cols = everything(), names_to = "variable", values_to = "missing_count")

ggplot(missing_data_after, aes(x = variable, y = missing_count)) +
  geom_bar(stat = "identity", fill = "green", alpha = 0.7) +
  ggtitle("Missing Data After Cleaning")


