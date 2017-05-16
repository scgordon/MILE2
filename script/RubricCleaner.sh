#sed commands to clean namespace references if neccessary. Most NASA cases do not require this
#script to be run.
sed -i -e 's|/csdgm:|/|g' /Users/scgordon/Crosswalks/dialectRubrics/rubricCSDGM.xsl 
sed -i -e 's|/bdp:|/|g' /Users/scgordon/Crosswalks/dialectRubrics/rubricBDP.xsl 
sed -i -e 's|/mercury:|/|g' /Users/scgordon/Crosswalks/dialectRubrics/rubricMercury.xsl
sed -i -e 's|/eml:|/|g' /Users/scgordon/Crosswalks/dialectRubrics/rubricEML.xsl &&
sed -i -e 's|"/eml/|"/eml:eml/|g' /Users/scgordon/Crosswalks/dialectRubrics/rubricEML.xsl
sed -i -e 's|/rda:|/|g' /Users/scgordon/Crosswalks/dialectRubrics/rubricRDA-CISL.xsl
sed -i -e 's|/dcite:|/|g' /Users/scgordon/Crosswalks/dialectRubrics/rubricDCITE.xsl
sed -i -e 's|/mods:|/|g' /Users/scgordon/Crosswalks/dialectRubrics/rubricMODS.xsl 
sed -i -e 's|/mercury:|/|g' /Users/scgordon/Crosswalks/dialectRubrics/rubricMercury.xsl 
