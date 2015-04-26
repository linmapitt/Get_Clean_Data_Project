==================================================================
run_analysis.R
Version 1.0 By linmapitt
==================================================================
This run_analysis.R script should be put in the same directory as test and train data folder,
so it will find the test and train data correctly.


The R Script performs the following data process steps:
======================================

- Combines Subject data, Activity data and Measurements data from both test and train folders
- Replace activity labels with actual activity names
- Polish Measurements column name to be more descriptive
- Pick only mean values and Standard deviation values from Measurements data
- Group data by Subject and Activity, and then calculate mean values for each measurement column.
