### Information

## Solutions for some exercises in chapter 3 - linear regression in ISLR 2. 

# Load packages

library(ISLR2)
library(tidyverse)
library(broom)
library(gridExtra)
library(GGally)
library(ggcorrplot)
library(janitor)

theme_set(theme_minimal())

Auto |> view()

### Exercise 8

## A)

# First, some plotting

Auto |> 
  ggplot(aes(horsepower, mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# Fit model

auto_model <- lm(mpg ~ horsepower, data = Auto)

summary(auto_model)

# Predictions

predict(auto_model,
        tibble(horsepower = c(98)),
        interval = "confidence")

predict(auto_model,
        tibble(horsepower = c(98)),
        interval = "prediction")

# i-iii. It is clear from our plot there is a relationship between miles per 
# gallon and horsepower; as horsepower increases miles per gallon decreases. 
# Our regression result say the same; for each increase in horsepower, there is
# a - 0.158 decrease in miles per gallon. The relationship is negative.

# iv. The predicted miles per gallon usage based on our model with a horsepower
# of 98, is 24.5 (95 % CI: [23.97, 24,96]; PI: [14.81, 34.12]).

## B)

Auto |> 
  ggplot(aes(horsepower, mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# Source functions for model plots

source("model_plots_linear_regression.R")

augmented_auto_model <- augment(auto_model)

# Resdiual plot

res <- residual_plot(augmented_auto_model)

# Q-Q plot

qq <- qq_plot(augmented_auto_model)

# Cooks's Distance plot

cooks <- cooks_distance_plot(augmented_auto_model)

grid.arrange(res, qq, cooks, nrow = 1)

# The main thing I'm concerned about from these diagnostic plots is the 
# curvature shown in the residual plot. It may indicate that a polynomial 
# regression is more suitable than a linear regression for these data.

### Exercise 9

# A and B)

Auto |> 
  select(- origin, - name) |>
  ggpairs()

## C)

multiple_auto_model <- 
  lm(mpg ~ . - name, data = Auto)

summary(multiple_auto_model)

# i. Yes, but they impact the response differently. For example, while number 
# of cylinders have a negative relationship with miles per gallon, origin have
# a positive relationship.

# ii. Displacement, weight, year and origin have a statistically significant 
# relationship with miles per gallon.

# iii. The coefficient of the year variable suggests that newer cars are
# more fuel economical than older cars.

### Exercise 10

## A)

Carseats |> view()

# Clean the names to make the data easier to work with

carseats <- Carseats |> clean_names()

# Fit model

multiple_carseats_model <- 
  lm(sales ~ price + urban + us, data = carseats)

summary(multiple_carseats_model)

## B)

# 1) Price (in thousands). The model indicates that price affect sales of
# car seats negatively, i.e., when sales increase when the price goes down.

# 2) Urban (qualitative, yes/no, whether the store is in an urban or rural
# location. The model indicates car seats sales decrease if the store is 
# located in an urban location. That makes sense because the necessity of a car
# is normally higher in rural areas due to bigger distances and lack of public
# transport.

# 3) US (qualitative, yes/no, whether the store is in the US or not). 
# The model indicates that stores located in the US sell more car seats than 
# stores located outside of the US. 

## C)

# Not suited for a programming solution.

## D) 

# Price and US is statistically significant at the less than 0.001 level, so if 
# we can reject H0 and conclude that those variables do affect sales.

## E)

# Fit new model

new_multiple_carseats_model <- 
  lm(sales ~ price + us, data = carseats)

summary(new_multiple_carseats_model)

## F) 

# I will only consider the last model, model E). 

# The RSE is 2.47, meaning that the sales deviate by 2470 car seats on average 
# in our model. The R squared is 0.24, meaning that our model explains 24 per 
# cent of the variance, i.e., there is 76 per cent that is still unexplained.
# The F statistic is highly statistically significant so price and US is 
# associated with sales. Altogether, the model does explain some of the variance
# and we can be quite confident that price and US is associated with sales
# but there is for sure a lot we do not know about predicting sales of car seats.

## G)

confint(new_multiple_carseats_model)

# See console output for CI's. 

## H)


