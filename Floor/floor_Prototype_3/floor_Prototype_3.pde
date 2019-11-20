Particle[] particle = new Particle[100];

void setup() {
  size(1000, 1000);
  for (int i = 0; i < particle.length; i++) {
    particle[i] = new Particle((float)random(width), (float)random(width));
  }
}

void draw() {
  background(0);
  for (int i = 0; i < particle.length; i++) {
    particle[i].update();
    particle[i].display();
  }
}
