//{{{variable declarations
let urlNow;
let assetDir,srcDir;
let mamSelect,choiSelect,laSelect;
let fgX;
//}}}variable declarations

// window.onload = initWin();
window.addEventListener("DOMContentLoaded", initWin);
function initWin() {

    // await delay (40);

    srcDir = document.getElementById("srcdir").innerHTML; 
    //Get location of lesson assets
    assetDir = document.getElementById("assetdir").innerHTML;

    mamSelect = document.getElementById("selectMam");
    choiSelect = document.getElementById("selectChoi");
    laSelect = document.getElementById("selectLa");
    othersSelect = document.getElementById("selectOthers");
    fgX = document.getElementById("foregroundX");

    mamSelect.focus();
    fgX.src=srcDir+"img/mam.webp";
} //function initWin()

window.addEventListener("keydown", evalKeyDown2, false); //capture keypress on bubbling (false) phase
function evalKeyDown2(evnt) {
    let keyPressed = evnt.keyCode;
    //console.log ("Pressed2:", keyPressed);
    switch (keyPressed) {
    case 13 :  evnt.preventDefault();
                openNewTab(urlNow);
                break; //return
    case 83  : window.open ("./SongsHTML/0_Songs.html","_self"); break; //key: s
    // case 75  : window.open ("./srcHTML/Klyne/klyne.html","_self"); break; //key: k
    case 77 : if(!event.shiftKey) mamSelect.focus(); 
                fgX.src=srcDir+"img/mam.webp";
               break; //key: m
    case 67 : if(!event.shiftKey) choiSelect.focus(); 
                fgX.src=srcDir+"img/choi.webp";
               break; //key: c
    case 76 : if(!event.shiftKey) laSelect.focus(); 
               fgX.src=srcDir+"img/la.webp";
             break; //key: l
    case 79 : if(!event.shiftKey) othersSelect.focus(); 
               fgX.src=srcDir+"img/others.webp";
             break; //key: o
    case 87  : if(!event.shiftKey) parent.postMessage("FocusSeq","*");
                else parent.postMessage("FocusTool","*"); 
                break; //key: w
        default : return;
    } //switch (keyPressed)
} //evalKey(event)

window.addEventListener('message', evalMessage);
function evalMessage (evnt) {
    // Get the sent data
    var data = evnt.data;
    //console.log ("message received");

    if (data == "FocusIframe") {
        //console.log("focusDummy");
        document.getElementById('selectbox').focus();
    }
} //function evalMessage(event)

function openNewTab(urlvalue) {
    //window.open(urlvalue,'_blank');
    window.open(urlvalue,'_self');
} //function openNewTab(urlvalue)


function selectFile(urlvalue) {
    urlNow = urlvalue;
} //function openNewTab(urlvalue)

//{{{helper functions
function createHelpWindow() {
    helpHandle = document.createElement('iframe');
    helpHandle.setAttribute('id','myHelpFrame');
    helpHandle.setAttribute('class','hiddenHelp');
    helpHandle.setAttribute('src',srcDir+'help.html');
    document.body.appendChild(helpHandle);
} //function createHelpWindow()

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
    this.pause = function(){
        this.sound.pause();
    } //this.play = function(){
    this.play = function(){
        this.sound.play();
    } //this.play = function(){
    this.stop = function(){
        this.sound.pause();
        this.sound.currentTime = 0;
        isPaused = true;
    }//this.stop = function()    
    this.sound.onended = function () {
        isPaused = true;
        pauseIndicator.style.display = "none";
    }; //sound.onended
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
