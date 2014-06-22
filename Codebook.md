Getting and cleaning the data codebook
======================================

**** We use following files ****

  -  features.txt
  - /train/train.txt
  - /test/test.txt
  - /train/subject_train.txt
  - /test/subject_test.txt
 
**** Variables ****

  - *indexes*  is used for selecting right columns
  from datasets(train and test)
  - *features* holds information about measurements results
  - *labels* holds information about activity codes

**** Data cleaning ****
  - removed all '-' chracters
  - selected only 81 columns instead of original over five hundred columns
  - used *reshape* package methods *dcast* and *melt*



  