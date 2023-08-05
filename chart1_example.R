
genre_sales <- movie_data %>%
  separate_rows(Genre, sep = ", ") %>%  
  group_by(Genre) %>% 
  summarise(Total_Sales = sum(World.Sales..in...)) %>% 
  arrange(desc(Total_Sales)) %>%
  mutate(Genre = str_replace_all(Genre, "['\\[\\]]", ""))

bar_chart <- ggplot(genre_sales, aes(x = reorder(Genre, Total_Sales), y = Total_Sales)) +
  geom_col(fill = "steelblue") +
  labs(x = "Genre", y = "Total Worldwide Sales", title = "Most Popular Movie Genres by Sales") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(labels = scales::comma)

print(bar_chart)


