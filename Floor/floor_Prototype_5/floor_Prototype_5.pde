//Adopted from Daniel Shiffman https://www.youtube.com/watch?v=7eBLAgT0yUs
//Created by Miya Fordah
//Edited Nov 6th, 2019

Particle[] particle = new Particle[1000];
Boolean shake = false;
Boolean scatter = false;
Boolean blackHole = false;

void setup() {
  //size(1000, 1000);
  fullScreen();
  for (int i = 0; i < particle.length; i++) {
    particle[i] = new Particle((float)random(width), (float)random(height));
  }
}

void draw() {
  background(0);
  for (int i = 0; i < particle.length; i++) {
    if (shake) {
      particle[i].shake();
    }else if (scatter) {
      particle[i].scatter();
    }
    particle[i].update();
    particle[i].velocity();
    particle[i].display();
  }
}


void keyPressed() {
  if(key == '1'){
    scatter = true;
  }else if (key == '2'){
    shake = true;
  }else if( key == '3'){
    blackHole = true;
  }
}

void keyReleased() {
  scatter = false;
  shake = false;
  blackHole = false;
  
}
