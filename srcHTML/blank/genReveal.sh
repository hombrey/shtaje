#!/bin/bash

# extract the source directory from the command used to call this script
SOURCEDIR=`echo "${0%/*}"`
SOURCEROOT=`echo "${0%/*/*}"`
LESSONDIR=`pwd`

echo "<!DOCTYPE html>" > 0_rveal.html
echo "<html lang=\"en\">" >> 0_rveal.html
echo "<head>" >> 0_rveal.html
echo "	<meta charset=\"utf-8\"> " >> 0_rveal.html
echo "    <script src=\"$SOURCEDIR/functions.js\"></script> " >> 0_rveal.html
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/styles.css\">" >> 0_rveal.html
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/reveal/reveal.css\">" >> 0_rveal.html
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/reveal/fragments.css\">" >> 0_rveal.html
echo "    <link rel=\"stylesheet\" href=\"$SOURCEDIR/reveal/theme_white.css\">" >> 0_rveal.html


echo "</head>" >> 0_rveal.html
echo "<body>" >> 0_rveal.html
echo "    <select class=\"selectBox\" id=\"dummy\"><option>empty</option></select>" >> 0_rveal.html


echo "	<div class=\"reveal\"> <div class=\"slides\">" >> 0_rveal.html
echo "			<section data-background=\"#00000000\">" >> 0_rveal.html
echo "				<h2>Header</h2>" >> 0_rveal.html
echo "				<p class=\"fragment custom blur\">One</p>" >> 0_rveal.html
echo "				<p class=\"fragment custom blur\">Two</p>" >> 0_rveal.html
echo "			</section>" >> 0_rveal.html
echo "	</div> </div> <!-- reveal slides -->" >> 0_rveal.html
echo "" >> 0_rveal.html
echo "  <script src=\"../../../srcHTML/blank/functions.js\"></script> " >> 0_rveal.html
echo "	<script src=\"../../../srcHTML/blank/reveal/reveal.js\"></script>" >> 0_rveal.html
echo "	<script src=\"../../../srcHTML/blank/reveal/plugin/zoom/zoom.js\"></script>" >> 0_rveal.html
echo "	<script>" >> 0_rveal.html
echo "		Reveal.initialize({" >> 0_rveal.html
echo "			controls: false, center: true, hash: false," >> 0_rveal.html
echo "			// Learn about plugins: https://revealjs.com/plugins/" >> 0_rveal.html
echo "			plugins: [ RevealZoom ]" >> 0_rveal.html
echo "		});" >> 0_rveal.html
echo "	</script>" >> 0_rveal.html





echo "</body>" >> 0_rveal.html
echo "</html>" >> 0_rveal.html
