//Adopted from Daniel Shiffman https://www.youtube.com/watch?v=7eBLAgT0yUs
//Sound adopted from akenaton @ https://forum.processing.org/two/discussion/8949/how-do-i-play-a-random-audio-sample
//Created by Miya Fordah
//Edited Nov 17th, 2019
//added kinect funtionality for 2 people  
import oscP5.*;
import netP5.*;
import ddf.minim.*;

AudioPlayer player;
Minim minim;
boolean playeurInit = false;// que leplayer n'est pas lancé
boolean stop = true;

StringList tableau;
int current=0;

OscP5 oscP5;
NetAddress myBroadcastLocation; 
Particle[] particle = new Particle[500];
Boolean shake = false;
Boolean scatter = false;
Boolean blackHole = false;

float[] partX = new float[4];
float[] partY = new float[4];

void setup() {
  //size(1000, 1000);
  fullScreen();
  oscP5 = new OscP5(this, 7000);
  myBroadcastLocation = new NetAddress("127.0.0.1", 7000);

  minim = new Minim(this);

  //ADD sound files to your list
  tableau=new StringList();
  tableau.append("particle_note1.mp3");
  tableau.append("particle_note2.mp3");
  tableau.append("particle_note3.mp3");
  tableau.append("particle_note4.mp3");
  tableau.append("particle_note5.mp3");
  tableau.append("particle_note6.mp3");
  tableau.append("particle_note7.mp3");
  tableau.append("particle_note8.mp3");
  tableau.append("particle_note9.mp3");
  tableau.append("particle_note10.mp3");

  shufflePlayList();
  String son = tableau.get(current++);
  println(son);
  player = minim.loadFile(son);
  player.pause();


  for (int i = 0; i < particle.length; i++) {
    particle[i] = new Particle((float)random(width), (float)random(height));
  }
}

void draw() {
  background(0);
  //OscMessage newMessage = new OscMessage("mouseX position");  
  //newMessage.add(mouseX); 
  //oscP5.send(newMessage, myBroadcastLocation);
  for (int i = 0; i < particle.length; i++) {
    if (shake) {
      particle[i].shake();
    } else if (scatter) {
      particle[i].scatter();
    }
    particle[i].update();
    particle[i].velocity();
    particle[i].display();
  }


  if (player.isPlaying() == false) {

    //CHECK we haven't exhausted the current shuffled(random) play list
    //If we have played all the songs, then re-shuffle the list
    if (current==tableau.size()-1) {
      shufflePlayList();
    }

    String son = tableau.get(current++);
    player = minim.loadFile(son);
    player.play();      
    playeurInit = true;
  }
}


void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/joint_Head_1") == true) {
    partX[0] = width * theOscMessage.get(0).floatValue();
    partY[0] = height/6 * theOscMessage.get(2).floatValue();
    theOscMessage.print();
  }

  if (theOscMessage.checkAddrPattern("/joint_Head_2") == true) {
    partX[1] = width * theOscMessage.get(0).floatValue();
    partY[1] = height/6 * theOscMessage.get(2).floatValue();
    theOscMessage.print();
  }

  if (theOscMessage.checkAddrPattern("/joint_Head_3") == true) {
    partX[2] = width * theOscMessage.get(0).floatValue();
    partY[2] = height/6 * theOscMessage.get(2).floatValue();
    theOscMessage.print();
  }

  if (theOscMessage.checkAddrPattern("/joint_Head_4") == true) {
    partX[3] = width * theOscMessage.get(0).floatValue();
    partY[3] = height/6 * theOscMessage.get(2).floatValue();
    theOscMessage.print();
  }
}

void stop() {

  player.close();//kill player
  minim.stop();//kill minim
  super.stop();//kill superClass audio Minim
}

void shufflePlayList() {
  current=0;
  tableau.shuffle();
}

void keyPressed() {
  if (key == '1') {
    scatter = true;
  } else if (key == '2') {
    shake = true;
  } else if ( key == '3') {
    blackHole = true;
  }
}

void keyReleased() {
  scatter = false;
  shake = false;
  blackHole = false;
}
