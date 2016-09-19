# Code to merge the sentiment file with generated topics 

getwd()
setwd("/home/asakhardhande19/rallis_files/")

# Reading files

file1 <- read.csv("final_paddy_opinions.csv", header = TRUE)
names(file1)
dim(file1)

file2 <- read.csv("final_paddy_topics.csv", header = TRUE)
names(file2)
dim(file2)

file3 <- read.csv("test_final_paddy_topics.csv", header = TRUE)
names(file3)
dim(file3)

# Combining file2 and file3 for entirity

file23 <- NULL
file23 <- rbind(file2, file3)
names(file23)
dim(file23)
write.csv(file23, file = "final_paddy_topics_V2.csv", row.names = FALSE)

# Merging files together

file4 <- read.csv("final_paddy_topics_V3.csv", header = TRUE)
names(file4)
dim(file4)

file3 <- merge(file1, file4, by = "Region")
names(file3)
#file3$Response.Text <- NULL
file3$Topic.Text <- NULL
file3$Comments <- NULL
names(file3)
dim(file3)

# Writing final output file

write.csv(file3, file = "final_rallis_file_V2.csv", row.names = FALSE)


