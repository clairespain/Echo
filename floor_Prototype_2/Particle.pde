class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float locX;
  float locY;

  Particle( float locX, float locY) {
    this.locX = locX;
    this.locY = locY;
    location = new PVector(locX, locY);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void update() {
    //if (dist(mouseX, mouseY, location.x, location.y)< 200) {
      PVector mouse = new PVector(mouseX, mouseY);
      mouse.sub(location);
      mouse.setMag(0.1);
      acceleration = mouse;

      velocity.add(acceleration);
      location.add(velocity);
      velocity.limit(4);
    //}
  }

  void display() {
    stroke(255);
    circle(location.x, location.y, 5);
  }
}
