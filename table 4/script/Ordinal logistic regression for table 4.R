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
  select(1:9, 46)


#change dependent variable (string) into a factor mode
str(amr_clean1$Knowledge_Status)
amr_clean1$Knowledge_Status <- factor(amr_clean1$Knowledge_Status, ordered = TRUE)

#ordinary logistical regression model

OLR <- polr(Knowledge_Status ~ . , amr_clean1, Hess = TRUE)

#table summary
tbl_regression(OLR, exponentiate = TRUE) |>
  add_global_p() |>
  bold_labels() |>
  bold_p(t = 0.05) |>
  as_gt() |>
  gtsave("table 4/table/table 4.docx")
  
  
 
  
