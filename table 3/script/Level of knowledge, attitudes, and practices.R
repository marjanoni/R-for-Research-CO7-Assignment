library(tidyverse)
library(MASS)
library(gtsummary)
library(readxl)
library(XLS)
library(gt)
library(readr)
#load the data
cleandata <- read_csv("clean data/cleandata.csv")

#selecting the necessary column to summarize the levels
levels <- cleandata|>
  select(46:48)

#table summarization 
tbl_summary(levels) |>
  modify_footnote(everything() ~ NA) # remove the footnote 

#save the table 

