# R code to extract insecticide information from Rallis files
# Author: Akhil Sakhardande

getwd()
setwd("/home/asakhardhande19/rallis_files")
dir()

# Fetching sheet names from the excel

library(gdata)
Sheets <- sheetNames("FGD- Paddy sheets.xlsx")
class(Sheets)
Sheets <- as.list(Sheets)
Sheets[1]
class(as.character(Sheets[1]))
as.character(Sheets[1])

# Preparing the insecticide template

col1 <- "INSECTICIDES" #Insecticides
col2 <- c("Problematic Insects & Pests","Rounds of Insecticides in a year","Amount Spent on BPH per acre")
#col3 <- "Test"
out_df <- data.frame(col1,col2)
out_df
names(out_df)
names(out_df)[1:2] <- c("Category","Question")

# Writing the file

write.csv(out_df,"paddy_insecticide.csv", row.names = FALSE)

# Reading excel data and extracting the relevant fields

require(xlsx)

# Extracting the insecticide data from the excel files

for (each in 1:length(Sheets)) #length(Sheets) 2
{
excel <- read.xlsx("FGD- Paddy sheets.xlsx", sheetIndex = each, rowIndex = 31:41, colIndex = 2:3, header=FALSE)
class(excel)
head(excel,3)
names(excel)
dim(excel)


substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

substrLeft <- function(x, n){
  substr(x, 0, nchar(x)-n)
}

substrRight(test, 13)
substrRight(as.character(excel[5,2]), 30)

excel[1,2] #substrLeft(as.character(excel[2,2]),12)
new_col <- c(as.character(excel[1,2]),substr(as.character(excel[2,2]), 0, 60),substrRight(as.character(excel[5,2]), 30))
new_col

out_df$Region <- new_col
out_df

as.character(Sheets[each])
paste("Response",as.character(Sheets[each]), sep="_")
n <- ncol(out_df)
names(out_df)[n]
names(out_df)[n] <- paste("Response",as.character(Sheets[each]), sep="_")
names(out_df)
}

# Writing to a file
#write.csv(out_df,"paddy_insecticide.csv", row.names = FALSE)
write.table(out_df,file = "/home/asakhardhande19/rallis_files/paddy_insecticide_final.csv", sep = ",", row.names=FALSE, append=FALSE, col.names = TRUE)
