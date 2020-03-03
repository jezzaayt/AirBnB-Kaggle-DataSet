# using Kaggle NYC Airbnb Open Data

# ---- Libraries ----
library(tidyverse)
library(cowplot)
library(ggthemes)
library(stats)
library(lubridate)
df <- read_csv("AB_NYC_2019.csv")
head(df)

#NYC <- draw_image("NYC.png", scale = 0.5)
#plot(df$latitude,df$longitude, col="red", cex = .5)

theme_set(theme_minimal())

# ---- Data Frames ----
df_man <- df %>% filter(neighbourhood_group == "Manhattan")
df_brook <- df %>% filter(neighbourhood_group == "Brooklyn")
df_bronx <- df %>% filter(neighbourhood_group == "Bronx")
df_queens <- df %>% filter(neighbourhood_group == "Queens")
df_state_island <- df %>% filter(neighbourhood_group == "Staten Island")

#ggdraw(manh) +  draw_image("NYC.png", scale = 1) attempting to get image on background

# ----- Plots -----
nyc_plot<- ggplot(df, aes(x= latitude, y = longitude ,
              colour = neighbourhood_group)) + 
  geom_point() + ggtitle("Visualized lat long of NYC AirBnb")
nyc_plot

#nyc_group_plot <- ggplot(df, aes(x= latitude, y = longitude ,
#                                 colour = neighbourhood_group)) + 
#  geom_point() + facet_wrap(~neighbourhood_group, ncol=5) +
#  ggtitle("Visualized lat long of NYC AirBnb with facet wrap")
#nyc_group_plot

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


# ----- Compare the number of reviews vs price -----
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


# --------- Visualise the top 5 neighbourhoods of NYC ---------


# Counts the Neighbourhood_group column, sorts it from highest to lowest then slices max to min to select by position
nyc_count <- df %>% count(neighbourhood_group, sort = TRUE) %>% slice(which.max(n):which.min(n))
nyc_count

ggplot(nyc_count, aes(x= reorder(neighbourhood_group, -n), y= n, fill = neighbourhood_group)) + geom_col(position="dodge") +
  geom_text(aes(label = n), position= position_dodge(0.5), vjust=-1) + xlab("Neighbourhood Groups") + ylab("Count")+
  labs(fill = "NeighbourHood Groups", title="Count of how many Air B&B properties are within different districts in New York City")

# Counts by the neighbourhood but also showing the groups e.g. Brooklyn / Manhattan, then pipe into the head function for only top 5
nyc_top_5 <- df %>% count(neighbourhood_group,neighbourhood, sort = TRUE) %>% head()
nyc_top_5

ggplot(nyc_top_5, aes(x= reorder(neighbourhood, -n), y= n, fill = neighbourhood_group)) + geom_col(position="dodge") +
  geom_text(aes(label = n), position= position_dodge(0.5), vjust=-1) + xlab("Neighbourhood") + ylab("Count") + 
  labs(fill = "Neighbourhood Groups", title="Count of how many Air B&B properties are within different boroughs withinin New York City's Districts")


# Counts by the neighbourhood but also showing the groups e.g. Brooklyn / Manhattan, then pipe into the head function for only bottom 5
nyc_bottom_5 <- df %>% count(neighbourhood_group,neighbourhood, sort = TRUE) %>% tail()
nyc_bottom_5

