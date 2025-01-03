library(tidyverse)
library(MASS)
library(gtsummary)
library(readxl)
library(XLS)
library(gt)
library(readxl)
amr_clean <- read_excel("C:/Users/oni31/Desktop/Chiral/clean_data/amr_clean.xlsx")



# change column name for easier analysis
amr_clean1 <- amr_clean |>
  select(1:11, 18:20) |>
  mutate(Practice_Score = case_when(
    Practice_Status == "misuse" ~ 0,
    Practice_Status == "good use" ~ 1,
  )) |>
  select(1:13, 1)
#colnames(amr_clean1) <- paste0("Q", 1:12)

#change dependent variable (string) into a factor mode
str(amr_clean1$Practice_Status)
amr_clean1$Q12 <- factor(amr_clean1$Q12, ordered = TRUE)

#ordinary logistical regression model

OLR <- glm(Practice_Score ~ . , amr_clean1,family = "binomial" ) 

anova(OLR)

#table summary
tbl_regression(OLR, exponentiate = TRUE) |>
  add_global_p() |>
  bold_labels() |>
  bold_p(t = 0.05) |>
  
  as_gt()|>
  gtsave("table6.docx")
  
  
  as_gt()|>
  gtsave("clean_data/level_of_knowledge.docx")
  
