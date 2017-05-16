#This script controls the workflow for generating the tables that are needed to create an up-to-date Recommendations Analysis Dashboard
#The reasoning for creating the workflow is to not only increase the speed with which analyses can be generated, 
#but also to reanalyze as understandings
#The first script, RunExtract, is a batch script that extracts the dialect xml that is used by RunRubric to create the analysis tools 
#which after being cleaned if neccessary by the RubricCleaner, are used directly on the organizations xml to produce 
#a cd.csv that contains a row for each concept found in each record. Each row contains: Collection Name, File Name, Dialect Code, and Concept Name
#RecTable pulls out every tagged recommendation and their subset concepts in each recommendation profile and creates a recTag.csv 
#that can update the hidden worksheet of the same name in a RAD.xlsx 
#DialectTables does the same thing for every dialect it creates a binary representation of whether the dialect contains the concept. 
#This table can also be used to update a hidden table of the same name in a RAD.xlsx. These updates are neccessary if any dialect improvements or 
#recommendation revisions are made to AllCrosswalks.

./RunExtract.sh &&
./RunRubric.sh &&
./RubricCleaner.sh &&
./GetData.sh &&
./GetRawData.sh &&
./RecTable.sh
./DialectTable.sh