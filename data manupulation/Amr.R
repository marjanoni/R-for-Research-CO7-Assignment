library(tidyverse)
library(MASS)
library(gtsummary)
library(readxl)
library(XLS)
library(gt)
library(readr)
#load data
AMR_RAW<- read_excel("raw_data/AMR_KAP_Data.xlsx")


#change col. header
amr <- AMR_RAW |>
  select(12:39)
colnames(amr) <- paste0("Q", 1:28)

#Distribution of knowledge
knowledge <- amr |>
  select(Q1:Q12) |>
  mutate(across(Q1:Q12, ~ case_when(
    .==  "Yes"~ 1 ,
    . == "No" ~ 0, 
    TRUE ~ 0
  )))|>
  rowwise()|>
  mutate(Knowledge_Score = sum(c_across(Q1:Q12), na.rm = TRUE)) |>
  
  rowwise()|>
  mutate(Knowledge_Percentage = mean(c_across(Q1:Q12)*100, na.rm = TRUE))




#Attitude towards misuse of antibiotics
attitude <- amr |>
  select(Q13:Q22) |> 
  mutate(across(Q13:Q22, ~ case_when(
    .==  "Agree"~ 1 ,
    . == "Disagree" ~ 0, 
    TRUE ~ 0
  ))) |>
  rowwise()|>
  mutate(Attitude_Score = sum(c_across(Q13:Q22), na.rm = TRUE))|>
 
   rowwise()|>
  mutate(Attitude_Percentage = mean(c_across(Q13:Q22)*100, na.rm = TRUE))


#Practices regarding the use of antibiotics
practice <- amr|>
  select(Q23:Q28) |>
  mutate(across(Q23:Q28, ~ case_when(
    .==  "Yes"~ 1 ,
    . == "No" ~ 0, 
     
  )))|>
  rowwise()|>
  mutate(Practice_Score = sum(c_across(Q23:Q28), na.rm = TRUE)) |>
  
  rowwise()|>
  mutate(Practice_Percentage = mean(c_across(Q23:Q28)*100, na.rm = TRUE))


#combine the data

demographics <- AMR_RAW |>
  select(1:11)

amr_domains <- cbind(knowledge,attitude,practice) 



amr_domains <- amr_domains |>
 
  mutate(Knowledge_Status = case_when(
    Knowledge_Percentage >= 0 & Knowledge_Percentage <=49  ~ "poor",
    Knowledge_Percentage >= 50 & Knowledge_Percentage <79 ~ "moderate",
    Knowledge_Percentage >=80 & Knowledge_Percentage <= 100 ~ "good"
  )) |>
  mutate(Attitude_Status = case_when(
    Attitude_Percentage >= 0 & Attitude_Percentage < 50 ~ "negtive",
    Attitude_Percentage >= 50 & Attitude_Percentage < 80 ~ "uncertain",
    Attitude_Percentage >= 80 ~ "positive"
  )) |>
  mutate(Practice_Status = case_when(
    Practice_Percentage >=0 & Practice_Percentage < 79 ~ "misuse",
    Practice_Percentage >= 80 ~ "good use"
  ))

factors_amr <- cbind(demographics,amr_domains) 

#export data

write_excel_csv(factors_amr, "clean data/cleandata.csv")
