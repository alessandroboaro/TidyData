==================================================================


run_analysis.R
======================================

- the script expects to have text files with column names (features.txt) and activity names (activity_labels) in the working directory
- again, the script expects a folder "test" and a folder "train" cointaining actual data, as in the example

1. the script loads labels for columns in the features.txt file and the label for activities in the activity_labels.txt file
2. then test data are loaded as raw matrix
3. the matrix function is called to set the right number of columns and column names
4. activity values are loaded and then joined with corresponding labels
5. activity values and test data are merged (by column)
6. steps 2-5 are repeated for train data
7. then, full_dataset is created merging train and test datasets
8. using aggregate function, means for each activity is computed

