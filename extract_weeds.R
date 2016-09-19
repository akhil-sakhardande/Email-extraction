# R code to extract weeds information from Rallis files
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

# Preparing the weeds template

col1 <- "Weeds"
col2 <- c("Problematic weeds","Current practices of weed control","Chemicals preferred","Reasons for chemical preferance","Rounds of herbicide used in a season","Herbicide satisfaction level","Herbicide purchase considerations","Weedicides used in Nursery","Time of herbicide purchase","Amount willing to spend on herbicide")
out_df <- data.frame(col1,col2)
out_df
names(out_df)
names(out_df)[1:2] <- c("Category","Question")

# Writing the file

write.csv(out_df,"paddy_weeds.csv", row.names = FALSE)

# Reading excel data and extracting the relevant fields

require(xlsx)

# Extracting the seeds data from the excel files

for (each in 1:length(Sheets)) #length(Sheets) 2
{
  excel <- read.xlsx("FGD- Paddy sheets.xlsx", sheetIndex = each, rowIndex = 19:29, colIndex = 2:3, header=FALSE)
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
  
  excel[1,2]
  # substr(as.character(excel[2,2]), 0, 60)
  # substrRight(as.character(excel[5,2]), 30)
  new_col <- c(as.character(excel[1,2]),substr(as.character(excel[3,2]), 0, 35),substr(as.character(excel[4,2]), 0, 40),substr(as.character(excel[5,2]), 0, 80),substr(as.character(excel[6,2]), 0, 15),substr(as.character(excel[6,2]), 15, 40),substr(as.character(excel[7,2]), 0, 35),substr(as.character(excel[9,2]), 0,25),substr(as.character(excel[10,2]), 0, 30),substr(as.character(excel[11,2]), 0,30))
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
write.table(out_df,file = "/home/asakhardhande19/rallis_files/paddy_weeds_final.csv", sep = ",", row.names=FALSE, append=FALSE, col.names = TRUE)
