#!/bin/bash

# extract the source directory from the command used to call this script
SOURCEDIR=`echo "${0%/*}"`
SOURCEROOT=`echo "${0%/*/*}"`
LESSONDIR=`pwd`
TARGETFILE='0_rev-JS.html'

# prevent overwrite of previously generated file
if [[ -f ./0_rev-JS.html ]]; then
		TARGETFILE='0_rev-JS-new.html'
fi

ln -s $SOURCEDIR/reveal/layout-helpers.html .layout-reference

echo "<!DOCTYPE html>" > $TARGETFILE
echo "    <!--{{{header-->" >> $TARGETFILE
echo "<html lang=\"en\">" >> $TARGETFILE
echo "<head>" >> $TARGETFILE
echo "	<meta charset=\"utf-8\"> " >> $TARGETFILE
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/styles.css\">" >> $TARGETFILE
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/reveal/reveal.css\">" >> $TARGETFILE
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/reveal/fragments.css\">" >> $TARGETFILE
echo "    <link id="revealTheme" rel=\"stylesheet\" href=\"$SOURCEDIR/reveal/theme_white.css\">" >> $TARGETFILE
echo "</head>" >> $TARGETFILE
echo "<body>" >> $TARGETFILE
echo "    <select class=\"selectBox\" id=\"dummy\"><option>empty</option></select>" >> $TARGETFILE
echo "    <div id=\"srcdir\" style=\"display:none;\">$SOURCEDIR/</div>" >> $TARGETFILE
echo "    <!--}}}header-->" >> $TARGETFILE
echo "	<div class=\"reveal\"> <div class=\"slides\">" >> $TARGETFILE
echo "" >> $TARGETFILE
echo "<section data-background=\"#00000000\">" >> $TARGETFILE
echo "	<h2>Header</h2>" >> $TARGETFILE
echo "	<p class=\"fragment custom blur\">One</p>" >> $TARGETFILE
echo "	<p class=\"fragment custom blur\">Two</p>" >> $TARGETFILE
echo "</section>" >> $TARGETFILE
echo "" >> $TARGETFILE
echo "	</div> </div> <!-- reveal slides -->" >> $TARGETFILE
echo "    <!--{{{footer-->" >> $TARGETFILE
echo "  <script src=\"../../../srcHTML/blank/functions.js\"></script> " >> $TARGETFILE
echo "	<script src=\"../../../srcHTML/blank/reveal/reveal.js\"></script>" >> $TARGETFILE
echo "	<script src=\"../../../srcHTML/blank/reveal/plugin/zoom/zoom.js\"></script>" >> $TARGETFILE
echo "	<script>" >> $TARGETFILE
echo "let currentTheme=\"dark\"" >> $TARGETFILE
echo "let darkTheme=\"$SOURCEDIR/reveal/theme_white.css\"" >> $TARGETFILE
echo "let lightTheme=\"$SOURCEDIR/reveal/theme_black.css\"" >> $TARGETFILE
echo "		Reveal.initialize({" >> $TARGETFILE
echo "			controls: false, center: true, hash: false," >> $TARGETFILE
echo "			// Learn about plugins: https://revealjs.com/plugins/" >> $TARGETFILE
echo "			plugins: [ RevealZoom ]" >> $TARGETFILE
echo "		});" >> $TARGETFILE
echo "	</script>" >> $TARGETFILE
echo "</body>" >> $TARGETFILE
echo "</html>" >> $TARGETFILE


echo "    <!--}}}footer-->" >> $TARGETFILE

