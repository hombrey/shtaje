//{{{variable declarations
"use strict";
let helpHandle;
let isPenToolHidden=true;
let sourceDir="void", assetDir;
;//}}}variable declarations

//{{{event listeners
window.addEventListener("resize", initWin);
window.addEventListener("keydown", evalKeyDown, true); //capture keypress on bubbling (false) phase
window.addEventListener("DOMContentLoaded", initWin);
window.addEventListener("keyup", evalKeyUp, false); //capture keypress on bubbling (false) phase

function evalKeyUp(evnt) {
    let keyReleased = evnt.keyCode;
    switch (keyReleased) {

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
        default : return;
    } //switch (keyPressed)
} //evalKey(event)

//}}}event listeners

//{{{window init
function initWin() {


    // window.addEventListener("keydown", evalKeyDown, false); //capture keypress on bubbling (false) phase
    createHelpWindow();
    // createPentool();
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
    //enable help if sourceDir is defined
    helpHandle = document.createElement('iframe');
    helpHandle.setAttribute('id','myHelpFrame');
    helpHandle.setAttribute('class','hiddenHelp');
		if (sourceDir!="void") helpHandle.setAttribute('src',sourceDir+'help.html');
    document.body.appendChild(helpHandle);
} //function createHelpWindow()

//}}}helper functions
