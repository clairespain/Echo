class Fish{
  private float fishX;
  private float fishY;
  private float moveX;
  private float moveY;
  
  
  public Fish(float fishX, float fishY, float moveX, float moveY){
    this.fishX = fishX;
    this.fishY = fishY;
    this.moveX = moveX;
    this.moveY = moveY;
  }
  

  void draw(){ 
   
    
    
    
    PVector p = new PVector( mouseX-fishX, mouseY-fishY, 0);
    p.limit(10);
    
    if (dist(mouseX, mouseY, fishX, fishY) < 300) {
      translate(fishX-p.x, fishY-p.y);
     // moveX = moveX + 0;
     // moveY = moveY + 0;
      fishX -= p.x;
      fishY -= p.y;
    }//else{
     // moveX = moveX + 0.001;
     // moveY = moveY + 0.001;
     // fishX = moveX;
     // fishY = moveY;
   // }
    
    fishX = constrain(fishX, 100, width-100);
    fishY = constrain(fishY, 100, height-100);
    
    fill(255);
    noStroke();
    circle(fishX, fishY,5); 
    
    println(fishX);
  }
 
}
