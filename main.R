# using Kaggle NYC Airbnb Open Data

library(tidyverse)
library(cowplot)
library(lubridate)
df <- read_csv("AB_NYC_2019.csv")
head(df)
NYC <- draw_image("New_York_City.png")

ggdraw() + NYC
draw_image(NYC, x = 1, y =1)
#plot(df$latitude,df$longitude, col="red", cex = .5)


df_man <- df %>% filter(neighbourhood_group == "Manhattan")
head(df_man)


manh<- ggplot(df, aes(x= latitude, y = longitude)) + geom_point() 

manh 
