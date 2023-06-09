//{{{variable declarations
"use strict";
;//}}}variable declarations

//{{{event listeners
window.addEventListener("resize", initWin);
window.addEventListener("keydown", evalKeyDown, false); //capture keypress on bubbling (false) phase
window.addEventListener("DOMContentLoaded", initWin);

function evalKeyDown(evnt) {
    let keyPressed = evnt.keyCode;
    //console.log ("Pressed2:", keyPressed);
    switch (keyPressed) {
       case 87  : if(!event.shiftKey) parent.postMessage("FocusSeq","*");
                  else parent.postMessage("FocusTool","*"); 
                  break; //key: w
        default : return;
    } //switch (keyPressed)
} //evalKey(event)

//}}}event listeners

//{{{window init
function initWin() {

    window.addEventListener("keydown", evalKeyDown, false); //capture keypress on bubbling (false) phase
    
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

//}}}helper functions
