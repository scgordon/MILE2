#sed commands to clean namespace references if neccessary. Most NASA cases do not require this
#script to be run.
cd ../../Crosswalks
CrosswalkHome=$(pwd)
sed -i -e 's|/csdgm:|/|g' $CrosswalkHome/dialectRubrics/rubricCSDGM.xsl 
sed -i -e 's|/bdp:|/|g' $CrosswalkHome/dialectRubrics/rubricBDP.xsl 
sed -i -e 's|/mercury:|/|g' $CrosswalkHome/dialectRubrics/rubricMercury.xsl
sed -i -e 's|/eml:|/|g' $CrosswalkHome/dialectRubrics/rubricEML.xsl &&
sed -i -e 's|"/eml/|"/eml:eml/|g' $CrosswalkHome/dialectRubrics/rubricEML.xsl
sed -i -e 's|/rda:|/|g' $CrosswalkHome/dialectRubrics/rubricRDA-CISL.xsl
sed -i -e 's|/dcite:|/|g' $CrosswalkHome/dialectRubrics/rubricDCITE.xsl
sed -i -e 's|/mods:|/|g' $CrosswalkHome/dialectRubrics/rubricMODS.xsl 
sed -i -e 's|/mercury:|/|g' $CrosswalkHome/dialectRubrics/rubricMercury.xsl 
