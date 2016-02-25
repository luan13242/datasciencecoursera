# DATA CLEANING - WK4 PROJECT

The data used by this project are generated from smartphones that people wear doing daily activities, such as walking, standing, etc.

The raw data captured by smartphones are: accelerations along x, y, z axials, and angular velocity along x, y, z axials.
For more details, please reference to: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data is divided into a training set (to create a machine learning model), and a testing set (to evaluate the machine learning model).

Data of the training/testing set are:
* 1. X_train.txt and X_test.txt are a matrix of numeric values with 7352x561 and 2947x561 correspondingly.
* 2. y_train.txt and y_test.txt contain a single column of integer value indicating: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
* 3. subject_train.txt and subject_test.txt contain a single column of integer value identifying the peoson (subject) the data is from.
* 4. Both the y and subject data have the same number of rows whereby indicating the rows of the y and subject files are associated to the x files.

I worked the data with the following steps (using R) to achieve the requested result:
* 1. read all the data files into memory
* 2. associate the subject data, activity (y) data, with the measurements (X) data
* 3. give this new data frame meaningful column names
