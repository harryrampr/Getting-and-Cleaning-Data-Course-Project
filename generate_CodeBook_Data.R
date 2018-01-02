# The script will generate an index that relates original features' columns
# to new TidyData columns positions and new names. This index was saved on 
# file TidyFeaturesColumnsIndex.csv for future reference.
#
codeBookData <- selectedFeaturesLabels %>%
    rename(
        originalColumn = featureCol,
        tidyColumnName = columnName,
        originalColumnName = featureName) %>%
    mutate(tidyColumn = c(3:(nrow(
        selectedFeaturesLabels) + 2))) %>%
    select(tidyColumn,
           tidyColumnName,
           originalColumn,
           originalColumnName)

codeBookData

write.csv(codeBookData, "TidyFeaturesColumnsIndex.csv", row.names = FALSE)
