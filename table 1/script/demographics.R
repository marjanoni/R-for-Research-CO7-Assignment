library(tidyverse)
library(gtsummary)
library(gt)

cleandata <- cleandata |>
  select(1:11)

tbl_summary(cleandata) |>
modify_footnote(c(all_stat_cols()) ~ NA)  #remove footnotes

