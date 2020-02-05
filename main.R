# using Kaggle NYC Airbnb Open Data

library(tidyverse)
library(cowplot)
library(ggthemes)
library(lubridate)
df <- read_csv("AB_NYC_2019.csv")
head(df)
NYC <- draw_image("NYC.png", scale = 0.5)
#plot(df$latitude,df$longitude, col="red", cex = .5)

theme_set(theme_minimal())

df_man <- df %>% filter(neighbourhood_group == "Manhattan")
df_brook <- df %>% filter(neighbourhood_group == "Brooklyn")
df_bronx <- df %>% filter(neighbourhood_group == "Bronx")
df_queens <- df %>% filter(neighbourhood_group == "Queens")
df_state_island <- df %>% filter(neighbourhood_group == "Staten Island")
head(df_man)

#ggdraw(manh) +  draw_image("NYC.png", scale = 1) attempting to get image on background

nyc_plot<- ggplot(df, aes(x= latitude, y = longitude ,
              colour = neighbourhood_group)) + 
  geom_point()
nyc_plot  

manh_plot <- ggplot(df_man, aes(x=latitude, y = longitude, 
                                colour = neighbourhood)) +
  geom_point()

manh_plot


brook_plot <- ggplot(df_brook, aes(x=latitude, y=longitude,
                                   colour=neighbourhood))+
  geom_point()
brook_plot

bronx_plot <- ggplot(df_bronx, aes(x=latitude, y=longitude,
                                   colour = neighbourhood)) +
  geom_point()
bronx_plot 

queens_plot <- ggplot(df_queens, aes(x=latitude, y=longitude,
                                     colour=neighbourhood)) + 
  geom_point()
queens_plot

staten_plot <- ggplot(df_state_island,
                      aes(x=latitude,  
                          y=longitude,  colour=neighbourhood)) +
  geom_point()
staten_plot
