library(tidyverse)
library(gtsummary)
library(gt)
library(readxl)
infodata <- read_excel("raw_data/AMR_KAP_Data.xlsx")
# selecting necessary columns for analysis

infodata <- infodata |>
  select(41:49)
#table summary for the demographics

tbl_summary(infodata) |>
modify_footnote(c(all_stat_cols()) ~ NA) |> #remove footnotes
  as_gt()|>
  gtsave("table 2/data/demographics.docx")

