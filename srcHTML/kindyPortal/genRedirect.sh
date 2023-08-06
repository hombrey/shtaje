#!/bin/bash

# extract the source directory from the command used to call this script
SOURCEDIR=`echo "${0%/*}"`
ASSETDIR='./'
HOMEDIR=`echo ~`
#truncate last character (i.e. "/")

input="$HOMEDIR/tmp/list.txt"

echo "<!DOCTYPE html>" > index.html
echo "<html lang=\"en\">" >> index.html
echo "<head>" >> index.html
echo "    <meta charset=\"UTF-8\">" >> index.html
echo "    <title>Redirect to lesson</title> " >> index.html
echo "</head>" >> index.html
echo "" >> index.html
echo "<body id=\"myBody\">" >> index.html

ls -d ./LI4*/*/*.html > $HOMEDIR/tmp/listUnsort.txt
sort --version-sort $HOMEDIR/tmp/listUnsort.txt> $input
while IFS= read -r line
    do
        truncLine=${line#*/*LI4_}
        echo   "<!-- <meta http-equiv=\"Refresh\" content=\"0; url='$line'\" /> -->" >> index.html
    done < "$input"

echo "</body> " >> index.html

echo "</html>" >> index.html
