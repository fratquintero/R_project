# Load necessary libraries
library(dplyr)

# Step 1: Read feature and activity labels
# Read the features.txt file to get feature names
features <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", col.names = c("index", "feature_names"))

# Read the activity_labels.txt file to get activity labels
activity_labels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_name"))

# Step 2: Load training data
# Read X_train.txt to get the training set data
x_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", col.names = features$feature_names)

# Read y_train.txt to get the training set activity labels
y_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")

# Read subject_train.txt to get the training set subject IDs
subject_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", col.names = "subject_id")

# Step 3: Load test data
# Read X_test.txt to get the test set data
x_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", col.names = features$feature_names)

# Read y_test.txt to get the test set activity labels
y_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")

# Read subject_test.txt to get the test set subject IDs
subject_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", col.names = "subject_id")

# Step 4: Combine the training and test data sets
# Combine X_train and X_test using rbind()
x_data <- rbind(x_train, x_test)

# Combine y_train and y_test using rbind()
y_data <- rbind(y_train, y_test)

# Combine subject_train and subject_test using rbind()
subject_data <- rbind(subject_train, subject_test)

# Combine all data into one dataset using cbind()
complete_data <- cbind(subject_data, y_data, x_data)

# Print the structure of the complete data to verify
str(complete_data)

# Extract the measurements on the mean and standard deviation for each measurement

# Use grep to identify the columns with mean and std in their names
mean_std_columns <- grep("\\.mean\\.|\\.std\\.", colnames(complete_data))

# Create a vector of column names to extract, including subject_id and activity_id
columns_to_extract <- c("subject_id", "activity_id", colnames(complete_data)[mean_std_columns])

# Extract the relevant columns from the complete data
extracted_data <- complete_data[, columns_to_extract]

# Print the structure of the extracted data to verify
str(extracted_data)

# Load activity labels
activity_labels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_name"))

# Merge extracted_data with activity_labels to get descriptive activity names
extracted_data <- merge(extracted_data, activity_labels, by = "activity_id")

# write.csv(extracted_data, "extracted_data.csv", row.names = FALSE)

# Appropriately label the data set with descriptive variable names

# Clean up column names for better readability
names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data) <- gsub("BodyBody", "Body", names(extracted_data))

# Print the cleaned-up column names to verify
# print(names(extracted_data))

# Write the cleaned-up extracted_data to a CSV file for inspection
# write.csv(extracted_data, "cleaned_extracted_data.csv", row.names = FALSE)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- extracted_data %>%
  group_by(subject_id, activity_name) %>%
  summarise(across(everything(), mean))

# Print the structure of the tidy data set to verify
str(tidy_data)

# Write the tidy data set to a txt file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

