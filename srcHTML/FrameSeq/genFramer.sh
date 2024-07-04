#!/bin/bash

# extract the source directory from the command used to call this script
SOURCEDIR=`echo "${0%/*}"`
SOURCEROOT=`echo "${0%/*/*}"`
SOURCEPREROOT=`echo "${0%/*/*/*}"`
LESSONDIR=`pwd`
BASEDIR=$(basename $LESSONDIR)
GENFILE="0_F-X.html"

[[ $SOURCEDIR == "./srcHTML/FrameSeq" ]] && GENFILE="index.html"

echo "    <!--{{{head-->" > $GENFILE
echo "<!DOCTYPE html>" >> $GENFILE
echo "<html lang=\"en\">" >> $GENFILE
echo "<head>" >> $GENFILE
echo "    <title>$BASEDIR</title> " >> $GENFILE
echo "    <script src=\"$SOURCEDIR/functions.js\"></script> " >> $GENFILE
echo "    <script type=\"text/javascript\">" >> $GENFILE
echo "        function setToolSource(urlvalue) {" >> $GENFILE
echo "            window.open(urlvalue,'_blank');" >> $GENFILE
echo "        }" >> $GENFILE
echo "    </script>" >> $GENFILE
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/styles.css\">" >> $GENFILE
echo "</head>" >> $GENFILE
echo "<body>" >> $GENFILE
echo "    <!--}}}head-->" >> $GENFILE

echo "    <select id=\"seqSelect\" onChange=\"setSeqSource()\" size=1> " >> $GENFILE

#attach common frames before lesson frames
case $LESSONDIR in
    *"LI1_Mam"*)
		echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/0_hi/x_horiz.html\">0_hello</option> " >> $GENFILE
        echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/1_L1/x_horiz.html\">3_WarmUp</option> " >> $GENFILE
		echo "        <option value=\"$SOURCEROOT/Klyne/klyne.html\">9_classMgt</option> " >> $GENFILE
    ;;
    *"LI2_Choi"*)
		echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/0_hi/x_horiz.html\">0_hello</option> " >> $GENFILE
        echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/2_L2/x_horiz.html\">3_WarmUp</option> " >> $GENFILE
		echo "        <option value=\"$SOURCEROOT/Klyne/klyne.html\">9_classMgt</option> " >> $GENFILE
    ;;
    *"LI3_La"*)
		echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/0_hi/x_horiz.html\">0_hello</option> " >> $GENFILE
        echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/3_L3/x_horiz.html\">3_WarmUp</option> " >> $GENFILE
		echo "        <option value=\"$SOURCEROOT/Klyne/klyne.html\">9_classMgt</option> " >> $GENFILE
	;;
	*)
		read -p "use startpage? (y/n) " hasStartPage

		if [[ $hasStartPage == "y" ]]; then
						echo "        <option value=\"$SOURCEROOT/startpage/index.html\">$BASEDIR</option> " >> $GENFILE
		fi

	;;
esac
echo "" >> $GENFILE

#list html files in lesson plan root directory
ls -d *.html > $LESSONDIR/list.txt
input="$LESSONDIR/list.txt"
arrayIndex=1;

while IFS= read -r line
do
    EVAL=`echo " \"$line\" "`
    if [[ $EVAL == *"html"* && $EVAL != *"0_"* ]]; then
    echo "        <option value=\"./$line\">leqx</option> " >> $GENFILE
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
				echo "        <option value=\"$line\">"$TRIMDIR"</option> " >> $GENFILE
				if [[ $arrayIndex -eq 1 ]]; then
						FIRSTHTML=$line
				fi
        ((arrayIndex++))
    fi
done < "$input"

echo "" >> $GENFILE


#attach common frames after lesson frames
case $LESSONDIR in
    *"LI1_Mam"*| *"LI2_Choi"*| *"LI3_La"*)
		echo "        <option value=\"$SOURCEPREROOT/SongsHTML/SK0_attach/4_bye/x_horiz.html\">30_Bye</option>" >> $GENFILE
    ;;
	*)
		echo "" 
	;;
esac

echo "   </select>" >> $GENFILE

echo "    <!--{{{foot-->" >> $GENFILE

#set background
echo " <img class=\"fullPage\" id=\"backgroundX\" src=\"$SOURCEDIR/background.jpg\">" >> $GENFILE

#set initially loaded frame
case $LESSONDIR in
    *"LI1_Mam"*| *"LI2_Choi"*| *"LI3_La"*)
		echo " <iframe class=\"subframe\" id=\"myIframe\" src=\"$SOURCEPREROOT/SongsHTML/SK0_attach/0_hi/x_horiz.html\"></iframe>" >> $GENFILE
    ;;
    *"SongsHTML"*)
		echo " <iframe class=\"subframe\" id=\"myIframe\" src=\"./5_sndCH/x_horiz.html\"></iframe>" >> $GENFILE
    ;;
	*)

		if [[ $hasStartPage == "y" ]]; then
					echo " <iframe class=\"subframe\" id=\"myIframe\" src=\"$SOURCEROOT/startpage/index.html\"></iframe>" >> $GENFILE
		else
					echo " <iframe class=\"subframe\" id=\"myIframe\" src=\"$FIRSTHTML\" ">> $GENFILE
		fi
	;;
esac
echo "" >> $GENFILE
echo "    <select id=\"toolSelect\" onClick=\"setToolSource(this.value)\" size=1 autofocus> " >> $GENFILE

echo "      <option value=\"$SOURCEROOT/Klyne/klyne.html\">Klyne</option> " >> $GENFILE
echo "      <option value=\"./\">localDir</option> " >> $GENFILE
echo "   </select>" >> $GENFILE
echo "</body>" >> $GENFILE
echo "</html>" >> $GENFILE
echo "    <!--}}}foot-->" >> $GENFILE


rm $LESSONDIR/list.txt
rm $LESSONDIR/listUnsort.txt
