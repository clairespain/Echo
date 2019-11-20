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
int x = 800;
int y = 450;
int i =0;
int z =0;

void setup()
{
    size(1600, 1000);
    socket = new WebsocketServer(this, 1337, "/p5websocket");
    mouthImages = loadStrings("vouth.txt");
    //fullScreen();
    createAllAnimationArrays();

    //vouthAni= loadStrings("data/vouth.txt");

    //createAllAnimationsArrays();
    minim = new Minim(this);

    in = minim.getLineIn(Minim.STEREO, width);
}


void draw()
{
    //background(0);
    fill(0, 0);
    rect(0, 0, width, height);
    strokeWeight(5);
    stroke(255);
    //if ( key == 'l' ) in();
    //displayAnimation();
    for (int i = 0; i < in.left.size() - 1; i++)
    {
        line(i, height/2 - 100  + in.left.get(i)*500, i+1, height/2 - 100  + in.left.get(i+1)*50);
        line(i, height/2 + 50 + in.right.get(i)*500, i+1, height/2 + 50 + in.right.get(i+1)*50);
    }
    //mouthImages.resize(100, 50);
    //image(myVouthAni[16],width/2, height/2);
    //vouthAnimation();
}

void webSocketServerEvent(String msg) {
    println(msg);
    //textSize(24);
    fill(0, 0, 255);
    //textFont('Georgia');
    //textAlign(CENTER);
    text(msg, 100, 100);
    tts.speak(msg);
    
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

//void createAllAnimationsArrays() {
// for (int i=0; i<myVouthAni.length; i++) {
//  //myVouthAni[i]=loadImage("data/"+vouthAni[i]);
//  //stuff = image(myVouthAni[i],200,200);
//  //vouthArrayList.add(myVouthAni[i]);

// }

//}

//void vouthAnimation(){ 
//  int i = 0;
//  for(int j=0;j<vouthArrayList.size();j++){
//    image(vouthArrayList.get(j),200,200);

//  }
//}
