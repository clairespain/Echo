class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float locX;
  float locY;
  float velocityLimit;
  float mouseDistance;
  int red = (int)random(200, 255);
  int green = (int)random(200, 255);
  int blue = (int)random(200, 255);
  float size = (float)random(4, 6);

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
    PVector mouse = new PVector(mouseX, mouseY);
    PVector stop = new PVector(0, 0);
    mouse.sub(location);
    mouse.setMag(0.25);
    
    mouseDistance = dist(mouseX, mouseY, location.x, location.y);
    if (mouseDistance < 150) {
      acceleration = mouse;
      velocityLimit = 8;
    } else if (mouseDistance < 200) {
      acceleration = mouse;
      velocityLimit = 6;
    } else if (mouseDistance < 250) {
      acceleration = mouse;
      velocityLimit = 4;
    } else if (mouseDistance < 300) {
      acceleration = mouse;
      velocityLimit = 2;
    } else if (mouseDistance < 350) {
      acceleration = mouse;
      velocityLimit = 1.5;
    } else if (mouseDistance < 400) {
      acceleration = mouse;
      velocityLimit = 1;
    } else if (mouseDistance < 450) {
      acceleration = mouse;
      velocityLimit = .5;
    } else if (mouseDistance < 500) {
      acceleration = mouse;
      velocityLimit =.25;
    } else {
      acceleration = stop;
      velocityLimit = 0.0;
    }
  }

  void scatter() {
    //location.x += (int)random(-50, 50);
    //location.y += (int)random(-50, 50);
    acceleration = PVector.random2D();
    velocityLimit = 10;
    if(location.x <= -10 || location.x >= width + 10){
      location.x = random(0, width);
    }
    if(location.y <= -10 || location.y >= height + 10){
      location.y = random(0, height);
    }
  }

  void display() {
    fill(255);
    noStroke();
    //locX = constrain(location.x, 0, width);
    //locY = constrain(location.y, 0, height);
    circle(location.x, location.y, size);//(int)random(3, 10));
  }
}
