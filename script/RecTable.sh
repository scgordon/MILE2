#This script creates the table of all spirals that have a tag, and if they have the same tag, group them together. the resultant RecTag.csv can be copy-pasted into the RAD.xlsx worksheet of the same name. 
cd ../
ConceptMining=$(pwd)
cd ../Crosswalks 
CrosswalkHome=$(pwd) 

    java net.sf.saxon.Transform \
    -s:$CrosswalkHome/AllCrosswalks.xml \
    -xsl:$CrosswalkHome/Tables/xsl/excelRecExtractor.xsl \
    -o:$ConceptMining/Tables/recommendationsTable/RecTag.csv \
