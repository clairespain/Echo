class Messages {
  PVector position;
  float lifespan;
  //float x;
  //float y;
  float moveX;
  float moveY;
  
  String message = msg;



  Messages(PVector l) {
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  void update() {
    lifespan -= 0.5;
  }

  void display() {
    fill(255, 255, 255, lifespan);

    //textFont(georgia);
    textSize(30);
    textAlign(CENTER);
    text(message, position.x, position.y);
    //println(position.x, position.y);
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
