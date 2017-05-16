#Data.sh applies the rubric for a dialect to a collection. This creates the data.csv that
#a RAD.xlsx functions on. It requires three arguments. The first is the organization the second 
#is the dialect, the third is the collection. GetData.sh is the batch script for Data.sh
cd ../
Mile2=$(pwd)
cd ../Crosswalks 
CrosswalkHome=$(pwd) 

    java net.sf.saxon.Transform \
    -s:$Mile2/collection/dummy.xml \
    -xsl:$CrosswalkHome/dialectRubrics/rubric$2.xsl \
    -o:$Mile2/data/$1/$3_$2_data.csv \
    fileNamePattern=*.xml \
    recordSetPath=$Mile2/collection/$1/$3/$2/xml \
    dialectName=$2 \
    delimiter=',' \
   

	