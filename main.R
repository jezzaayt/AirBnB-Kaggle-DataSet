# using Kaggle NYC Airbnb Open Data

library(tidyverse)
library(cowplot)
library(ggthemes)
library(lubridate)
df <- read_csv("AB_NYC_2019.csv")
head(df)
NYC <- draw_image("NYC.png", scale = 0.5)
#plot(df$latitude,df$longitude, col="red", cex = .5)

theme_set(theme_gdocs())

df_man <- df %>% filter(neighbourhood_group == "Manhattan")
head(df_man)


manh<- ggplot(df, aes(x= latitude, y = longitude ,
              colour = neighbourhood_group)) + 
  geom_point() 

manh

ggdraw(manh) +  draw_image("NYC.png", scale = 1)
 
