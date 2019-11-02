class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float locX;
  float locY;
  float velocityLimit;
  float mouseDistance;

  Particle( float locX, float locY) {
    this.locX = locX;
    this.locY = locY;
    location = new PVector(locX, locY);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    mouse.sub(location);
    mouse.setMag(0.1);
    acceleration = mouse;

    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(velocityLimit);
  }

  void velocity() {
    mouseDistance = dist(mouseX, mouseY, location.x, location.y);
    if (mouseDistance < 100) {
      velocityLimit = 5;
    } else if (mouseDistance < 150) {
      velocityLimit = 4;
    } else if (mouseDistance < 200) {
      velocityLimit = 3;
    } else if (mouseDistance < 250) {
      velocityLimit = 2;
    } else if (mouseDistance < 300) {
      velocityLimit = 1.5;
    } else if (mouseDistance < 350) {
      velocityLimit = 1;
    } else if (mouseDistance < 400) {
      velocityLimit = .5;
    } else if (mouseDistance < 450) {
      velocityLimit =.25;
    } else {
      velocityLimit = 0;
    }
  }

  void scatter() {
    location.x += (int)random(-20, 20);
    location.y += (int)random(-20, 20);
  }

  void display() {
    fill(255);
    circle(location.x, location.y, 5);
  }
}
