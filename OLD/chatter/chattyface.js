
// Katie Holmgren
// 340 Principles of Interactive Media, Project 3
// Generative Text Visuals using p5.speech.js


var foo = new p5.SpeechRec(); // speech recognition object (will prompt for mic access)
foo.onResult = showResult; // bind callback function to trigger when speech is recognized
let continuous = true;
let interim = true;
let interimResults= true;
foo.start(continuous, interim); // start listening


function setup(){
  createCanvas(windowWidth, windowHeight);
  background(0);
  fill(255, 255, 255);
  textSize(24);
  textFont('Georgia');
  textAlign(CENTER);
}

function showResult(){
  if(foo.resultValue==true) {
  text(foo.resultString, random(width - 30), random(height - 30));
  console.log(foo.resultString);
  }
}
