# Load packages ----
library('tidyverse')
library('here')

# Read data from CSV ----
bakers_wide <- read.csv(here('data', 'bakers_wide.csv'))
beachbugs_wide <- read.csv(here('data', 'beachbugs_wide.csv'))
frames_wide <- read.csv(here('data', 'frames_wide.csv'))

# Wide to long ----
bakers_long <- pivot_longer(bakers_wide,
                            names_to = 'spice',
                            values_to = 'correct',
                            cinnamon_1:nutmeg_3)

beachbugs_long <- pivot_longer(beachbugs_wide,
                               names_to = 'site',
                               values_to = 'buglevels',
                               Bondi.Beach:Tamarama.Beach,
                               names_transform = function (x) gsub('\\.', ' ', x))

# Long to wide ----
beachbugs_wide <- pivot_wider(beachbugs_long,
                              names_from='site',
                              values_from='buglevels')

# Wide to long with multiple names ----
frames_long <- pivot_longer(frames_wide,
                            names_to = c('size', 'item'),
                            values_to = 'response',
                            large_item1:small_item7,
                            names_sep = '_item')
