//Author: Claire Spain
//Updated: 12 Nov 2019
//Purpose: Second Sketch Monitor for Interactive Media Project 3; Lips


import ddf.minim.*;
import websockets.*;
import guru.ttslib.*;
WebsocketServer socket;
Minim minim;
TTS tts;

//AudioPlayer song;
int amplification = 12;

//Microphone
AudioInput in;

//Put Mouth Ani and other visuals in here...
String[] mouthImages;
PImage[] myMouthImages = new PImage[6];
int x;
int y;
int i =0;
int z =0;
color lineRed = color(255, 0, 0);
color lineBlue = color(0, 0, 255);

String msg;
ArrayList<MessageSystem> system;

//PFont georgia;

void setup()
{
  size(1600, 1000);
  x = width/2;
  y = height/2;
  socket = new WebsocketServer(this, 1337, "/p5websocket");
  mouthImages = loadStrings("vouth.txt");
  //georgia = createFont("Georgia", 30);

  //fullScreen();
  createAllAnimationArrays();


  minim = new Minim(this);

  in = minim.getLineIn(Minim.STEREO, width);
  tts = new TTS();

  system = new ArrayList<MessageSystem>();
}


void draw()
{
  background(0);
  fill(0, 0);
  rect(0, 0, width, height);
  strokeWeight(5);
  stroke(lerpColor(lineBlue, lineRed, (((millis()/5000)%2==0)?millis():5000-millis())/5000.0));
  displayAnimation();
  for (int i = 0; i < in.left.size() - 1; i++)
  {
    //line(i, height/2 - 100  + in.left.get(i)*500, i+1, height/2 - 100  + in.left.get(i+1)*50);
    //line(i, height/2 + 50 + in.right.get(i)*500, i+1, height/2 + 50 + in.right.get(i+1)*50);
    line(i, height/2 + in.left.get(i)*500, i+1, height/2 + in.left.get(i+1)*50);
  }

  for (MessageSystem ps : system) {
    ps.run();
  }
  //mouthImages.resize(100, 50);
  //image(myVouthAni[16],width/2, height/2);
  //vouthAnimation();
}

void webSocketServerEvent(String msg) {
  String hello = "hello";
  String hello2 = " hello";
  String hi = "hi";
  String hi2 = " hi";

  println(msg);
  this.msg = msg;

  //textSize(24);
  //fill(0, 0, 255);
  //textFont("Georgia");
  //textAlign(CENTER);
  //text(msg, 100, 100);//(int)random(100, width-100), (int)random(100, height-100));

  system.add(new MessageSystem(new PVector(random(100, width-100), random(100, height-100))));
  
  //if (msg.indexOf("hello")>=0||msg.indexOf("hi")>=0){
  if (msg.equals(hello)||msg.equals(hello2)||msg.equals(hi)||msg.equals(hi2)) {
    tts.speak("Hello, and welcome");
  } else {
    tts.speak(msg);
  }
}

void createAllAnimationArrays() {
  for (int i=0; i <myMouthImages.length; i++)
  {
    myMouthImages[i] = loadImage(mouthImages[i]);
  }
}

void displayAnimation()
{
  //translate( width/2, height/2);
  //(scale) = 2;
  image(myMouthImages[i], x, y);
  if (z==7) {
    i++;
    z=0;
  }

  z++;
  if (i == 5)
  {
    i=0;
  }
  imageMode(CENTER);
  //resize(100, 50);
}
