//{{{variable declarations
"use strict";
let timeStamp;
let context_bgX;
let bgX;
let img_bgX;
let sprite,spriteNum;
let movX, movY;
let jumpSound, fallSound, callSound, settleSound, winSound;
let sourceDir;
//let isCalled = false;
let isCalled = false;
let isMute=false;
let nTab;
;//}}}variable declarations

//{{{event listeners
window.addEventListener("DOMContentLoaded", initWin);
window.addEventListener("resize", initWin);
window.addEventListener("keydown", evalKey, false); //capture keypress on bubbling (false) phase
document.addEventListener('contextmenu', event => event.preventDefault()); //disable right click
function evalKey(evnt) {
    let keyPressed = evnt.keyCode;
    // console.log ("Pressed: ",keyPressed);

    switch (keyPressed) {
       case 75  : if(!evnt.shiftKey) parent.postMessage("hideKlyne","*");
       case 87  : if(!evnt.shiftKey) parent.postMessage("FocusSeq","*");
                  else parent.postMessage("FocusTool","*"); 
                  break; //key: w
       case 82  : window.location.reload(); 
                  break; //key: r
       case 48  : if (!isCalled)callKlyne(); break; //key: 0
       case 49  : if (!isCalled)callKlyne();
									else spriteJump("1");
												break; //key: 1
       case 65  : if (!isCalled)callKlyne();
									else spriteJump("1");
												break; //key: a
       case 50  : if (isCalled) spriteJump("2");break; //key: 2
       case 66  : if (isCalled) spriteJump("2");break; //key: b
       case 51  : if (isCalled) spriteJump("3");break; //key: 3
       case 67  : if (isCalled) spriteJump("3");break; //key: c
       case 52  : if (isCalled) spriteJump("4");break; //key: 4
       case 68  : if (isCalled) spriteJump("4");break; //key: d
       case 53  : if (isCalled) spriteJump("5");break; //key: 5
       case 69  : if (isCalled) spriteJump("5");break; //key: e
       case 78  : if (!evnt.ctrlKey) duplNewTab();break; //key: n
       // case 37  : if (isCalled) spriteJump("down"); break; //key: right
       // case 39  : if (isCalled) spriteJump("up"); break; //key: left
       default  : return;
    } //switch (keyPressed)

} //evalKey(event)

window.addEventListener('message', evalMessage);
function evalMessage (evnt) {
    // Get the sent data
    var data = evnt.data;
    //console.log ("message received");

    if (data == "FocusIframe") {
        //console.log("focusDummy");
        document.getElementById('dummy').focus();
    }

    if (data == "FocusAltIframe") {
        //console.log("focusDummy");
        document.getElementById('dummy').focus();
    }

    if (data == "startMrK") {
        isMute = true;
        callKlyne(); 
        isMute = false;
    }

} //function evalMessage(event)

//}}}event listeners

//{{{window init
//make sure elements are loaded before proceeding
const checkElement = async selector => {
  while ( document.querySelector(selector) === null) {
    await new Promise( resolve =>  requestAnimationFrame(resolve) )
  } //while ( document.querySelector(selector) === null)
  return document.querySelector(selector); 
}; //const checkElement = async selector

function initWin() {
    //Get a reference to the canvas
    //checkElement('backgroundX').then((selector) => { console.log(selector); });

    bgX = document.getElementById('backgroundX');
    sprite = document.getElementById('sprite');
    spriteNum = 1;

    //Get project source
    sourceDir = document.getElementById("srcdir").innerHTML;

    jumpSound = new sound(sourceDir+"wav/jump.mp3");
    fallSound = new sound(sourceDir+"wav/fall.mp3");
    //callSound = new sound(sourceDir+"wav/call.mp3");
    settleSound = new sound(sourceDir+"wav/settle.mp3");
    winSound = new sound(sourceDir+"wav/win.mp3");
    callSound = new sound(sourceDir+"wav/call.mp3");

    window.removeEventListener("DOMContentLoadedl", initWin);
} //function init()

function resizeElements() {
    bgX.width = 0.8*window.innerWidth;
    bgX.height = 0.8*window.innerHeight;
} //function resizeCanvas()

function animateLoop(timeStamp) {

    //set delay between executions
    setTimeout (function() {
        window.requestAnimationFrame(animateLoop);
    }, 100);//setInterval (function()

} //function animateLoop(timeStap)
//}}}window init

//{{{handler functions
async function duplNewTab() {
    nTab = window.open(sourceDir+'klyne.html','_blank');
    if (!isMute) callSound.start();

    await delay (150);
    nTab.postMessage("startMrK", "*");

} //function newTab()

function callKlyne() {
    if (!isMute) callSound.start();
    insertCss ("#guidemsg {display: none;}");
    insertCss (".spriteClass {display: block;}");
    bgX.src = (sourceDir+"img/BG1.webp");
    isCalled = true;
} //function callKlyne()
function spriteJump(jumpDirection) {

		let beforeJump;
    // console.log ("spriejump ",jumpDirection);
    if (jumpDirection=="up") {
        jumpSound.start();
        spriteNum++;
        //console.log("jump up");
        if (spriteNum==6) spriteNum=5;
    } //if (jumpDirection=="up)
    if (jumpDirection=="down") {
        fallSound.start();
        settleSound.stop();
        spriteNum--;
        // console.log("jump down");
        if (spriteNum==0) spriteNum=1;
    } //if (jumpDirection=="down)
    if (jumpDirection=="1" || jumpDirection=="2"  || jumpDirection=="3" || jumpDirection=="4" || jumpDirection=="5" ) {
				beforeJump = spriteNum;
				spriteNum = Number(jumpDirection);
				if  (beforeJump < spriteNum ) { jumpSound.start(); jumpDirection="up"; }
				if  (beforeJump > spriteNum ) { fallSound.start(); settleSound.stop(); }
		} //if jumpDirection=="1"
    //console.log("spriteNum: "+spriteNum);

    movX = [0, 1*15, 2*15+1 , 3*15+2, 4*15+3];
    movY = [0, 1*-10, 2*-10, 3*-10, 4*-10+1];
    //sprite.style.cssText ="transform: translate("+movX[spriteNum-1]+"vw,"+movY[spriteNum-1]+"vh);transition: transform 900ms;";
    // console.log ("#sprite {transform: translate("+movX[spriteNum-1]+"vw,"+movY[spriteNum-1]+"vh);}");
    insertCss ("#sprite {transform: translate("+movX[spriteNum-1]+"vw,"+movY[spriteNum-1]+"vh);}");
    
    setTimeout (function() {
        sprite.src =sourceDir+"img/sprite"+spriteNum+".webp"; 
        if (spriteNum==5) {
            bgX.src =sourceDir+"img/BG6.webp"; 
            winSound.play();
        }// if spriteNum == 5)
        if ( (spriteNum<5) && (jumpDirection=="up") ) settleSound.play();
    }, 900);//setInterval (function()


} //function spriteJump(direction)


//}}}handler functions

//{{{helper functions
function sound(src) {
    this.sound = document.createElement("audio");
    this.sound.src = src;
    this.sound.setAttribute("preload", "auto");
    this.sound.setAttribute("controls", "none");
    this.sound.style.display = "none";
    document.body.appendChild(this.sound);
    this.start = function(){
        this.sound.pause();
        this.sound.currentTime = 0;
        this.sound.play();
    } //this.start = function(){
    this.play = function(){
        this.sound.play();
    } //this.play = function(){
    this.stop = function(){
        this.sound.pause();
        this.sound.currentTime = 0;
    }//this.stop = function(){    
}//function sound(src)

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
