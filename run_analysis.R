# This script reads the train and test data set from 'UCI HAR Dataset' and stats
# by merging then into one data set 'UCI HAR Dataset/all'. After having all data
# in one data set it joins and select necessary columns to compile a clean and
# tidy data set. It writes the tidy data set for future extended analysis.
#
# The script also creates a secondary data set containing the average of all
# columns other than the fixed variables 'activity' and 'subject'. These
# averages computations are done only after grouping as requested by project.
#
mainDataFolder <- "./UCI HAR Dataset"
trainDataFolder <- "./UCI HAR Dataset/train"
testDataFolder <- "./UCI HAR Dataset/test"
allDataFolder <- "./UCI HAR Dataset/all"

# Create folders to save merged data
allDataSubFolder <- paste0(allDataFolder, "/", "Inertial Signals")
if (!dir.exists(allDataSubFolder)) {
    dir.create(allDataSubFolder, recursive = TRUE)
}

# Get paths to train and test data files
trainDataFiles <-
    sort(list.files(
        path = trainDataFolder,
        pattern = "_train.txt$",
        recursive = TRUE
    ))
testDataFiles <-
    sort(list.files(
        path = testDataFolder,
        pattern = "_test.txt$",
        recursive = TRUE
    ))

# Function to get the path for an alldata (train+test) file corresponding to a 
# selected train data file
getAllDataFileName <- function(fileIndex) {
    if (fileIndex > 0 && fileIndex <= length(trainDataFiles)) {
        return(sub("_train.txt", "_all.txt", trainDataFiles[fileIndex]))
    } else {
        return(NA)
    }
}

# Function to merge train and test data files
MergeTrainAndTestDataFiles <- function (fileToMergeIndex = 1) {
    if (fileToMergeIndex > 0 &&
        fileToMergeIndex <= length(trainDataFiles)) {
        # read train data
        trainFileToRead <-
            paste0(trainDataFolder, "/", trainDataFiles[fileToMergeIndex])
        trainDf <-
            read.table(trainFileToRead, sep = "", header = FALSE)
        #read test data
        testFileToRead <-
            paste0(testDataFolder, "/", testDataFiles[fileToMergeIndex])
        testDf <-
            read.table(testFileToRead, sep = "", header = FALSE)
        # merge train and test data
        allDF <- rbind(trainDf, testDf)
        allFileToWrite <- paste0(allDataFolder,
                                 "/",
                                 getAllDataFileName(fileToMergeIndex))
        write.table(allDF,
                    allFileToWrite,
                    col.names = FALSE,
                    row.names = FALSE)
        return(TRUE)
    }
    return(FALSE)
}

# Procedure to merge data files (train+test)
sapply(seq_along(trainDataFiles), MergeTrainAndTestDataFiles)

# Make data tidy: Read subjects and activities
harDf <- read.table(paste0(allDataFolder, "/", "subject_all.txt"),
                    sep = "",
                    header = FALSE)

tempDf <- read.table(paste0(allDataFolder, "/", "y_all.txt"),
                     sep = "",
                     header = FALSE)

harDf <- cbind(harDf, tempDf)
names(harDf) <- c("subject", "activityId")

# Make data tidy: Get activities' labels
activityLabels <-
    read.table(
        paste0(mainDataFolder, "/", "activity_labels.txt"),
        sep = "",
        header = FALSE
    )
names(activityLabels) <- c("activityId", "activity")

library(dplyr)
harDf <- harDf %>%
    left_join(activityLabels, by = "activityId") %>%
    select(activity, subject)

# Make data tidy: Get features' labels
featuresLabels <-
    read.table(paste0(mainDataFolder, "/", "features.txt"),
               sep = "",
               header = FALSE)
names(featuresLabels) <- c("featureCol", "featureName")

featuresLabels$isMean <-
    grepl("mean\\(", featuresLabels$featureName, ignore.case = FALSE)
featuresLabels$isStd <-
    grepl("-std\\(", featuresLabels$featureName, ignore.case = FALSE)

selectedFeaturesLabels <-
    featuresLabels[featuresLabels$isMean | featuresLabels$isStd, ]

# Make data tidy: Construct unique valid columns names from original 
# features' names
selectedFeaturesLabels$columnName <-
    make.names(selectedFeaturesLabels$featureName, unique = TRUE)
selectedFeaturesLabels$columnName <-
    make.names(gsub("\\.", "", selectedFeaturesLabels$columnName), unique = TRUE)
selectedFeaturesLabels$columnName <-
    make.names(tolower(selectedFeaturesLabels$columnName), unique = TRUE)

# Make data tidy: Get selected features data
tempDf <-
    read.table(paste0(allDataFolder, "/", "X_all.txt"),
               sep = "",
               header = FALSE)

selectedFeaturesData <- select(tempDf, selectedFeaturesLabels$featureCol)
rm(tempDf)
names(selectedFeaturesData) <- selectedFeaturesLabels$columnName

harDf <- cbind(harDf, selectedFeaturesData)

# Make data tidy: Final data sort
harDf <- arrange(harDf, activity, subject)

# Save tidy data set
tidyDataFolder <- "./TidyData"
if (!dir.exists(tidyDataFolder)) {
    dir.create(tidyDataFolder)
}
saveRDS(harDf,paste0(tidyDataFolder,"/HAR_Data.rds"))

# Generate variables' averages
analysisDf <- harDf %>%
    group_by(activity,subject) %>%
    summarise_all(mean)
head(analysisDf)

# Save variables' averages data set
analysisFolder <- "./AnalysisData"
if (!dir.exists(analysisFolder)) {
    dir.create(analysisFolder)
}
write.table(analysisDf,file = paste0(analysisFolder,"/Activity_Subject_Averages.rds"), row.name=FALSE)
