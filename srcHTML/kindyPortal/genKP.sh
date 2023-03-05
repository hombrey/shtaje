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
echo "    <title>Kindy</title> " >> index.html
echo "    <meta name=\"description\" content=\"select lessons from here\">" >> index.html
echo "    <meta name=\"author\" content=\"Hombrey\">" >> index.html
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/styles.css\">" >> index.html
echo "    <script src=\"$SOURCEDIR/functions.js\"></script> " >> index.html
echo "</head>" >> index.html
echo "" >> index.html
echo "<body id=\"myBody\">" >> index.html
echo "    <div id=\"srcdir\" style=\"display:none;\">$SOURCEDIR/</div>" >> index.html
echo "    <div id=\"assetdir\" style=\"display:none\">./</div>" >> index.html
echo "" >> index.html

echo "     <div class=\"gridbox\">" >> index.html
echo "" >> index.html
echo "          <img class=\"fullPage\" id=\"backgroundX\" src=\"$SOURCEDIR/img/BG0.webp\">" >> index.html
echo "          <img class=\"fullPage\" id=\"foregroundX\" src=\"$SOURCEDIR/img/null.webp\">" >> index.html
echo "          <select id=\"selectMam\" name=\"\" onChange=\"selectFile(this.value)\" onclick=\"openNewTab(this.value)\" size=15>" >> index.html

ls -d ./LI1*/*/*.html > $HOMEDIR/tmp/listUnsort.txt
sort --version-sort $HOMEDIR/tmp/listUnsort.txt> $input

    while IFS= read -r line
    do
        truncLine=${line#*/*/*MH}
        echo "          <option value=\"$line\">$truncLine</option>" >> index.html
    done < "$input"

echo "          </select>" >> index.html

echo "" >> index.html
echo "          <select id=\"selectChoi\" name=\"\" onChange=\"selectFile(this.value)\" onclick=\"openNewTab(this.value)\" size=15>" >> index.html

ls -d ./LI2*/*/*.html > $HOMEDIR/tmp/listUnsort.txt
sort --version-sort $HOMEDIR/tmp/listUnsort.txt> $input

    while IFS= read -r line
    do
        truncLine=${line#*/*/*CH}
        echo "          <option value=\"$line\">$truncLine</option>" >> index.html
    done < "$input"

echo "          </select>" >> index.html

echo "" >> index.html
echo "          <select id=\"selectLa\" name=\"\" onChange=\"selectFile(this.value)\" onclick=\"openNewTab(this.value)\" size=15>" >> index.html

ls -d ./LI3*/*/*.html > $HOMEDIR/tmp/listUnsort.txt
sort --version-sort $HOMEDIR/tmp/listUnsort.txt> $input

    while IFS= read -r line
    do
        truncLine=${line#*/*/*LH}
        echo "          <option value=\"$line\">$truncLine</option>" >> index.html
    done < "$input"

echo "          </select>" >> index.html

echo "" >> index.html
echo "          <select id=\"selectOthers\" name=\"\" onChange=\"selectFile(this.value)\" onclick=\"openNewTab(this.value)\" size=15>" >> index.html

ls -d ./LI4*/*/*.html > $HOMEDIR/tmp/listUnsort.txt
sort --version-sort $HOMEDIR/tmp/listUnsort.txt> $input

    while IFS= read -r line
    do
        truncLine=${line#*/*Others/}
        echo "          <option value=\"$line\">$truncLine</option>" >> index.html
    done < "$input"

echo "          </select>" >> index.html

echo "     </div>  <!-- gridbox --> " >> index.html

echo "</body> " >> index.html

echo "</html>" >> index.html
