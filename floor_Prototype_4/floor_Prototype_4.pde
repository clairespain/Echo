//Adopted from Daniel Shiffman https://www.youtube.com/watch?v=7eBLAgT0yUs
//Created by Miya Fordah
//Edited Nov 2nd, 2019

Particle[] particle = new Particle[500];
Boolean force = false;

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
    if (force) {
      particle[i].scatter();
    }
    particle[i].update();
    particle[i].velocity();
    particle[i].display();
  }
}


void mousePressed() {
  force = true;
}

void mouseReleased() {
  force = false;
}
