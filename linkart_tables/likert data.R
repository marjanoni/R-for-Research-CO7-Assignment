# Load required libraries
library(likert)
library(tidyverse)
library(readxl)
library(ggplot2)

# Load the data
data <- read_excel("raw_data/AMR_KAP_Data.xlsx")

# Select relevant columns (For Distribution of knowledge regarding antibiotic resistance)
#data1 <- data %>%
 # select(12:23)

# Select relevant columns (Attitude towards misuse of antibiotics)
data1 <- data %>%
  select(24:33)


# Select relevant columns (Practices regarding the use of antibiotics)
#data1 <- data %>%
 # select(34:39)



# Convert character columns to factors
d_f <- data.frame(data1)
 
# Apply make.names() and then remove dots
colnames(d_f) <- gsub("^X", "", make.names(colnames(d_f), unique = TRUE))
colnames(d_f) <- gsub("\\.", " ", make.names(colnames(d_f), unique = TRUE))
colnames(d_f) <- gsub("Agree", "(Agree)", colnames(d_f))
colnames(d_f) <- gsub("Disagree", "(Disagree)", colnames(d_f))

# Check the updated column names
print(colnames(d_f))

# Using mutate_if to convert all character columns to factors
df2 <- d_f %>%
  mutate_if(is.character, as.factor)
df2 <- df2[, sort(names(df2))]
# Check the structure of the updated dataframe
str(df2)
df3 <- likert(df2)

plot(df3) +
  # Customized Likert plot
  
#ggtitle("Customized Likert Scale Plot") +  # Add title
  labs(y = "Percentage", fill = "Response Type") + 
  theme_bw()+# Label axes
  theme(
    axis.text.y = element_text(size = 10),  # Change y-axis text size
    legend.position = "top",  # Move legend to the top
    panel.grid = element_blank(),  # Remove grid lines
    plot.title = element_text(hjust = 1),  # Center title
    axis.line = element_line(color = "black", size = 0.8),  # Adds axis lines
    panel.border = element_blank()  # Remove the plot border
  )

