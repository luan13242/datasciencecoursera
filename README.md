# DATA CLEANING - WK4 PROJECT

## Data Background
Data used by this project is generated from smartphones that people wear doing daily activities, such as walking, standing, etc.

The raw data captured by smartphones consists of: **accelerations** along x, y, z axials, and **angular velocity** along x, y, z axials.
For details, please reference to: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Objective of the project is to do some data manipulations, i.e. clean up, and compute an aggregate on groups of the cleaned data.

**Steps I took to achieve the goal**

##1. Read in data

The raw data is divided into a training set (to create a machine learning model), and a testing set (to evaluate the machine learning model).

Data of the training/testing set are:
* X_train.txt and X_test.txt are a matrix of numeric values with 7352x561 and 2947x561 correspondingly.  There are 561 different measurements, i.e. features.
* y_train.txt and y_test.txt contain a single column of integer value indicating: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
* subject_train.txt and subject_test.txt contain a single column of integer value identifying the peoson (subject) the data is from.
Both y and subject data have the same number of rows as the X file in each set, whereby indicating row level association.

The data files are read in R memory and processed as follows:
* read all the data files into memory
* give this new data frame meaningful column names - I think it is more straight forward to assign name now compared to after more steps.  The less confusion the better.
Each column in X data file gets its name from the feature file.  I did minimum amount of change on the feature name, except remove brackets "()" or underscore "_".
* using cbind to combine each individual set together
* using rbind to combine two sets together

##2. Subsetting the data frame for only mean and standard deviation columns
I define mean column as any column whose name contains "mean", case insensitive.  Standard deviation columns as any column whose name contains "_std", case insensitive.
A vector of mean and std columns is created, and a subset data frame creating by column select on this vector.

##3. Group the subset data by subject (person_id) and activity
Using dplyr group_by function, a data.frame with groups is created.

##4. Create the result data set which calculates mean on all numeric measurement columns
I used the summarize_each function in dplyr to calculate the mean on all columns by subject and activity.  This new data set is written as a **csv** file.

## script is: merge_n_clean_data.r

## Result data file is: by_subject_actv_mean.csv
###Please see the code book for definition of each column in this file.

