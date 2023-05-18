# README

# The functions in this script takes input from a tidied linear regression 
# summary in an augmented format using the augment() function from the broom 
# package. All plots are made using ggplot2. The plots are residual plot 
# Q-Q plot and Cook's Distance plot. The functions require that you have tidied 
# your model output into a tabular format using the augment() function before 
# you apply them. 

# LOAD PACKAGES

library(ggplot2)

# FUNCTIONS

# Residual plot

residual_plot <- function(df) {
  ggplot(data = df, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(title = "Residual plot")
}

# Q-Q plot

qq_plot <- function(df) {
  ggplot(data = df, aes(sample = .resid)) +
    geom_qq() +
    geom_qq_line() +
    theme_classic()
  labs(title = "Q-Q plot")
}

# Cook's Distance plot

cooks_d_plot <- function(df) {
  ggplot(data = df, aes(x = .fitted, y = .cooksd)) +
    geom_point() +
    geom_hline(yintercept = 0.3) +
    theme_classic()
  labs(title = "Cook's Distance plot")
}
