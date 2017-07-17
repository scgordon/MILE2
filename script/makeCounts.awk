#
# this script reads a csv metadata file and counts the number of paths in each collection
# the input file has the fields:
# Version 1: Collection,Dialect,Record,Concept,XPath,Content
# Version 2: Collection,Dialect,Record,Concept,Content,XPath,DialectDefinitions
# textElementPaths: Collection,FileName,Xpath
# 
BEGIN { FS = "," }
{
#
#   skip title record - setup data structure
#
if ($1 == "Collection"){
    if(NF == 3 || NF == 4) inputFormat = "textElementPaths";
    else if (NF == 6) inputFormat = "V1";
    else inputFormat == "V2";
    print inputFormat
    next;
}
else {
#
#   read lines and parse csv content (fields delimited by " can have commas
#
    num_fields = parse_csv($0, inputRecord, ",", "\"", "\"", "\\n", 1);
    if (num_fields < 0) {
        printf "ERROR: %s (%d) -> %s\n", csverr, num_fields, $0;
    }
#
#   set variables - parse_csv returns the array inputRecord - field counter starts at 0, not 1
#
    if(inputFormat == "textElementPaths") {
        collection_field = inputRecord[0]
        record_field = inputRecord[1]
        path_field = inputRecord[2]
    } else if (inputFormat == "V2") {
        collection_field = inputRecord[0]
        record_field = inputRecord[2]
        path_field = inputRecord[5]
    } else if (inputFormat == "V1") {
        collection_field = inputRecord[0]
        record_field = inputRecord[2]
        path_field = inputRecord[6]
    }        
#
#   paths counts the number of occurrences of each path across all collections.
#   It also provides a list of unique paths in the file.
#
	paths[path_field]++
#
#   collections counts the total number of input lines (paths) in each collection
#   and provides a list of unique collection names
#
	collections[collection_field]++
#
#   records counts the total number of records
#   and provides a list of unique record names
#
    records[record_field]++
#
#   collectionPaths[collection,path] provides a list of the paths in each collection and a count of their occurence.
#   this is one of the primary outputs - a table of path counts / collection
#
	collectionPaths[collection_field,path_field]++
#
#   collectionRecordPaths provides the number of paths for each record in each collection
#
    collectionRecordPaths[collection_field,record_field]++
#
#   pathCollectionRecords counts the number of records in each collection that include a path
#   this is the second output of this script - the number of records in each collection that include a given path
#
	pathCollectionsRecords[path_field,collection_field,record_field]++
    }
}

