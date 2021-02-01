#### Preamble ####
# Purpose: Make graphs of total ticks found and positive bacterial tests per year
# Author: Lorena Almaraz De La Garza
# Data: 27 January 2021
# Contact: l.almaraz@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - install packages if needed
# To do:

# Load libraries
library(here)
library(janitor)
library(knitr)
library(opendatatoronto)
library(tidyverse)

# Find and read in the data
raw_data <- search_packages("tick surveillance") %>% 
  list_package_resources() %>% 
  get_resource()

# Basic cleaning
clean_data <- clean_names(raw_data) %>% 
  select(park_location, total_bl_ts, number_positive, year) %>% 
  rename(park = park_location,
         total = total_bl_ts,
         positive = number_positive)

expanded_data<- add_column(clean_data,
                           negative = clean_data$total - clean_data$positive) # Create a column for ticks that tested negative

# Make graph of total ticks found per park per year
positive_df <- select(expanded_data, park, positive, year) %>% 
  add_column(result = "Positive") %>% 
  rename(count = positive)

negative_df <- select(expanded_data, park, negative, year) %>% 
  add_column(result = "Negative") %>% 
  rename(count = negative)

results_df <- rbind(positive_df, negative_df)

results_all <- results_df %>%  
  filter(count != 0) %>% 
  ggplot(aes(x = park, y = count, fill = as.factor(year))) +
  geom_col(position = position_stack(reverse = TRUE))+ 
  theme_minimal() + # Remove the default grey background
  theme(axis.text.x = element_text(angle = 75, hjust = 1)) + # Rotate park names for legibility
  labs(x = "Toronto Area Park", y = "Total Ticks Found", fill = "Year")

results_all


# Make graph of total positive bacterial tests per park per year
results_positive <- expanded_data %>%  
  filter(positive != 0) %>% 
  ggplot(aes(x = park, y = positive, fill = as.factor(year))) +
  geom_col(position = position_stack(reverse = TRUE))+ 
  theme_minimal() + # Remove the default grey background
  theme(axis.text.x = element_text(angle = 75, hjust = 1)) + # Rotate park names for legibility
  labs(x = "Toronto Area Park", y = "Total Infected Ticks Found", fill = "Year") 

results_positive

