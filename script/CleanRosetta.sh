#sed commands to clean namespace references if neccessary. Most NASA cases do not require this
#script to be run.
cd ../../Crosswalks
CrosswalkHome=$(pwd)
sed -i -e 's|/csdgm:|/|g' $CrosswalkHome/Rosetta/Rosetta.xsl
sed -i -e 's|/bdp:|/|g' $CrosswalkHome/Rosetta/Rosetta.xsl
sed -i -e 's|/mercury:|/|g' $CrosswalkHome/Rosetta/Rosetta.xsl
sed -i -e 's|/eml:|/|g' $CrosswalkHome/Rosetta/Rosetta.xsl &&
sed -i -e 's|"/eml/|"/eml:eml/|g' $CrosswalkHome/Rosetta/Rosetta.xsl
sed -i -e 's|/rda:|/|g' $CrosswalkHome/Rosetta/Rosetta.xsl
sed -i -e 's|/dcite:|/|g' $CrosswalkHome/Rosetta/Rosetta.xsl
sed -i -e 's|/mods:|/|g' $CrosswalkHome/Rosetta/Rosetta.xsl
sed -i -e 's|/mercury:|/|g' $CrosswalkHome/Rosetta/Rosetta.xsl 
sed -i -e 's|//*||g' $CrosswalkHome/Rosetta/Rosetta.xsl 