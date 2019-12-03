//Code adapted from TfGuy44
Fish[] fish = new Fish[20];

 
void setup(){ 
  size(1980, 1080);
    for(int i = 0; i < fish.length; i++)
  {
     fish[i] = new Fish(
       (float)random(100, 1880),
       (float)random(100, 980),
       (float)random(-10, 10),
       (float)random(-10, 10)
     ); 
  }
} 

void draw(){
  background(0);
  for(int i=0; i < fish.length; i++){
    fish[i].draw();
  } 
}
 
