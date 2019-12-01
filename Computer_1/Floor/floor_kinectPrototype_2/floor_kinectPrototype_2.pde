//Adopted from Daniel Shiffman https://www.youtube.com/watch?v=7eBLAgT0yUs
//Created by Miya Fordah
//Edited Nov 17th, 2019
//added kinect funtionality for 1 person
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myBroadcastLocation; 
Particle[] particle = new Particle[1000];
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
