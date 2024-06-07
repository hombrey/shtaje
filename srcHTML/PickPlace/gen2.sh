#!/bin/bash

# extract the source directory from the command used to call this script
SOURCEDIR=`echo "${0%/*}"`
# HOMEDIR=`echo ~`
TARGETFILE='x_Pick.html'
LESSONDIR=`pwd`
#truncate last character (i.e. "/")

# prevent overwrite of previously generated file
if [[ -f ./x_Pick.html ]]; then
		TARGETFILE='x_Pick-new.html'
fi


echo "<!DOCTYPE html>" > $TARGETFILE
echo "<html lang=\"en\">" >> $TARGETFILE
echo "<head>" >> $TARGETFILE
echo "    <meta charset=\"UTF-8\">" >> $TARGETFILE
echo "    <title></title> " >> $TARGETFILE
echo "    <meta name=\"description\" content\"\">" >> $TARGETFILE
echo "    <meta name=\"author\" content=\"Hombrey\">" >> $TARGETFILE
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/styles.css\">" >> $TARGETFILE
echo "</head>" >> $TARGETFILE
echo "" >> $TARGETFILE
echo "<body id=\"myBody\">" >> $TARGETFILE
echo "    <div id=\"srcdir\" style=\"display:none;\">$SOURCEDIR/</div>" >> $TARGETFILE
echo "    <div id=\"assetdir\" style=\"display:none\">./</div>" >> $TARGETFILE
echo "" >> $TARGETFILE
echo "    <img class=\"fullPage\" id=\"backgroundX\" src=\"$SOURCEDIR/img/BG0.png\">" >> $TARGETFILE
echo "    <select class=\"selectBox\" id=\"dummy\"><option>PickAndPlace</option></select>" >> $TARGETFILE
echo "    <script src=\"$SOURCEDIR/func2.js\"></script> " >> $TARGETFILE

ls $SOURCEDIR/tail2 | sort -n > $LESSONDIR/list.txt
filelist="$LESSONDIR/list.txt"

echo $SOURCEDIR
tailindex=1;
tails=("")
while IFS= read -r line
do
    EVAL=`echo " \"$line\" "`
    if [[ $EVAL == *"html"* ]]; then
          echo "        $tailindex $line" 
          tails+=("$line")
          ((tailindex++))
    fi
done < "$filelist"

read -p "select Tail: " selectedTail

#TAILTYPE=`echo $1`
TAILTYPE=`echo $SOURCEDIR/tail2/${tails[selectedTail]}`
cat "$TAILTYPE" >> $TARGETFILE
rm $filelist
