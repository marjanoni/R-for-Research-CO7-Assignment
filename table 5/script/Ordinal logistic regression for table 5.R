library(tidyverse)
library(MASS)
library(gtsummary)
library(readxl)
library(XLS)
library(gt)

library(readr)
cleandata <- read_csv("clean data/cleandata.csv")


# change column name for easier analysis
amr_clean1 <- cleandata |>
  select(1:11, 47)
colnames(amr_clean1) <- paste0("Q", 1:12)

#change dependent variable (string) into a factor mode
str(amr_clean1$Q12)
amr_clean1$Q12 <- factor(amr_clean1$Q12, ordered = TRUE)

#ordinary logistical regression model

OLR <- polr(Q12 ~ Q1+Q2+Q3+Q4+Q5+Q6+Q7+Q8+Q9+Q10+Q11 , amr_clean1, Hess = TRUE)

#table summary
tbl_regression(OLR, exponentiate = TRUE) |>
  add_global_p() |>
  bold_labels() |>
  bold_p(t = 0.05) |>
  as_gt() |>
  gtsave("table_5.docx")
  
  
 
  
