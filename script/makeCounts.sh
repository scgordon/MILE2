#
# this script deletes information from the ISO metadata distribution to decrease number of records and length of xpaths by
# ignoring lines with XML attributes (@)
# removing UML package names and types from xPaths
# extracting collection, record, path
# counting unique combinations of collection, record, path
# 
grep -v @ | sed -f $METADATATOOLS/deleteISOTypesFromPaths.sed | awk -f $METADATATOOLS/makeCounts.awk 
