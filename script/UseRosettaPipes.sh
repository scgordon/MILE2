#Data.sh applies the rubric for a dialect to a collection. This creates the data.csv that
#a RAD.xlsx functions on. It requires three arguments. The first is the organization, the second is the collection the third 
#is the dialect. GetData.sh is the batch script for Data.sh
cd ../
Mile2=$(pwd)
cd ../Crosswalks 
CrosswalkHome=$(pwd) 

    java net.sf.saxon.Transform \
    -s:$Mile2/collection/dummy.xml \
    -xsl:$CrosswalkHome/Rosetta/Rosetta.xsl \
    -o:$Mile2/data/$1/$2_$3_data.csv \
    fileNamePattern=*.xml \
    delimiter='|'
    recordSetPath=$Mile2/collection/$1/$2/$3/xml \
      

	