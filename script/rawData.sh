cd ../
ConceptMining=$(pwd)
cd ../CrosswalksWorkflow
CrosswalkWorkflow=$(pwd)
cd ../Crosswalks 
CrosswalkHome=$(pwd) 
cd ../Transforms/Utility
UtilityHome=$(pwd)
    java net.sf.saxon.Transform \
    -s:$CrosswalkWorkflow/collections/dummy.xml \
    -xsl:$UtilityHome/textElementPaths.xsl \
    -o:$ConceptMining/rawData/$1/$3_$2_data.csv \
    fileNamePattern=*.xml \
    recordSetPath=$CrosswalkWorkflow/collections/$1/$3/$2/xml \
    showFilename=1 \
    showCollectionName=1 \
    dialectName=$2 \
    delimiter=',' \