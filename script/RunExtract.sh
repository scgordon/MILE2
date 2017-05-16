#This is a batch script that runs the needed instances of Extract
#Extract runs the xsl DialectExtractor to create an xml representation of every known definition 
#in a dialect for concepts in AllCrosswalks. It requires one argument: the dialect code of the 
#dialect needed for analysis.
./Extract.sh CSDGM
./Extract.sh BDP
./Extract.sh EML
./Extract.sh Mercury
./Extract.sh Dryad
./Extract.sh Onedcx
./Extract.sh DCITE
./Extract.sh ISO
./Extract.sh MODS