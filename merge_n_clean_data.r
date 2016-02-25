# Johns Hopkins Data Science: data cleaning, week4 project
# luan1324, Feb 25, 2016
#
# assignment details:
# 1. merge 2 data set
# 2. extracts on the measurements on the mean and std for each measurement
# 3. use descriptive activity names
# 4. appropriately label the data set
# 5. create a second independent tidy data set with the mean of each variable 
#    for each activity

##########
# 1. read the data
##########
dir_path <- "C:\\Users\\LU\\R_workspace\\johns_hopkins\\R_HOMEWORK\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset"

# read training data files
sbj_train_filename <- paste(c(dir_path, '\\train\\subject_train.txt'), collapse = "")
x_train_filename <- paste(c(dir_path, '\\train\\X_train.txt'), collapse = "")
y_train_filename <- paste(c(dir_path, '\\train\\y_train.txt'), collapse = "")

x_train_df <- read.table(x_train_filename, header = FALSE, sep = "", colClasses = "numeric")
y_train <- read.table(y_train_filename, header = FALSE, stringsAsFactors = FALSE)
sbj_train <- read.table(sbj_train_filename, header = FALSE, stringsAsFactors = FALSE)

# read test data files
sbj_test_filename <- paste(c(dir_path, '\\test\\subject_test.txt'), collapse = "")
x_test_filename <- paste(c(dir_path, '\\test\\X_test.txt'), collapse = "")
y_test_filename <- paste(c(dir_path, '\\test\\y_test.txt'), collapse = "")

x_test_df <- read.table(x_test_filename, header = FALSE, sep = "", colClasses = "numeric")
y_test <- read.table(y_test_filename, header = FALSE, stringsAsFactors = FALSE)
sbj_test <- read.table(sbj_test_filename, header = FALSE, stringsAsFactors = FALSE)

# translate y_train into more meaningful activity names
y_test_a <- mutate(y_test, actv = ifelse(y_test$V1 == 1, "WALK", 
                                         ifelse(y_test$V1 == 2, "WALK_UP", 
                                                ifelse(y_test$V1 == 3, "WALK_DN", 
                                                       ifelse(y_test$V1 == 4, "SIT", 
                                                              ifelse(y_test$V1 == 5, "STAND", "LAY"))))))

y_train_a <- mutate(y_train, actv = ifelse(y_train$V1 == 1, "WALK", 
                                         ifelse(y_train$V1 == 2, "WALK_UP", 
                                                ifelse(y_train$V1 == 3, "WALK_DN", 
                                                       ifelse(y_train$V1 == 4, "SIT", 
                                                              ifelse(y_train$V1 == 5, "STAND", "LAY"))))))


# name the x test/train data columns meaningfully
# I modified the feature file to create a set of names
nm <- read.table("names.txt", header = FALSE, stringsAsFactors = FALSE)
names(nm) <- c("feature_cnt", "feature_name")
names(x_test_df) <- c(nm$feature_name)
names(x_train_df) <- c(nm$feature_name)

# combine test and trian data together
# first, combine them individually
test_df_tmp <- cbind(sbj_test, y_test_a$actv)
names(test_df_tmp) <- c("person_id", "activity")
test_df <- cbind(test_df_tmp, x_test_df)

train_df_tmp <- cbind(sbj_train, y_train_a$actv)
names(train_df_tmp) <- c("person_id", "activity")
train_df <- cbind(train_df_tmp, x_train_df)
# second, combine test and train
my_df <- rbind(train_df, test_df)

# remove not used data structure to save memory
#remove(x_test_df)
#remove(x_train_df)




#############
# 2. Extract only the measurements on the mean and std for each measurement
#############
# identify the columns to be extracted
v_mean <- grep("mean", names(my_df), ignore.case = TRUE, value = FALSE)
v_std <- grep("std", names(my_df), ignore.case = TRUE, value = FALSE)
v_filter <- c(c(1,2), v_mean, v_std) # add person_id and activity for aggregation later
my_df_mean_std <- my_df[,v_filter]

###########
# 3. Use descriptive activity names to name the activities in the data set
###########
# already done

##########
# 4. Appropriately lables the data set with descriptive variable names
############
# Done. I made minimum change to feature names.  Don't want to mess it up too much

###########
# 5. Using the my_df_mean_std data set, create a new data set of mean for each
#    measurement per activity and per subject (person_id)
###########
by_subject_actv_mean <- group_by(my_df_mean_std, person_id, activity) %>% 
  summarise_each(funs(mean))

# output a file
output_filename <- paste(c(dir_path, "\\by_subject_actv_mean.csv"), collapse = "")

write.csv(by_subject_actv_mean, file = output_filename)


