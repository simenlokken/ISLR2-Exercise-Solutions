### Information

## Solutions for some exercises in chapter 3 - linear regression in ISLR 2. 

# Load packages

library(ISLR2)
library(tidyverse)
library(broom)
library(gridExtra)
library(GGally)
library(ggcorrplot)

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