#!/bin/bash

#Rubric runs the xsl WriteDialectXSL to create a xsl rubric used to assess the collections records 
#It requires one argument: the dialect code of the dialect needed for analysis.
cd ../../Crosswalks 
CrosswalkHome=$(pwd) 
dialectCode=$1

    java net.sf.saxon.Transform \
    -s:$CrosswalkHome/DialectXML/dialect$dialectCode.xml \
    -xsl:$CrosswalkHome/DialectXML/xsl/WriteDialectExtractorXSL.xsl \
    -o:$CrosswalkHome/dialectRubrics/rubric$dialectCode.xsl \
showCollectionName='1' \
showDialect='1' \
showFilename='1' \
    

	