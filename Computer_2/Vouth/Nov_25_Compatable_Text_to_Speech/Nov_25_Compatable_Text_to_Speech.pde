//Author: Claire Spain
//Updated: 2 Dec 2019
//Purpose: Second Sketch Monitor for Interactive Media Project 3; Vouth


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
String[] mouthImages;
PImage[] myMouthImages = new PImage[21];
PImage myGalaxy;
PImage myVignette;
int x;
int y;
int i =0;
int z =0;
color lineRed = color(255, 0, 0);
color lineBlue = color(0, 0, 255);
color linePurple= color(255, 0, 255);
int speed = 10; 
String msg;
ArrayList<MessageSystem> system;

void setup()
{
  //size(width, height);
  fullScreen(1);
  smooth();
  x = width/2;
  y = height/2;
  socket = new WebsocketServer(this, 1337, "/p5websocket");
  mouthImages = loadStrings("vouth.txt");
  myGalaxy = loadImage("galaxy_1.png");
  myGalaxy.resize(width, height);
  myVignette = loadImage("vignette.png");

  //georgia = createFont("Georgia", 30);
  createAllAnimationArrays();


  minim = new Minim(this);

  in = minim.getLineIn(Minim.MONO, width);
  tts = new TTS();

  system = new ArrayList<MessageSystem>();
}


void draw()
{
  background(myGalaxy);
  strokeWeight(5);
  //stroke(lerpColor(lineBlue, lineRed, (((millis()/5000)%2==0)?millis():5000-millis())/5000.0));
  stroke(lineBlue);
  for (int i = 0; i < in.left.size() - 1; i++)
  {
    line(i, height/2 + in.left.get(i)*500, i+1, height/2 + in.left.get(i+1)*50);
    if (in.left.get(i)>=0.070) {
      speed=1; 
      stroke(lineRed);
    } else if (in.left.get(i)>=0.05&&in.left.get(i)<0.070) {
      speed=5;
      stroke(linePurple);
    } else {
      speed=20; 
      //stroke(lineBlue);
    }
    //System.out.println(speed);
  }
  displayAnimation();
  for (MessageSystem ps : system) {
    ps.run();
  }
  image(myVignette, width/2, height/2);
  myVignette.resize(width, height * 2);
}

void webSocketServerEvent(String msg) {

  println  (msg);
  this.msg = msg;

  system.add(new MessageSystem(new PVector(random(100, width-100), random(100, height-100))));
}

void createAllAnimationArrays() {
  for (int i=0; i <myMouthImages.length; i++)
  {
    myMouthImages[i] = loadImage(mouthImages[i]);
  }
}

void displayAnimation()
{

  image(myMouthImages[i], x, y);
  if (z>=speed) {
    i++;
    z=0;
  }
  z++;
  if (i == 20)
  {
    i=0;
  }

  imageMode(CENTER);
}
