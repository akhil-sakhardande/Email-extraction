# R code to extract general paddy information from Rallis files
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

col1 <- "General"
col2 <- c("Reason for overall performance","Average Yield Per Acre","Current Acreage - Transplanted","Current Acreage - DSR","Shift Expected","Ratio of Hybrid/Non-Hybrid","Hybrid - High yield crop","Good Hybrid expectation","Preferred Hybrids for next year")
out_df <- data.frame(col1,col2)
out_df
names(out_df)
names(out_df)[1:2] <- c("Category","Question")

# Writing the file

write.csv(out_df,"paddy_general.csv", row.names = FALSE)

# Reading excel data and extracting the relevant fields

require(xlsx)

# Extracting the seeds data from the excel files

for (each in 1:length(Sheets)) #length(Sheets) 2
{
  excel <- read.xlsx("FGD- Paddy sheets.xlsx", sheetIndex = each, rowIndex = 3:11, colIndex = 2:3, header=FALSE)
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
  new_col <- c(substr(as.character(excel[3,2]), 0, 70),substr(as.character(excel[2,2]), 0, 30),substr(as.character(excel[4,2]), 0, 40),substrRight(as.character(excel[4,2]), 30),substr(as.character(excel[5,2]), 0, 20),substr(as.character(excel[6,2]), 0, 40),substr(as.character(excel[7,2]), 0, 35),substr(as.character(excel[8,2]), 0,70),substr(as.character(excel[9,2]), 0 ,40))
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
write.table(out_df,file = "/home/asakhardhande19/rallis_files/paddy_general_final.csv", sep = ",", row.names=FALSE, append=FALSE, col.names = TRUE)
