#Data.sh applies the rubric for a dialect to a collection. This creates the data.csv that
#a RAD.xlsx functions on. It requires three arguments. The first is the organization the second 
#is the dialect, the third is the collection. GetData.sh is the batch script for Data.sh
cd ../
ConceptMining=$(pwd)
cd ../CrosswalksWorkflow
CrosswalkWorkflow=$(pwd)
cd ../Crosswalks 
CrosswalkHome=$(pwd) 

    java net.sf.saxon.Transform \
    -s:$CrosswalkWorkflow/collections/dummy.xml \
    -xsl:$CrosswalkHome/dialectRubrics/rubric$2test3.xsl \
    -o:$ConceptMining/data/$1/$3_$2_data.csv \
    fileNamePattern=*.xml \
    recordSetPath=$CrosswalkWorkflow/collections/$1/$3/$2/xml \
    dialectName=$2 \
    delimiter=',' \
   

	