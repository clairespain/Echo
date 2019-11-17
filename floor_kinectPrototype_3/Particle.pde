class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float locX;
  float locY;
  float velocityLimit;
  float p0Distance;
  float p1Distance;
  float p2Distance;
  float p3Distance;
  //float size = random(.5, 4);
  //int red = (int)random(200, 255);
  //int green = (int)random(200, 255);
  //int blue = (int)random(200, 255);

  Particle(float locX, float locY) {
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
    PVector p0 = new PVector(partX[0], partY[0]);
    PVector p1 = new PVector(partX[0], partY[0]);
    PVector p2 = new PVector(partX[0], partY[0]);
    PVector p3 = new PVector(partX[0], partY[0]);
    PVector center = new PVector(width/2, height/2);
    PVector stop = new PVector(0, 0);
    p0.sub(location);
    p0.setMag(0.25);
    p1.sub(location);
    p1.setMag(0.25);
    p2.sub(location);
    p2.setMag(0.25);
    p3.sub(location);
    p3.setMag(0.25);
    center.sub(location);
    center.setMag(0.25);
    //acceleration = mouse;
    p0Distance = dist(partX[0], partY[0], location.x, location.y);
    p1Distance = dist(partX[1], partY[1], location.x, location.y);
    p2Distance = dist(partX[2], partY[2], location.x, location.y);
    p3Distance = dist(partX[3], partY[3], location.x, location.y);
    if (blackHole) {
      acceleration = center;
      velocityLimit = 20;
    } else if (p0Distance < 100) {
      acceleration = p0;
      velocityLimit = 8;
    } else if (p1Distance < 100) {
      acceleration = p1;
      velocityLimit = 8;
    } else if (p0Distance < 110) {
      acceleration = p0;
      velocityLimit = 3;
    } else if (p1Distance < 110) {
      acceleration = p1;
      velocityLimit = 3;
    } else if (p0Distance < 130) {
      acceleration = p0;
      velocityLimit = 2;
    } else if (p1Distance < 130) {
      acceleration = p1;
      velocityLimit = 2;
    }else if (p0Distance < 150) {
      acceleration = p0;
      velocityLimit = 1;
    } else if (p1Distance < 150) {
      acceleration = p1;
      velocityLimit = 1;
    }else if (p0Distance < 200) {
      acceleration = p0;
      velocityLimit = .75;
    } else if (p1Distance < 200) {
      acceleration = p1;
      velocityLimit = .75;
    }else if (p0Distance < 250) {
      acceleration = p0;
      velocityLimit = .5;
    } else if (p1Distance < 250) {
      acceleration = p1;
      velocityLimit = .5;
    }else if (p0Distance < 300) {
      acceleration = p0;
      velocityLimit = .25;
    } else if (p1Distance < 300) {
      acceleration = p1;
      velocityLimit = .25;
    }else {
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
