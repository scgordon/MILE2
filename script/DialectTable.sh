#This script controls the creation of a csv table of the existence of a concept in a dialect.
#The rows are concepts from AllCrosswalks.xml, sorted alphabetically. 
#The columns are the dialect codes chosen by setting the dialectDisplayListString(first argument)
#The dialectDisplayListString parameter default setting is:
#19110,ACDD,ADIwg,BDP,CSDGM,DCAT,DCITE,DIF,DIF-10,Dryad,ECHO,ECS,EML,EOL,HCLS,HDF5.1,ISO,ISO-1,MODS,Mercury,NUG,OGC-SOS,Onedcx,PROV,RDA-CISL,SERF,THREDDS,UMM,WSDL
#The second argument can be set to Paths to obtain crosswalks between dialects for the concepts
#in AllCrosswalks.xml. Simply input the dialect you know, and the one you want to know in the 
#first arguement then Paths in the second. Otherwise output is 1 for dialect definition exists 
#and 0 for dialect definition is not known to exist. This is the preferred way for operation of
#automatic dialect recognition and essential to determining the difference between 
#not in the record and doesn't exist in the dialect
#This means that for the RADworkflow no arguements need to be set.  
cd ../
ConceptMining=$(pwd)
cd ../Crosswalks 
CrosswalkHome=$(pwd) 

    java net.sf.saxon.Transform \
    -s:$CrosswalkHome/AllCrosswalks.xml \
    -xsl:$CrosswalkHome/Tables/xsl/excelDialectExtractor.xsl \
    -o:$ConceptMining/Tables/dialectTable/dialectContains.csv \
    #dialectDisplayListString=$1
    #pathsOr1s=$2

