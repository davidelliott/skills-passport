library(plyr)

# Preparing files:
# The ID mapping "skills passport update" is from a microsoft form.
# Because students sometimes fill it in wrong, some lines might create errors
# Any problem lines should be deleted out. Then, when doing an update append the new records to the end of the working file.
# And append the number to the last record included. This way, the errors do not get re-introduced on each update.

# Load CSV files that have ID info in them
ID_mapping <- read.csv("d:/git/skills-passport/data/ID_mapping/Skills_passport_update198.csv")
ID_mapping2 <- read.csv("d:/git/skills-passport/data/ID_mapping/HS Skills passport update with ID card number.csv")
manual <- read.csv("D:/git/skills-passport/data/ID_mapping/manual.csv")

# Extract the relevant info

colnames(ID_mapping)[6] <- "Badge.Number"
colnames(ID_mapping)[7] <- "Attendance.self.assess"
colnames(ID_mapping)[8] <- "note1"
colnames(ID_mapping)[9] <- "note2"
colnames(ID_mapping)[10] <- "note3"
colnames(ID_mapping)[11] <- "note4"

colnames(ID_mapping2)[6] <- "Badge.Number"

# get student ID numbers
ID_mapping$student_ID <- sub("@.*","",ID_mapping$Email)
ID_mapping2$student_ID <- sub("@.*","",ID_mapping2$Email)

# keep only the needed columns
ID_mapping <- ID_mapping[,c("Name","Email","student_ID","Badge.Number")]
ID_mapping2 <- ID_mapping2[,c("Name","Email","student_ID","Badge.Number")]

# convert the badge number to character class, to match the class of the scans
ID_mapping$Badge.Number <- as.character(ID_mapping$Badge.Number)
ID_mapping2$Badge.Number <- as.character(ID_mapping2$Badge.Number)

# keep only unique entries (i.e. 1 per badge / ID combination)
ID_mapping <- unique(ID_mapping)
ID_mapping2 <- unique(ID_mapping2)

# Check in the class list in case there are some extra IDs

extra_IDs <- class_list[!class_list$ID%in%ID_mapping$student_ID,1:2]
colnames(extra_IDs) <- c("student_ID","Name")

ID_mapping <- rbind.fill(manual,ID_mapping,ID_mapping2,extra_IDs)

# keep only the valid records - badge number is present and starts with P
index <- substr(ID_mapping$Badge.Number,start = 1,stop = 1)=="P"
ID_mapping <- ID_mapping[index,]

# Export the ID mapping
write.csv(ID_mapping,file = "d:/git/skills-passport/data/ID_mapping/ID_mapping.csv")

# this CSV can now be loaded by the main process-skills script.


