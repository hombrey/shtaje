//{{{variable declarations
"use strict";
let helpHandle;
let sourceDir, assetDir;
;//}}}variable declarations

//{{{event listeners
window.addEventListener("resize", initWin);
window.addEventListener("keydown", evalKeyDown, true); //capture keypress on bubbling (false) phase
window.addEventListener("DOMContentLoaded", initWin);
window.addEventListener("keyup", evalKeyUp, false); //capture keypress on bubbling (false) phase

function evalKeyUp(evnt) {
    let keyReleased = evnt.keyCode;
    switch (keyReleased) {

        case 8 : evnt.preventDefault();
                 if(!event.shiftKey) {
                     parent.postMessage("draw","*"); 
                     pentool("hide");
                 } else { parent.postMessage("noDraw","*"); 
                     pentool("hide");
                 } //if shiftkeya; 
                 break; //key: <backspace>

        case 112  : evnt.preventDefault(); helpHandle.className="hiddenHelp"; break; //key: F1

        default : return;
    } //switch (keyPressed)
}//evalKeyUp

function evalKeyDown(evnt) {
    let keyPressed = evnt.keyCode;
    // console.log ("Pressed2:", keyPressed);
    switch (keyPressed) {
       case 87  : if(!evnt.shiftKey) parent.postMessage("FocusSeq","*");
                  else parent.postMessage("FocusTool","*"); 
                  break; //key: w
       case 220  : if(evnt.ctrlKey) location.reload();
                  break; //key: \
       case 66  : if (evnt.ctrlKey) toggleTheme(); break; //key: b
        case 112  : evnt.preventDefault(); helpHandle.className="unhiddenHelp"; break; //key: F1
        case 8 : evnt.preventDefault(); 
                    parent.postMessage("noDraw","*"); 
                    pentool("show");
                break; //key: <backspace>

        default : return;
    } //switch (keyPressed)
} //evalKey(event)

//}}}event listeners

//{{{window init
function initWin() {

    //Get project source
    sourceDir = document.getElementById("srcdir").innerHTML;

    // window.addEventListener("keydown", evalKeyDown, false); //capture keypress on bubbling (false) phase

    createHelpWindow();
    createPentool();
} //function init()

//}}}window init

//{{{handler functions

window.addEventListener('message', evalMessage);
function evalMessage (evnt) {
    // Get the sent data
    var data = evnt.data;
    //console.log ("message received");

    if (data == "FocusIframe") {
        //console.log("focusDummy");
        document.getElementById('dummy').focus();
    }
} //function evalMessage(event)

function toggleTheme ()  {
	if (currentTheme=="dark") {
		console.log ("toggle theme ",currentTheme)
		document.getElementById("revealTheme").setAttribute("href",lightTheme);
		return true;
	} else {
		console.log ("toggle theme ",currentTheme)
		document.getElementById("revealTheme").setAttribute("href",darkTheme);
		return true;
	} // if (currentTheme="dark")
} // function toggleTheme () 
//}}}handler functions

//{{{draw functions
function createPentool() {

    const divtoolC = document.createElement('div');
    divtoolC.setAttribute('id','pentool');
    divtoolC.setAttribute('class','hiddenTool');
    document.body.appendChild(divtoolC);

    const undoButtonC = document.createElement('button');
    undoButtonC.setAttribute('id','undoButton'); undoButtonC.setAttribute('class','stroke-color');
    undoButtonC.setAttribute('onclick','drawRestore()');
    undoButtonC.innerHTML="Z";
    divtoolC.appendChild(undoButtonC);

    const clearButtonC = document.createElement('button');
    clearButtonC.setAttribute('id','clearButton'); clearButtonC.setAttribute('class','stroke-color');
    clearButtonC.setAttribute('onclick','drawClear()');
    clearButtonC.innerHTML="C";
    divtoolC.appendChild(clearButtonC);

    const c1ButtonC = document.createElement('button');
    c1ButtonC.setAttribute('id','color1'); c1ButtonC.setAttribute('class','stroke-color');
    c1ButtonC.setAttribute('style','background:black'); c1ButtonC.setAttribute('onclick','drawColor(1)');
    divtoolC.appendChild(c1ButtonC);

    const c2ButtonC = document.createElement('button');
    c2ButtonC.setAttribute('id','color2'); c2ButtonC.setAttribute('class','stroke-color');
    c2ButtonC.setAttribute('style','background:red'); c2ButtonC.setAttribute('onclick','drawColor(2)');
    divtoolC.appendChild(c2ButtonC);

    const c3ButtonC = document.createElement('button');
    c3ButtonC.setAttribute('id','color3'); c3ButtonC.setAttribute('class','stroke-color');
    c3ButtonC.setAttribute('style','background:yellow'); c3ButtonC.setAttribute('onclick','drawColor(3)');
    divtoolC.appendChild(c3ButtonC);

    const c4ButtonC = document.createElement('button');
    c4ButtonC.setAttribute('id','color4'); c4ButtonC.setAttribute('class','stroke-color');
    c4ButtonC.setAttribute('style','background:green'); c4ButtonC.setAttribute('onclick','drawColor(4)');
    divtoolC.appendChild(c4ButtonC);

    const c5ButtonC = document.createElement('button');
    c5ButtonC.setAttribute('id','color5'); c5ButtonC.setAttribute('class','stroke-color');
    c5ButtonC.setAttribute('style','background:blue'); c5ButtonC.setAttribute('onclick','drawColor(5)');
    divtoolC.appendChild(c5ButtonC);

    const c6ButtonC = document.createElement('button');
    c6ButtonC.setAttribute('id','color6'); c6ButtonC.setAttribute('class','stroke-color');
    c6ButtonC.setAttribute('style','background:white'); c6ButtonC.setAttribute('onclick','drawColor(6)');
    divtoolC.appendChild(c6ButtonC);

} //function createPentool()

function pentool(action) {
    if (action=="show") {
        //deblog ("show pane");
        document.getElementById("pentool").className = "unhiddenTool";
        isPenToolHidden=false;
    } //if (action=="show")
    if (action=="hide") {
        //deblog ("show pane");
        document.getElementById("pentool").className = "hiddenTool";
        isPenToolHidden=true;
    } //if (action=="show")
} //function toggleShowPentool

function drawRestore() { parent.postMessage("undoDraw","*"); } //drawRestore()
function drawClear() { parent.postMessage("clearDraw","*"); } //drawClear()
function drawColor(colorInt) { 
        var intMsg="color"+colorInt;
        //deblog (intMsg);
        parent.postMessage(intMsg,"*"); 
} //drawColor()

//}}} draw functions

//{{{helper functions

function insertCss( code ) {
    var style = document.createElement('style');
    style.innerHTML = code;

    document.getElementsByTagName("head")[0].appendChild( style );
} //function insertCss( code)

function delay(n) {  
        n = n || 2000;
        return new Promise(done => {
                setTimeout(() => {
                        done();
                        }, n);
            });
}//function delay()

function createHelpWindow() {
    helpHandle = document.createElement('iframe');
    helpHandle.setAttribute('id','myHelpFrame');
    helpHandle.setAttribute('class','hiddenHelp');
    helpHandle.setAttribute('src',sourceDir+'help.html');
    document.body.appendChild(helpHandle);
} //function createHelpWindow()

//}}}helper functions
