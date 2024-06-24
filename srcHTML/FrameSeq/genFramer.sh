#!/bin/bash

# extract the source directory from the command used to call this script
SOURCEDIR=`echo "${0%/*}"`
SOURCEROOT=`echo "${0%/*/*}"`
SOURCEPREROOT=`echo "${0%/*/*/*}"`
LESSONDIR=`pwd`
BASEDIR=$(basename $LESSONDIR)

echo "    <!--{{{head-->" > 0_F-X.html
echo "<!DOCTYPE html>" >> 0_F-X.html
echo "<html lang=\"en\">" >> 0_F-X.html
echo "<head>" >> 0_F-X.html
echo "    <title>$BASEDIR</title> " >> 0_F-X.html
echo "    <script src=\"$SOURCEDIR/functions.js\"></script> " >> 0_F-X.html
echo "    <script type=\"text/javascript\">" >> 0_F-X.html
echo "        function setToolSource(urlvalue) {" >> 0_F-X.html
echo "            window.open(urlvalue,'_blank');" >> 0_F-X.html
echo "        }" >> 0_F-X.html
echo "    </script>" >> 0_F-X.html
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/styles.css\">" >> 0_F-X.html
echo "</head>" >> 0_F-X.html
echo "    <!--}}}head-->" >> 0_F-X.html
echo "<body>" >> 0_F-X.html
echo "    <!--{{{outerFrame-->" >> 0_F-X.html

#set background
case $LESSONDIR in
	*/KH*|*/PH*|*/SH*)
		echo " <img class=\"fullPage\" id=\"backgroundX\" src=\"$SOURCEDIR/backgroundAP.jpg\">" >> 0_F-X.html
	;;
	*)
		echo " <img class=\"fullPage\" id=\"backgroundX\" src=\"$SOURCEDIR/background.jpg\">" >> 0_F-X.html
	;;
esac

#set initially loaded frame
case $LESSONDIR in
    *"LI1_Mam"*| *"LI2_Choi"*| *"LI3_La"*)
		echo " <iframe class=\"subframe\" id=\"myIframe\" src=\"$SOURCEPREROOT/SongsHTML/SK0_attach/0_hi/x_horiz.html\"></iframe>" >> 0_F-X.html
    ;;
    *"SongsHTML"*)
		echo " <iframe class=\"subframe\" id=\"myIframe\" src=\"./5_sndCH/x_horiz.html\"></iframe>" >> 0_F-X.html
    ;;
	*)
		echo " <iframe class=\"subframe\" id=\"myIframe\" src=\"$SOURCEROOT/startpage/index.html\"></iframe>" >> 0_F-X.html
		echo "<!-- <iframe class=\"subframe\" id=\"myIframe\" src=\"  \"></iframe> -->" >> 0_F-X.html
	;;
esac
echo "" >> 0_F-X.html
echo "    <select id=\"toolSelect\" onClick=\"setToolSource(this.value)\" size=1 autofocus> " >> 0_F-X.html

echo "      <option value=\"$SOURCEROOT/Klyne/klyne.html\">Klyne</option> " >> 0_F-X.html
echo "      <option value=\"./\">localDir</option> " >> 0_F-X.html
echo "   </select>" >> 0_F-X.html
echo "    <!--}}}outerFrame-->" >> 0_F-X.html

echo "    <select id=\"seqSelect\" onChange=\"setSeqSource()\" size=1> " >> 0_F-X.html

#attach common frames before lesson frames
case $LESSONDIR in
    *"LI1_Mam"*)
		echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/0_hi/x_horiz.html\">0_hello</option> " >> 0_F-X.html
        echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/1_L1/x_horiz.html\">3_WarmUp</option> " >> 0_F-X.html
		echo "        <option value=\"$SOURCEROOT/Klyne/klyne.html\">9_classMgt</option> " >> 0_F-X.html
    ;;
    *"LI2_Choi"*)
		echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/0_hi/x_horiz.html\">0_hello</option> " >> 0_F-X.html
        echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/2_L2/x_horiz.html\">3_WarmUp</option> " >> 0_F-X.html
		echo "        <option value=\"$SOURCEROOT/Klyne/klyne.html\">9_classMgt</option> " >> 0_F-X.html
    ;;
    *"LI3_La"*)
		echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/0_hi/x_horiz.html\">0_hello</option> " >> 0_F-X.html
        echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/3_L3/x_horiz.html\">3_WarmUp</option> " >> 0_F-X.html
		echo "        <option value=\"$SOURCEROOT/Klyne/klyne.html\">9_classMgt</option> " >> 0_F-X.html
	;;
	*)
		echo "        <option value=\"$SOURCEROOT/startpage/index.html\">$BASEDIR</option> " >> 0_F-X.html
	;;
esac
echo "" >> 0_F-X.html

#list html files in lesson plan root directory
ls -d *.html > $LESSONDIR/list.txt
input="$LESSONDIR/list.txt"
arrayIndex=1;

while IFS= read -r line
do
    EVAL=`echo " \"$line\" "`
    if [[ $EVAL == *"html"* && $EVAL != *"0_"* ]]; then
    echo "        <option value=\"./$line\">leqx</option> " >> 0_F-X.html
        ((arrayIndex++))
    fi
done < "$input"

#list html files tucked in a subdirectory
ls -d ./*/*.html> $LESSONDIR/listUnsort.txt

#this makes sure that the time tags are in order
sort --version-sort $LESSONDIR/listUnsort.txt> $LESSONDIR/list.txt

input="$LESSONDIR/list.txt"
arrayIndex=1;

while IFS= read -r line
do
    EVAL=`echo " \"$line\" "`
    if [[ $EVAL == *"html"* ]]; then
        #trim trailing text 
        TRIMDIR=`echo "${line%/*}"`
        #trim leading text 
        TRIMDIR=`echo "${TRIMDIR#*/}"`
    echo "        <option value=\"$line\">"$TRIMDIR"</option> " >> 0_F-X.html
        ((arrayIndex++))
    fi
done < "$input"

echo "" >> 0_F-X.html


#attach common frames after lesson frames
case $LESSONDIR in
    *"LI1_Mam"*| *"LI2_Choi"*| *"LI3_La"*)
		echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/4_bye/x_horiz.html\">30_Bye</option>" >> 0_F-X.html
    ;;
	*)
		echo "" 
	;;
esac

echo "   </select>" >> 0_F-X.html
echo "</body>" >> 0_F-X.html
echo "</html>" >> 0_F-X.html

rm $LESSONDIR/list.txt
rm $LESSONDIR/listUnsort.txt
