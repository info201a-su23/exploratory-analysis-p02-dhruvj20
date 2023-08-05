library(dplyr)
library(ggplot2)
library(tidyverse)
library(patchwork)
library(janitor)

data <- read_csv("Highest Holywood Grossing Movies.csv")

distributor_sale <- data %>%
  group_by(Distributor) %>%
  mutate(num_movies = n())

ggplot(distributor_sale, mapping = aes(y=Distributor, x=distributor_sale$num_movies, fill = distributor_sale$Distributor)) +
  geom_col() +
  theme_grey() +
  theme(legend.position="none") +
  labs(title = "Distributors vs Number of Movies", x = "Number of Movies", y = "Distributors")