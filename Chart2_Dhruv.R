library(tidyverse)
library(stringr)
library(plotly)

### Hadn't read a CSV file via Downloads in a while, used code from A2 for some help with that
### Sources (looked at these for my original idea, had to scrap because code wasn't working): 
### https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
### https://canvas.uw.edu/courses/1643812/files/folder/Lectures_PG (for reference)

movies_data <- read.csv("/Users/dhruv/Downloads/INFO 201/exploratory-analysis-p02-dhruvj20/Movies.csv", 
header = TRUE, sep = ",", stringsAsFactors = FALSE)

all_films_by_license <- movies_data %>% select(License, World.Sales..in...)

### Filtering the movies dataframe into license/rating and worldwide sales only

mean_money_film <- all_films_by_license %>% group_by(License) %>% 
summarise(avg_revenue = mean(World.Sales..in...)) %>% 
filter(License != "NA")

### Finding the average worldwide revenue for all the movies categorized by rating
### and then filtering out the NA row

dhruv_bar_plot <- ggplot(mean_money_film, aes(x = License, y = avg_revenue)) +
geom_bar(stat = "identity") + labs(y = "Average Worldwide Sales (Dollars)", 
x = "Movie License (Rating)", title = "Worldwide Sales vs Movie Licenses", 
color = "Legend") + theme(plot.title = element_text(hjust = 0.5)) 

ggplotly(dhruv_bar_plot)

### Creating a bar graph comparing license and the average revenue

R_revenue <- mean_money_film %>% filter(License == "R") %>% select(avg_revenue) %>% pull()

PG_revenue <- mean_money_film %>% filter(License == "PG") %>% select(avg_revenue) %>% pull()

PG13_revenue <- mean_money_film %>% filter(License == "PG-13") %>% select(avg_revenue) %>% pull()

G_revenue <- mean_money_film %>% filter(License == "G") %>% select(avg_revenue) %>% pull()

### Creating variables with all the average revenues referenced in R Markdown

funct_R_revenue <- function(){
  return (R_revenue)
}

funct_PG_revenue <- function(){
  return (PG_revenue)
}

funct_PG13_revenue <- function(){
  return (PG13_revenue)
}

funct_G_revenue <- function(){
  return (G_revenue)
}

### Creating functions to return all these variables (didn't work in R Markdown)

### Sources:
### http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
### https://environmentalcomputing.net/graphics/ggplot/ggplot-labels/
### https://stackoverflow.com/questions/40675778/center-plot-title-in-ggplot2
### https://www.r-bloggers.com/2022/07/how-to-change-background-color-in-ggplot2-3/ (reference)
### https://uw.hosted.panopto.com/Panopto/Pages/Viewer.aspx?id=c470c37e-a4fd-40d7-8c78-b0530123d189
### https://r-graph-gallery.com/218-basic-barplots-with-ggplot2.html


