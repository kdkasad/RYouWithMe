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
cleanbeaches <- beaches |>
    clean_names() |>
    rename(beachbugs = enterococci_cfu_100ml) |>
    select(council, site, beachbugs, everything())

# Writing to a CSV file ----
write_csv(cleanbeaches, here('data', 'cleanbeaches.csv'))

# Question #1 ----
# Which beach has the highest levels of bacteria?

# Sort on 'beachbugs' column in descending order
worstbugs <- cleanbeaches |> arrange(-beachbugs)

# Sort the data for just Coogee Beach in descending order
worstcoogee <- cleanbeaches |>
    filter(site == 'Coogee Beach') |>
    arrange(-beachbugs)

# Pick your favourite beach and determine whether its most extreme beachbug
# values are higher or lower than the worst day at Coogee.
malabar_worst <- cleanbeaches |>
    filter(site == 'Malabar Beach') |>
    arrange(-beachbugs)
print(max(malabar_worst$beachbugs))

# Question #2 ----
# Does Coogee or Bondi have more extreme bacteria levels? Which beach has the
# worst bacteria levels on average?

# Filter on multiple values
coogee_bondi <- cleanbeaches |>
    filter(site %in% c('Coogee Beach', 'Bondi Beach')) |>
    arrange(-beachbugs)

# Create a grouped summary of the data
coogee_bondi |>
    group_by(site) |>
    summarize(maxbugs = max(beachbugs, na.rm = TRUE),
              medianbugs = median(beachbugs, na.rm = TRUE),
              meanbugs = mean(beachbugs, na.rm = TRUE))

# Question #3 ----
# Which council does the worst job at keeping their beaches clean?

# My own approach (without the tutorial)
cleanbeaches |>
    group_by(council) |>
    summarize(maxbugs = max(beachbugs, na.rm = TRUE),
              medianbugs = median(beachbugs, na.rm = TRUE),
              meanbugs = mean(beachbugs, na.rm = TRUE))

# Print distinct values for the 'council' column
cleanbeaches |> distinct(council)

# Group by both council and site
cleanbeaches |>
    group_by(council, site) |>
    summarize(medianbugs = median(beachbugs, na.rm = TRUE),
              meanbugs = mean(beachbugs, na.rm = TRUE))

# Compute new columns ----

# Separate the date string into separate values
testdate <- cleanbeaches |>
    separate(date, c('day', 'month', 'year'))

# Combine the 'council' and 'site' columns
council_site <- cleanbeaches |>
    unite(council_site, council:site, remove = FALSE)
