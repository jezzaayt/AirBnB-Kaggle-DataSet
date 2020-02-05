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
  geom_point() + ggtitle("Visualized lat long of NYC AirBnb")
nyc_plot

nyc_group_plot <- ggplot(df, aes(x= latitude, y = longitude ,
                                 colour = neighbourhood_group)) + 
  geom_point() + facet_wrap(~neighbourhood_group, ncol=5) +
  ggtitle("Visualized lat long of NYC AirBnb with facet wrap")
nyc_group_plot

manh_plot <- ggplot(df_man, aes(x=latitude, y = longitude, 
                                colour = neighbourhood)) +
  geom_point() + ggtitle("Visualized lat long of Manhatten")

manh_plot


brook_plot <- ggplot(df_brook, aes(x=latitude, y=longitude,
                                   colour=neighbourhood))+
  geom_point() + ggtitle("Visualized lat long of Brooklyn")
brook_plot

bronx_plot <- ggplot(df_bronx, aes(x=latitude, y=longitude,
                                   colour = neighbourhood)) +
  geom_point() + ggtitle("Visualized lat long of Bronx")
bronx_plot 

queens_plot <- ggplot(df_queens, aes(x=latitude, y=longitude,
                                     colour=neighbourhood)) + 
  geom_point() + ggtitle("Visualized lat long of Queens")
queens_plot

staten_plot <- ggplot(df_state_island,
                      aes(x=latitude,  
                          y=longitude,  colour=neighbourhood)) +
  geom_point() + ggtitle("Visualized lat long of Staten Island")
staten_plot


# Compare the number of reviews vs price
# In the hope to see if more expensive AirBnB would have more reviews. 
nyc_price_200 <- df %>% filter(price < 200 ) %>% filter(number_of_reviews >0)
#limiting to 200 dollars a night though this is not counting min nights to stay
# making sure there is at least one review
nyc_price_plot <- ggplot(nyc_price_200, aes(x=number_of_reviews, y= price))+
  geom_point() + coord_cartesian(xlim = c(0,700),
                                                ylim= c(0,200)) +
   ggtitle("Number of reviews compared to pricing")
nyc_price_plot

# From this plot we can see that places around 50 dollars a night get more reviews
# But there are at least 200 - 400 reviews for anything over 50 dollars

nyc_price_plot_co <- ggplot(nyc_price_200, aes(x=number_of_reviews, y= price, colour=neighbourhood_group))+
  geom_point() + coord_cartesian(xlim = c(0,700),
                                 ylim= c(0,200)) + ggtitle("Number of reviews compared to pricing by neighbourhood groups")
nyc_price_plot_co

# Now we can see what grouping they belong to
# We can see more reviews are from Queens and around 3 from Manhattan have 600 ish reviews



# Moving on let's see the average price of the properties 
nyc_avg_price <- ggplot(df, aes(x=price)) + coord_cartesian(xlim = c(0,600))+
  geom_histogram(binwidth = 2, aes(y=..density..)) + geom_vline(aes(xintercept = mean(price, na.rm = T)), color="red", linetype="dashed")+
  geom_density(alpha = .2, fill = "#FF6666") + ggtitle("Disturbtion density plot price of AirBnb in NYC") +
  annotate("text", x=300,y=0.015, 
           label = paste("Mean price = $", 
                         (paste0(round(mean(df$price))))), color = "red", size=6)
nyc_avg_price

#Density plot showing visual representation of the distirubtion of price within the AirBnb dataset