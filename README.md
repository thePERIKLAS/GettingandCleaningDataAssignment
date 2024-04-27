# GettingandCleaningDataAssignment
Author: Periklis Giannakis

# Goals (as written on the page of the assignment)
1. A tidy data set 
2. A link to a Github repository with your script for performing the analysis 
3. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
4. Analysis R Script

# Describing how the script works
The script is designed to work in any possible surface of RStudio (Posit, Offline, Sandbox etc.). 
The code is not designed to set any wd so feel free to add to the code if you want a different wd or a specific file location.
I have used the baseR package, the data.table and the reshape2 package all covered in the lectures of this course.
I have tried to write the code as efficiently as possible with comments explaining my thought process along the way for readability and continuity.
Feel free to make any changes and adapt the code if you would like it to become more efficient.
The code (in order):
1. Downloads the data from the link provided in the programming assignment description.
2. Unzips the dataFiles file.
3. Loads the activity labes and features files.
4. Extracts the mean and SDfor each measurement.
5. Renames columns to cleaner versions that avoid typos.
6. Loads test datasets.
7. Loads train datasets.
8. Merges test + train.
9. Gives descriptive activity names to the dataset.
10. Creates a second independent tidy data set with the average of each variable for each activity and each subject.

# Provided in the repo (+README that you are reading
goal | item
--- | ---
Analysis R Script | run_analysis.R
Tidy Data Set | tidyData.txt
CodeBook | CodeBook.md
