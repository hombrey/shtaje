#!/bin/bash

# extract the source directory from the command used to call this script
SOURCEDIR=`echo "${0%/*}"`
SOURCEROOT=`echo "${0%/*/*}"`
LESSONDIR=`pwd`
TARGETFILE='0_void.html'

echo "<!DOCTYPE html>" > $TARGETFILE
echo "<html lang=\"en\">" >> $TARGETFILE
echo "<head>" >> $TARGETFILE
echo "    <script src=\"$SOURCEDIR/functions.js\"></script> " >> $TARGETFILE
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/styles.css\">" >> $TARGETFILE
echo "</head>" >> $TARGETFILE
echo "<body>" >> $TARGETFILE
echo "    <select class=\"selectBox\" id=\"dummy\"><option>empty</option></select>" >> $TARGETFILE
echo "    <div id=\"srcdir\" style=\"display:none;\">$SOURCEDIR/</div>" >> $TARGETFILE
        if [[ $1 == *"pdf" || $1 == *"PDF" ]]; then
					echo "    <object  class=\"pdf\" data=\"$1\">reader</object>" >> $TARGETFILE
        fi
echo "</body>" >> $TARGETFILE
echo "</html>" >> $TARGETFILE
