library(tidyverse)
library(stringr)

movies_data <- read.csv("/Users/dhruv/Downloads/INFO 201/exploratory-analysis-p02-dhruvj20/Movies.csv", 
header = TRUE, sep = ",", stringsAsFactors = FALSE)

### Hadn't read a CSV file via Downloads in a while, used code from A2 for some help with that
### Sources: 
### https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
### https://canvas.uw.edu/courses/1643812/files/folder/Lectures_PG (for reference)
### https://stackoverflow.com/questions/6304473/how-to-return-all-except-last-2-characters-of-a-string
### https://search.r-project.org/CRAN/refmans/stringr/html/str_trim.html

all_films_by_year <- movies_data %>% 
mutate(release_month = str_sub(Release.Date, 1, 
str_length(Release.Date)-8), release_year = str_sub(Release.Date, 
str_length(Release.Date)-3, str_length(Release.Date))) %>% 
select(Release.Date, release_year, release_month)

### Creating a new data frame by using string options to remove the release date and
### release month for all the films and then selecting the original release data
### variable, the year, and the month

sorting_movies_into_years <- all_films_by_year %>% group_by(release_year) %>%
count(months = str_trim(release_month)) %>% mutate(Jan)


### Created a new data frame by grouping all of the films by year and then counting how many
### movies are in each month of that year, had to trim spaces around each string to 
### make the counting universal aka "September " vs "September"

### Using a line plot for this, looked at my A4 code for this (all sources in there)
### Sources:
### http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
### https://www.geeksforgeeks.org/how-to-create-a-plot-using-ggplot2-with-multiple-lines-in-r/#
### https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
### https://environmentalcomputing.net/graphics/ggplot/ggplot-labels/
### https://stackoverflow.com/questions/40675778/center-plot-title-in-ggplot2
### https://stackoverflow.com/questions/14794599/how-to-change-line-width-in-ggplot
### https://r-graph-gallery.com/line-chart-ggplot2.html
### https://www.statology.org/ggplot-line-type/
### https://www.r-bloggers.com/2022/07/how-to-change-background-color-in-ggplot2-3/ (reference)
### https://community.rstudio.com/t/adding-manual-legend-to-ggplot2/41651/3
### https://uw.hosted.panopto.com/Panopto/Pages/Viewer.aspx?id=c470c37e-a4fd-40d7-8c78-b0530123d189

colors <- c("Asian Americans/Pacific Islanders" = "purple", "Black People" = "green",
            "Latinx People" = "red", "Native Americans" = "blue", "White People" = "orange")

line_plot_time <- ggplot(totals_median, aes(release_year)) +
geom_line(aes(y = aapi_med, color = "Asian Americans/Pacific Islanders"), 
size = 1, linetype = 2) + geom_line(aes(y = black_med, color = "Black People"), 
size = 1, linetype = 2) + geom_line(aes(y = latinx_med, color = "Latinx People"), 
size = 1, linetype = 2) + geom_line(aes(y = native_med, color = "Native Americans"), size = 1, linetype = 2) + geom_line(aes(y = white_med, color = "White People"), 
size = 1, linetype = 2) + labs(y = "Median Prison + Jail Incarceration Rate (Per 100K)", 
x = "Year (2010-2016)", title = "Incarceration Rates by Race vs Time", color = "Legend") +theme(plot.title = element_text(hjust = 0.5)) + scale_color_manual(values = colors)

