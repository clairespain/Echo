class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float locX;
  float locY;
  float velocityLimit;
  float mouseDistance;
  //float size = random(.5, 4);
  //int red = (int)random(200, 255);
  //int green = (int)random(200, 255);
  //int blue = (int)random(200, 255);

  Particle( float locX, float locY) {
    this.locX = locX;
    this.locY = locY;
    location = new PVector(locX, locY);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(velocityLimit);
  }

  void velocity() {
    PVector mouse = new PVector(partX[0], partY[0]);
    PVector center = new PVector(width/2, height/2);
    PVector stop = new PVector(0, 0);
    mouse.sub(location);
    mouse.setMag(0.25);
    center.sub(location);
    center.setMag(0.25);
    //acceleration = mouse;
    mouseDistance = dist(partX[0], partY[0], location.x, location.y);
    if (blackHole) {
      acceleration = center;
      velocityLimit = 20;
    } else if (mouseDistance < 100) {
      acceleration = mouse;
      velocityLimit = 8;
    } else if (mouseDistance < 110) {
      acceleration = mouse;
      velocityLimit = 3;
    } else if (mouseDistance < 130) {
      acceleration = mouse;
      velocityLimit = 2;
    } else if (mouseDistance < 150) {
      acceleration = mouse;
      velocityLimit = 1;
    } else if (mouseDistance < 200) {
      acceleration = mouse;
      velocityLimit = .75;
    } else if (mouseDistance < 250) {
      acceleration = mouse;
      velocityLimit = .5;
    } else if (mouseDistance < 300) {
      acceleration = mouse;
      velocityLimit = .25;
    } else {
      acceleration = stop;
      velocityLimit = 0.0;
    }
  }

  void scatter() {
    acceleration = PVector.random2D();
    velocityLimit = 10;
  }

  void shake() {
    location.x += (int)random(-20, 20);
    location.y += (int)random(-20, 20);
  }

  void display() {
    if (location.x <= -10 || location.x >= width + 10) {
      location.x = random(0, width);
    }
    if (location.y <= -10 || location.y >= height + 10) {
      location.y = random(0, height);
    }

    fill(255);
    noStroke();
    circle(location.x, location.y, 2.5);
  }
}
