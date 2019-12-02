//Adopted from Daniel Shiffman https://www.youtube.com/watch?v=7eBLAgT0yUs
//Sound adopted from akenaton @ https://forum.processing.org/two/discussion/8949/how-do-i-play-a-random-audio-sample
//Created by Miya Fordah
//Edited Nov 17th, 2019
//added kinect funtionality for 2 people  
import oscP5.*;
import netP5.*;
import ddf.minim.*;

AudioPlayer[] player = new AudioPlayer[10];
Minim minim;
boolean playeurInit = false;
boolean stop = true;
//set to false for kinect functionallity
boolean playerPresent = true;
int timeCheck = 0;
int timeThresh = 2000;
int noteIdx = 0;

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
  noCursor();
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

  //shufflePlayList();
  //String son = tableau.get(current++);
  //println(son);

  for (int i = 0; i < tableau.size(); i++) {

    player[i] = minim.loadFile(tableau.get(i));
    player[i].pause();
  }



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


  if (playerPresent) {

    if (player[noteIdx].isPlaying() == false) {

      //CHECK we haven't exhausted the current shuffled(random) play list
      //If we have played all the songs, then re-shuffle the list
      //if (current==tableau.size()-1) {
      //shufflePlayList();
      //}

      //String son = tableau.get(current++);
      //player = minim.loadFile(son);
      player[noteIdx].cue(0);
      player[noteIdx].play();
      playeurInit = true;
    } else if (player[noteIdx].position() + player[noteIdx].bufferSize() >= player[noteIdx].length()) {
      player[noteIdx].pause();
      noteIdx = (int)random(9);
    }
    
    if(timeCheck > timeThresh){ playerPresent = false;}
  }
  //println(player[0].isPlaying(), player[0].isLooping());
  //println(player[0].position(), player[0].length());
}

void oscEvent(OscMessage theOscMessage) {

  //set to false for kinect functionallity
  //playerPresent = true;

  if (theOscMessage.checkAddrPattern("/joint_Head_1") == true) {
    partX[0] = width * theOscMessage.get(0).floatValue();
    partY[0] = height/6 * theOscMessage.get(2).floatValue();
    //theOscMessage.print();
    playerPresent = true;
  }

  if (theOscMessage.checkAddrPattern("/joint_Head_2") == true) {
    partX[1] = width * theOscMessage.get(0).floatValue();
    partY[1] = height/6 * theOscMessage.get(2).floatValue();
    //theOscMessage.print();
    playerPresent = true;
  }

  if (theOscMessage.checkAddrPattern("/joint_Head_3") == true) {
    partX[2] = width * theOscMessage.get(0).floatValue();
    partY[2] = height/6 * theOscMessage.get(2).floatValue();
    //theOscMessage.print();
    playerPresent = true;
  }

  if (theOscMessage.checkAddrPattern("/joint_Head_4") == true) {
    partX[3] = width * theOscMessage.get(0).floatValue();
    partY[3] = height/6 * theOscMessage.get(2).floatValue();
    //theOscMessage.print();
    playerPresent = true;
  }
  
  if(playerPresent){
    timeCheck = millis();
  }
}

//void stop() {

//  player.close();//kill player
//  minim.stop();//kill minim
//  super.stop();//kill superClass audio Minim
//}

//void shufflePlayList() {
//  current=0;
//  tableau.shuffle();
//}

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
