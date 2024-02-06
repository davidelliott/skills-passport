# Load CSV files that have ID info in them
ID_mapping <- read.csv("d:/git/skills-passport/data/ID_mapping/Skills_passport_update(1-106).csv")

# Extract the relevant info

colnames(ID_mapping)[6] <- "Badge.Number"
colnames(ID_mapping)[7] <- "Attendance.self.assess"
colnames(ID_mapping)[8] <- "note1"
colnames(ID_mapping)[9] <- "note2"
colnames(ID_mapping)[10] <- "note3"
colnames(ID_mapping)[11] <- "note4"

# get student ID numbers
ID_mapping$student_ID <- sub("@.*","",ID_mapping$Email)

# keep only the needed columns
ID_mapping <- ID_mapping[,c("Name","Email","student_ID","Badge.Number")]

# convert the badge number to character class, to match the class of the scans
ID_mapping$Badge.Number <- as.character(ID_mapping$Badge.Number)

# keep only unique entries (i.e. 1 per badge / ID combination)
ID_mapping <- unique(ID_mapping)

# Export the ID mapping
write.csv(ID_mapping,file = "d:/git/skills-passport/data/ID_mapping/ID_mapping.csv")

# this CSV can now be loaded by the main process-skills script.


