# Load packages ----
library(tidyverse)
library(here)
library(skimr)
library(janitor)

# Load dataset ----
beaches <- read_csv(here('data', 'sydneybeaches.csv'))

# Explore the data ----
View(beaches) # Open table in editor
glimpse(beaches) # Get a glimpse of the data
str(beaches) # Show the structure of the 'beaches' object
summary(beaches) # Show a summmary of the data
skim(beaches) # Alternative to summary()
names(beaches) # Print column names

# Tidy column names ----

# Convert all column names to uppercase
select_all(beaches, toupper)

# Convert all column names to lowercase
select_all(beaches, tolower)

# Clean column names by converting to lowercase and inserting underscores
# Also saves this new object back to the beaches variable
cleanbeaches <- clean_names(beaches)

# Rename 'enterococci_cfu_100ml' column to 'beachbugs'
cleanbeaches <- rename(cleanbeaches, beachbugs = enterococci_cfu_100ml)

# Select a subset of columns ----

# Since we don't need all the columns in the dataset, we can choose to select
# just a subset of them, making it easier to work with our data.
select(cleanbeaches, council, site, beachbugs)

# We can also re-order the columns to prioritize the ones we're most interested
# in by using the everything() function
select(cleanbeaches, council, site, beachbugs, everything())

# Using pipes ----

# We can use pipes to simplify the process from above
cleanbeaches <- beaches %>%
    clean_names() %>%
    rename(beachbugs = enterococci_cfu_100ml) %>%
    select(council, site, beachbugs)

# Writing to a CSV file ----
write_csv(cleanbeaches, here('data', 'cleanbeaches.csv'))
