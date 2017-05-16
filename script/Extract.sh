#Extract runs the xsl DialectExtractor to create an xml representation of every known definition 
#in a dialect for concepts in AllCrosswalks. It requires one argument: the dialect code of the 
#dialect needed for analysis.
cd ../../Crosswalks
CrosswalkHome=$(pwd)

java net.sf.saxon.Transform \
-s:$CrosswalkHome/AllCrosswalks.xml \
-xsl:$CrosswalkHome/DialectExtractor.xsl \
-o:$CrosswalkHome/DialectXML/dialect$1.xml \
DialectToExtract=$1 \


