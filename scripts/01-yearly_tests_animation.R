#### Preamble ####
# Purpose: Make a quick animation to visualize distribution of yearly bacterial tests
# Author: Lorena Almaraz De La Garza
# Data: 27 January 2021
# Contact: l.almaraz@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - install packages if needed
# To do:
# - fix x axis labels
# - find a way to transition year to year (try this: https://medium.com/ymedialabs-innovation/creating-animated-charts-in-r-using-gganimate-4a4b2193a642)
# - what happened to the legend?

# Load libraries
library(gapminder)#this is just a test dataset
library(gganimate)
library(gifski)
library(here)
library(janitor)
library(opendatatoronto)
library(tidyverse)

# Find and read in the data
raw_data <- search_packages("tick surveillance") %>% 
  list_package_resources() %>% 
  get_resource()

# Basic cleaning
clean_data <- clean_names(raw_data) %>% 
  select(park_location, total_bl_ts, number_positive) %>% 
  rename(park = park_location,
         total = total_bl_ts,
         positive = number_positive)

expanded_data<- add_column(clean_data,
                           negative = clean_data$total - clean_data$positive) # Create a column for ticks that tested negative

# Craft dataframe
positive_df <- select(expanded_data, park, positive) %>% 
  add_column(result = "Positive") %>% 
  rename(count = positive)

negative_df <- select(expanded_data, park, negative) %>% 
  add_column(result = "Negative") %>% 
  rename(count = negative)

both_df <- rbind(positive_df, negative_df)

# Make animation
# code from: http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Animated%20Bubble%20Plot
animated_ticks <- results_df %>% 
  # create regular column chart
  ggplot(aes(x = park, y = count, fill = result)) +
  geom_col(position = position_stack(reverse = TRUE))+
  theme_minimal() + # remove grey backgroung
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  scale_fill_manual(values = c("#abd7c7", "#e30052")) + 
  labs(x = "Toronto Area Park", y = "Ticks Found", fill = "Tick Bacterial Test")+ 
  scale_size(range = c(2, 12)) +
  # animation specific lines below
  transition_time(year) +
  ease_aes('linear') +
  scale_x_log10()

animated_ticks