END {
#
#   Calculate the number of records in each collection
#
for (collection in collections){
    collectionRecords[collection] = 0
    for (record in records) {
        if (collectionRecordPaths[collection, record] > 0) collectionRecords[collection]++
    }
}
#
#   Do the first output: the number of occuuences of each path in each record
#
#   print out the number of records in each collection
#
    printf "%s ", "Number of Records,"
    for (collection in collections){
        printf "%s,", collectionRecords[collection]
	}
	printf "\n"
#
#   print out the collection names
#
    printf "%s ", "Paths - Number of occurrences,"
    for (collection in collections){
		  printf "%s,", collection
	}
	printf "\n"
#
#   for each path / collection print out the number of occurrences in all records
#
    for (path in paths) {
        printf "%s,", path
    	for (collection in collections){
		  printf "%s,", collectionPaths[collection,path] / collectionRecords[collection]
	   }
	   printf "\n"
    }
####################################################################################
#   do the second output - the number of records with each path in each collection
####################################################################################
#
#   print out the number of records in each collection
#
    printf "%s\n", "####################################################################################"
    printf "%s ", "Number of Records,"
        for (collection in collections){
        printf "%s,", collectionRecords[collection]
	}
	printf "\n"
#    for (collection in collections){
#        collectionOccurrenceCount = 0
#        for (record in records) {
#            if (collectionRecords[collection, record] > 0) collectionOccurrenceCount++
#        }
#		printf "%s,", collectionOccurrenceCount
#	}
#	printf "\n"
#
#   print out the collection names
#
    printf "%s ", "Paths - Number of Records,"
    for (collection in collections){
		  printf "%s,", collection
	}
	printf "\n"
#
#   for each path / collection print out the number of records that contain the path
#
    for (path in paths) {
        printf "%s,", path
        for (collection in collections) {
            collectionRecordsCount = 0
        	for (record in records){
        	   if (pathCollectionsRecords[path, collection, record] > 0) collectionRecordsCount++
            }        
 	   	  printf "%s,", collectionRecordsCount / collectionRecords[collection]
	   }
	   printf "\n"
    }
}
#**************************************************************************
#
# This file is in the public domain.
#
# For more information email LoranceStinson+csv@gmail.com.
# Or see http://lorance.freeshell.org/csv/
#
# Parse a CSV string into an array.
# The number of fields found is returned.
# In the event of an error a negative value is returned and csverr is set to
# the error. See below for the error values.
#
# Parameters:
# string  = The string to parse.
# csv     = The array to parse the fields into.
# sep     = The field separator character. Normally ,
# quote   = The string quote character. Normally "
# escape  = The quote escape character. Normally "
# newline = Handle embedded newlines. Provide either a newline or the
#           string to use in place of a newline. If left empty embedded
#           newlines cause an error.
# trim    = When true spaces around the separator are removed.
#           This affects parsing. Without this a space between the
#           separator and quote result in the quote being ignored.
#
# These variables are private:
# fields  = The number of fields found thus far.
# pos     = Where to pull a field from the string.
# strtrim = True when a string is found so we know to remove the quotes.
#
# Error conditions:
# -1  = Unable to read the next line.
# -2  = Missing end quote.
# -3  = Missing separator.
#
# Notes:
# The code assumes that every field is preceded by a separator, even the
# first field. This makes the logic much simpler, but also requires a
# separator be prepended to the string before parsing.
#**************************************************************************
function parse_csv(string,csv,sep,quote,escape,newline,trim, fields,pos,strtrim) {
    # Make sure there is something to parse.
    if (length(string) == 0) return 0;
    string = sep string; # The code below assumes ,FIELD.
    fields = 0; # The number of fields found thus far.
    while (length(string) > 0) {
        # Remove spaces after the separator if requested.
        if (trim && substr(string, 2, 1) == " ") {
            if (length(string) == 1) return fields;
            string = substr(string, 2);
            continue;
        }
        strtrim = 0; # Used to trim quotes off strings.
        # Handle a quoted field.
        if (substr(string, 2, 1) == quote) {
            pos = 2;
            do {
                pos++
                if (pos != length(string) &&
                    substr(string, pos, 1) == escape &&
                    (substr(string, pos + 1, 1) == quote ||
                     substr(string, pos + 1, 1) == escape)) {
                    # Remove escaped quote characters.
                    string = substr(string, 1, pos - 1) substr(string, pos + 1);
                } else if (substr(string, pos, 1) == quote) {
                    # Found the end of the string.
                    strtrim = 1;
                } else if (newline && pos >= length(string)) {
                    # Handle embedded newlines if requested.
                    if (getline == -1) {
                        csverr = "Unable to read the next line.";
                        return -1;
                    }
                    string = string newline $0;
                }
            } while (pos < length(string) && strtrim == 0)
            if (strtrim == 0) {
                csverr = "Missing end quote.";
                return -2;
            }
        } else {
            # Handle an empty field.
            if (length(string) == 1 || substr(string, 2, 1) == sep) {
                csv[fields] = "";
                fields++;
                if (length(string) == 1)
                    return fields;
                string = substr(string, 2);
                continue;
            }
            # Search for a separator.
            pos = index(substr(string, 2), sep);
            # If there is no separator the rest of the string is a field.
            if (pos == 0) {
                csv[fields] = substr(string, 2);
                fields++;
                return fields;
            }
        }
        # Remove spaces after the separator if requested.
        if (trim && pos != length(string) && substr(string, pos + strtrim, 1) == " ") {
            trim = strtrim
            # Count the number fo spaces found.
            while (pos < length(string) && substr(string, pos + trim, 1) == " ") {
                trim++
            }
            # Remove them from the string.
            string = substr(string, 1, pos + strtrim - 1) substr(string,  pos + trim);
            # Adjust pos with the trimmed spaces if a quotes string was not found.
            if (!strtrim) {
                pos -= trim;
            }
        }
        # Make sure we are at the end of the string or there is a separator.
        if ((pos != length(string) && substr(string, pos + 1, 1) != sep)) {
            csverr = "Missing separator.";
            return -3;
        }
        # Gather the field.
        csv[fields] = substr(string, 2 + strtrim, pos - (1 + strtrim * 2));
        fields++;
        # Remove the field from the string for the next pass.
        string = substr(string, pos + 1);
    }
    return fields;
}