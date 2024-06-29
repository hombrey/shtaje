#!/bin/bash

# extract the source directory from the command used to call this script
SOURCEDIR=`echo "${0%/*}"`
LESSONDIR=`pwd`

ALTWAVCOUNT="$(find ./altwav -maxdepth 1 -type f -printf x | wc -c)"
echo "countALTWAV: $ALTWAVCOUNT"

echo "<!DOCTYPE html>" > xPeepWave.html
echo "<html lang=\"en\">" >> xPeepWave.html
echo "<head>" >> xPeepWave.html
echo "    <meta charset=\"UTF-8\">" >> xPeepWave.html
echo "    <title></title> " >> xPeepWave.html
echo "    <meta name=\"description\" content\"\">" >> xPeepWave.html
echo "    <meta name=\"author\" content=\"Hombrey\">" >> xPeepWave.html
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/styles.css\">" >> xPeepWave.html
echo "</head>" >> xPeepWave.html
echo "" >> xPeepWave.html
echo "<body id=\"myBody\">" >> xPeepWave.html
echo "    <img class=\"fullPage\" id=\"backgroundX\" src=\"$SOURCEDIR/img/scene0.jpg\">" >> xPeepWave.html
echo "    <div id=\"srcdir\" style=\"display:none;\">$SOURCEDIR/</div>" >> xPeepWave.html
echo "    <div id=\"assetdir\" style=\"display:none\">./</div>" >> xPeepWave.html
echo "    <div id=\"altwavcount\" style=\"display:none\">$ALTWAVCOUNT</div>" >> xPeepWave.html
echo "    <canvas class=\"canvasClass\" id=\"canvas\" width=\"1280\" height=\"720\" ></canvas>" >> xPeepWave.html
echo "    <div id=\"pauseIndicator\"></div>" >> xPeepWave.html
echo "    <select class=\"selectBox\" id=\"dummy\"><option>Peep Wave</option></select>" >> xPeepWave.html
echo "    <script type=\"text/javascript\" src=\"$SOURCEDIR/functions.js\" ></script> " >> xPeepWave.html
echo "</body> " >> xPeepWave.html
echo "    <script> " >> xPeepWave.html
echo "      function initArrays() {" >> xPeepWave.html

ls ./wav| sort -n> $LESSONDIR/genList.txt
input="$LESSONDIR/genList.txt"
arrayIndex=1;

echo "          wavSet = [new sound (srcDir+\"wav/pick.mp3\")," >> xPeepWave.html
while IFS= read -r line
do
    EVAL=`echo " \"$line\" "`
    if [[ $EVAL == *"mp3"* ]]; then
        echo "              new sound (assetDir+\"wav/$line\")," >> xPeepWave.html
        ((arrayIndex++)) 
    fi
done < "$input"
echo "          new sound (srcDir+\"wav/pick.mp3\")];" >> xPeepWave.html


ls | sort -n> $LESSONDIR/genListUnsort.txt
input="$LESSONDIR/genList.txt"
arrayIndex=1;

#this makes sure that the time tags are in order
sort --version-sort $LESSONDIR/genListUnsort.txt> $LESSONDIR/genList.txt

echo "          picSet = [ {src: \"\", wav: 0}," >> xPeepWave.html
while IFS= read -r line
do
    EVAL=`echo " \"$line\" "`
    if [[ $EVAL == *"jpg"* || $EVAL == *"png"* || $EVAL == *"webp"* || $EVAL == *"avif"* ]]; then
        echo "              {src: \"$line\", wav: $arrayIndex }," >> xPeepWave.html
        ((arrayIndex++)) 
    fi
done < "$input"

echo "          {}];" >> xPeepWave.html
echo "      } // function initArrays()" >> xPeepWave.html
echo "    </script> " >> xPeepWave.html
echo "</html> " >> xPeepWave.html

rm $LESSONDIR/genList.txt
rm $LESSONDIR/genListUnsort.txt

# creete directories used by this iframe. Ignore errors if directories already exist
mkdir alt || true
