# Load packages ----
library(tidyverse)
library(here)
library(skimr)

# Load dataset ----
beaches <- read_csv(here('data', 'sydneybeaches.csv'))

# Explore the data ----
View(beaches) # Open table in editor
glimpse(beaches) # Get a glimpse of the data
str(beaches) # Show the structure of the 'beaches' object
summary(beaches) # Show a summmary of the data
skim(beaches) # Alternative to summary()
names(beaches) # Print column names
